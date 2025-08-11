# libs/poll_generator.py
import csv
import os
import random
from datetime import datetime

class PollGenerator:
    """Robot Framework: Library  ../libs/poll_generator.py"""

    def __init__(self, csv_path: str = None):
        # varsayılan: project_root/resources/poll_names.csv
        if csv_path is None:
            here = os.path.dirname(os.path.abspath(__file__))
            root = os.path.abspath(os.path.join(here, os.pardir))
            csv_path = os.path.join(root, "resources", "poll_names.csv")
        self.csv_path = csv_path
        self._names_cache = None

    def _load_names(self):
        if self._names_cache is not None:
            return self._names_cache
        names = []
        with open(self.csv_path, newline="", encoding="utf-8") as f:
            reader = csv.reader(f)
            for row in reader:
                if row and row[0].strip():
                    names.append(row[0].strip())
        if not names:
            raise ValueError(f"No names found in {self.csv_path}")
        self._names_cache = names
        return names

    def generate_poll_name(self) -> str:
        """CSV'den rastgele isim seçer ve timestamp ekler."""
        base = random.choice(self._load_names())
        suffix = datetime.now().strftime("%Y%m%d-%H%M%S")
        return f"{base} {suffix}"

# ---- Robot’un keyword olarak göreceği sarmalayıcı (modül seviyesi) ----
def generate_poll_name():
    """Robot keyword: 'Generate Poll Name'."""
    return PollGenerator().generate_poll_name()
