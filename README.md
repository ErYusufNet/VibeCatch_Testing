# VibeCatch Test Automation Project

This repository contains automated UI tests for [VibeCatch](https://env-5369504.paas.datacenter.fi/) using **Robot Framework** and the **Browser Library**.

These tests are part of a training project to automate core poll creation, deletion, and login functionalities.

---

## 📌 What’s Tested?

The following test scenarios are automated:

- **Login Test**  
  Verifies login functionality with valid credentials.

- **Create Poll Test**  
  Creates a new poll with a given name.

- **Delete Poll Test**  
  Deletes a poll by locating it by name, confirming, and verifying removal.

- **Logout Test**  
  Ensures the user can safely log out of the system.

---

## 🗂 Project Structure
vibecatch-tests/
├── resources/
│ └── keywords.robot # Custom keyword definitions
│ └── variables.robot # Global variables used in tests
├── tests/
│ └── login_test.robot # Login test case
│ └── create_poll.robot # Poll creation test
│ └── delete_poll.robot # Poll deletion test
├── requirements.txt # Python dependencies
├── README.md # This file
└── .gitignore # Files to ignore

## ⚙️ Setup Instructions

1. **Clone the repository:**


git clone <your-repo-url>
cd vibecatch-tests
python -m venv venv
venv\Scripts\activate
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
rfbrowser init
▶️ How to Run the Tests
To run all tests:



robot tests/
To run a specific test file:


robot tests/login_test.robot

| Field        | Value                                                                              |
| ------------ | ---------------------------------------------------------------------------------- |
| URL          | [https://env-5369504.paas.datacenter.fi/](https://env-5369504.paas.datacenter.fi/) |
| Email        | `yusuf.er@brightstraining.com`                                                     |
| Password     | `tenor!embedded9PING`                                                              |
| Poll Name    | `testing1`                                                                         |
| Confirm Text | `DESTROY`                                                                          |
🧪 Tech Stack
Robot Framework

Browser Library (uses Playwright)

Python 3.x

 Notes
Make sure you have Node.js installed (Playwright dependency).

Tests are written using XPath for element location.

Browser runs in non-headless mode for visibility.
