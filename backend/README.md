```markdown
# PalmPay Backend (FastAPI)

## Overview

This is the **backend service** for PalmPay, responsible for biometric authentication, transaction processing, and system security.

Built with **FastAPI**, it integrates:
- Hand geometry analysis (MediaPipe)
- Deep learning (CNN via PyTorch)
- Risk-based authentication (Biometric / PIN / OTP)
- Secure payment workflows

---

## Features

- **Hybrid Biometric Engine**
  - Geometric hand analysis (MediaPipe)
  - CNN-based feature extraction (PyTorch)

- **3-Tier Risk-Based Authentication**
  - Low: Biometric only
  - Medium: Biometric + PIN
  - High: Biometric + OTP

- **Secure Payment Processing**
- **Admin Monitoring APIs**
- **Audit logging & security tracking**
- **AES-256 encrypted biometric storage**

---

## Tech Stack

- **FastAPI** (async backend)
- **MongoDB** (database)
- **PyTorch** (CNN embeddings)
- **MediaPipe** (hand detection)
- **Uvicorn** (ASGI server)
- **Razorpay** (payments)
- **SMTP (Gmail)** (OTP delivery)

---

## Project Structure

```

backend/
├── app/
│   ├── biometric/        # Hand detection + matching logic
│   │   ├── matcher.py
│   │   └── hand_detector.py
│   ├── payment/          # Payment + MFA logic
│   ├── admin/            # Admin routes + monitoring
│   ├── core/             # Config, security, utils
│   ├── models/           # DB models
│   ├── routes/           # API endpoints
│   └── main.py           # FastAPI entry point
├── scripts/              # Utility scripts
│   └── wipe_all_data.py
├── requirements.txt
├── flake.nix             # Backend Nix environment
└── README.md

````

---

## Setup

### 1. Create virtual environment
```bash
python -m venv venv
````

### 2. Activate

```bash
# Linux / Mac
source venv/bin/activate

# Windows
venv\Scripts\activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

---

## Running the Backend

```bash
python -m uvicorn app.main:app --port 8000 --reload
```

API available at:

```
http://localhost:8000
```

Swagger docs:

```
http://localhost:8000/docs
```

---

## Database Setup

Ensure MongoDB is running:

```bash
mongod
```

Default connection:

```
mongodb://localhost:27017/hand_biometrics_db
```

---

## Initial Setup

Seed admin user:

```bash
python seed_admin.py
```

> (If moved inside backend: `python scripts/seed_admin.py`)

---

## Environment Configuration

This project uses a **single root-level `.env` file**.

Example:

```env
MONGODB_URL=mongodb://localhost:27017/hand_biometrics_db

SECRET_KEY=your_secret
ALGORITHM=HS256

RAZORPAY_KEY_ID=your_key
RAZORPAY_KEY_SECRET=your_secret

EMAIL_USER=your_email
EMAIL_PASS=your_password
```

---

## Nix Environment (Optional)

Backend includes its own **`flake.nix`** for reproducible setup.

### Enter backend shell

```bash
nix develop
```

Includes:

* Python 3.11
* pip
* MongoDB + tools
* MongoDB Compass

---

## API Overview

### Auth & User

* Register user
* Login
* Biometric enrollment

### Payments

* Create transaction
* Risk evaluation
* Trigger MFA (PIN / OTP)

### Admin

* View users
* Transaction logs
* Security alerts

---

## Security Design

* Biometric templates stored **encrypted (AES-256)**
* No raw biometric images stored permanently
* OTP-based verification for high-value transactions
* Sensitive data masking in logs and responses

---

## Notes

* Requires camera input (via frontend)
* Ensure MongoDB is running before starting backend
* Configure `.env` properly before running
* Use Python 3.10+ (3.11 recommended)

---

## Future Improvements

* Model optimization for faster inference
* Distributed microservice split
* WebSocket-based real-time updates
* Advanced fraud detection layer

