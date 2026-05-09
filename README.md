# Maju LSK Group Project

Welcome to the Maju LSK codebase! This project is a web application featuring a product catalog, brand showcases, and company information.

## 🚀 Getting Started

If you are new to the project, follow these steps to get a local copy on your machine.

### 1. Clone the Project
Open your terminal (Command Prompt, PowerShell, or Git Bash) and run:

```bash
git clone https://github.com/hovahyii/maju-lsk.git
```

Then, enter the project directory:
```bash
cd maju-lsk
```

---

## 🛠️ How to Edit the Code

Depending on what you want to change, look for these files:

| Target | File to Edit |
| :--- | :--- |
| **Homepage Content** | `index.html` |
| **Product Page** | `products.html` |
| **Styling (Colors, Layout)** | `style.css` |
| **Interactivity (JS)** | `script.js` |
| **Database/API Logic** | `api/db.php` or `api/products.php` |

> [!TIP]
> Check out [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) for a full view of every file in this repository.

---

## 🛰️ Git Workflow (for Beginners)

Follow these 4 steps every time you want to save and upload your changes:

### Step 1: Check your changes
See which files you have modified:
```bash
git status
```

### Step 2: Stage your changes
Tell Git which files you want to include in your next "save":
```bash
git add .
```
*(The dot `.` adds all changed files. You can also specify a filename like `git add index.html`)*

### Step 3: Commit your changes
Save your changes locally with a short message describing what you did:
```bash
git commit -m "Brief description of your changes"
```

### Step 4: Push to GitHub
Upload your local saves to the online repository:
```bash
git push origin main
```

---

## 📦 Deployment Note
This project uses **cPanel** for deployment. Any changes pushed to the `main` branch may be automatically deployed if the server is configured with the `.cpanel.yml` file found in the root directory.


