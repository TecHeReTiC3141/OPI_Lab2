import os
import zipfile
import sys

def unzip_all(directory):
    directory = os.path.abspath(directory)

    for file in os.listdir(directory):
        if file.endswith(".zip"):
            zip_path = os.path.join(directory, file)
            extract_path = os.path.join(directory, os.path.splitext(file)[0])  # Папка с именем архива
            os.makedirs(extract_path, exist_ok=True)  # Создаем папку, если нет
            with zipfile.ZipFile(zip_path, 'r') as zip_ref:
                zip_ref.extractall(extract_path)
            os.remove(zip_path)
            print(f"Файл распакован и удален: {zip_path} → {extract_path}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Использование: python unzip_all.py <путь_к_директории>")
        sys.exit(1)
    unzip_all(sys.argv[1])
