# libs/poll_generator.py
import csv
import os
import random
import string
from datetime import datetime
from robot.api.deco import library, keyword


def _project_root() -> str:
    here = os.path.dirname(os.path.abspath(__file__))
    return os.path.abspath(os.path.join(here, os.pardir))


@library(scope="GLOBAL", version="1.0")
class PollGenerator:
    """Custom Robot Framework library for VibeCatch tests."""

    def __init__(self, csv_path: str = None):
        # Varsayılan CSV: <repo_root>/Resources/poll_names.csv  (CASE SENSITIVE!)
        if csv_path is None:
            csv_path = os.path.join(_project_root(), "Resources", "poll_names.csv")
        self.csv_path = csv_path
        self._names_cache = None

    def _load_names(self):
        if self._names_cache is not None:
            return self._names_cache
        if not os.path.exists(self.csv_path):
            raise FileNotFoundError(f"CSV not found: {self.csv_path}")
        names = []
        with open(self.csv_path, newline="", encoding="utf-8") as f:
            for row in csv.reader(f):
                if not row:
                    continue
                name = row[0].strip()
                if name:
                    names.append(name)
        if not names:
            raise ValueError(f"No names found in {self.csv_path}")
        self._names_cache = names
        return names

    @keyword("Generate Poll Name")
    def generate_poll_name(
        self,
        prefix: str = "",
        max_length: int = 60,
        ensure_unique: bool = True,
        from_csv: bool = True,
    ) -> str:
        """
        Rastgele bir isim üretir ve isteğe bağlı timestamp ekleyerek benzersizleştirir.
        - prefix: başa eklenecek ifade
        - max_length: çıktı uzunluk sınırı
        - ensure_unique: True ise YYYYMMDD-HHMMSS eklenir
        - from_csv: True ise isim havuzunu CSV'den alır; False ise statik havuz kullanır
        """
        if from_csv:
            base = random.choice(self._load_names())
        else:
            base = random.choice(["Health Check", "Pulse Survey", "QWL", "Engagement"])

        if ensure_unique:
            suffix = datetime.now().strftime("%Y%m%d-%H%M%S")
            candidate = f"{prefix} {base} {suffix}".strip()
        else:
            candidate = f"{prefix} {base}".strip()

        # Basit sanitize ve uzunluk sınırı
        allowed = string.ascii_letters + string.digits + " -_"
        sanitized = "".join(ch if ch in allowed else " " for ch in candidate)
        sanitized = " ".join(sanitized.split())  # çoklu boşlukları tekle
        if len(sanitized) > max_length:
            sanitized = sanitized[:max_length].rstrip()
        return sanitized

    @keyword("Get Env")
    def get_env(self, var_name: str, default: str = None, required: bool = False) -> str:
        """
        Ortam değişkeninden değer okur. Örn: Get Env    VC_EMAIL    required=True
        - default: bulunamazsa döndürülecek değer
        - required: True ise bulunamazsa hata fırlatır
        """
        val = os.getenv(var_name, default)
        if required and (val is None or val == ""):
            raise RuntimeError(f"Required environment variable missing: {var_name}")
        return val
