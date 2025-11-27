# PalmPay - Secure Biometric Payment System

## Overview

PalmPay is a biometric-based payment system that combines hand geometry analysis and deep learning (CNN) to enable secure financial transactions. The system follows a risk-based authentication model where security increases with transaction value.

This project uses a **monorepo structure**, containing both frontend and backend in a single repository for easier development, setup, and demonstration.

---

## Architecture

Frontend (React + Electron) → Backend (FastAPI) → Biometric Engine (MediaPipe + CNN) → MongoDB

---

## Repository Structure

```
.
├── backend/          # FastAPI backend + biometric engine
├── frontend/         # Electron + React frontend
├── .env.example      # Environment variables template
├── flake.nix         # Root Nix development environment
├── README.md         # Root documentation
```

---

## Setup (Quick Start)

### 1. Clone Repository

```
git clone <repo-url>
cd palmpay
```

### 2. Configure Environment

```
cp .env.example .env
```

Fill in required values.

### 3. Install Dependencies

#### Backend

```
cd backend
pip install -r requirements.txt
```

#### Frontend

```
cd frontend
npm install
```

---

## Running the Application

### Start Backend

```
cd backend
python -m uvicorn app.main:app --port 8000 --reload
```

### Start Frontend

```
cd frontend
npm run dev
```

---

## Alternative Setup (Nix Environment)

This repository includes a **root-level `flake.nix`** for reproducible development environments.

### Enter Default Shell

```
nix develop
```

---

### Backend Environment

```
nix develop .#backend
```

Includes:

* Python 3.11
* pip
* MongoDB + tools
* MongoDB Compass

---

### Frontend Environment

```
nix develop .#frontend
```

Includes:

* Node.js 22
* npm

---

### Notes on Nix Usage

* Nix provides **isolated and reproducible environments**
* No need to manually install dependencies globally
* Recommended for Linux users and consistent setups

---

## Partial Nix Environments

In addition to the root flake:

* `backend/flake.nix` → backend-only environment
* `frontend/flake.nix` → frontend-only environment

This allows:

* working on services independently
* lighter shells when full stack is not required

Refer to respective service READMEs for details.

---

## Detailed Setup

For detailed instructions, refer to:

* `backend/README.md` – backend setup, ML pipeline, database
* `frontend/README.md` – frontend setup and UI

---

## Key Features

* Hybrid biometric engine (geometry + CNN)
* Risk-based multi-factor authentication
* Secure transaction processing
* Admin monitoring dashboard
* Encrypted biometric storage (AES-256)

---

## Notes

* MongoDB must be running locally or configured via `.env`
* Ensure required dependencies (camera, drivers, etc.) are available
* Do not commit `.env` (use `.env.example` instead)

---

## License

This project is licensed under the MIT License.
