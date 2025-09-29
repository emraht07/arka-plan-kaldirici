import tkinter as tk
from tkinter import filedialog, messagebox
from PIL import Image
from rembg import remove
import os

def select_input_file():
    file_path = filedialog.askopenfilename(title="Girdi dosyasını seç", filetypes=[("Resim Dosyaları", "*.jpg *.jpeg *.png")])
    input_entry.delete(0, tk.END)
    input_entry.insert(0, file_path)

def select_output_file():
    file_path = filedialog.asksaveasfilename(title="Çıktı dosyasını kaydet", defaultextension=".png", filetypes=[("PNG Dosyası", "*.png")])
    output_entry.delete(0, tk.END)
    output_entry.insert(0, file_path)

def remove_background_gui():
    input_path = input_entry.get()
    output_path = output_entry.get()

    if not os.path.exists(input_path):
        messagebox.showerror("Hata", f"Girdi dosyası bulunamadı:\n{input_path}")
        return

    try:
        input_image = Image.open(input_path)
        output_image = remove(input_image)
        output_image.save(output_path)
        messagebox.showinfo("Başarılı", f"Arka plan kaldırıldı ve kaydedildi:\n{output_path}")
    except Exception as e:
        messagebox.showerror("Hata", f"Bir hata oluştu:\n{e}")

# Arayüz oluştur
root = tk.Tk()
root.title("Arka Plan Kaldırıcı")

tk.Label(root, text="Girdi Dosyası:").grid(row=0, column=0, padx=10, pady=5, sticky="e")
input_entry = tk.Entry(root, width=50)
input_entry.grid(row=0, column=1, padx=10, pady=5)
tk.Button(root, text="Gözat", command=select_input_file).grid(row=0, column=2, padx=10, pady=5)

tk.Label(root, text="Çıktı Dosyası:").grid(row=1, column=0, padx=10, pady=5, sticky="e")
output_entry = tk.Entry(root, width=50)
output_entry.grid(row=1, column=1, padx=10, pady=5)
tk.Button(root, text="Kaydet", command=select_output_file).grid(row=1, column=2, padx=10, pady=5)

tk.Button(root, text="Arka Planı Kaldır", command=remove_background_gui, bg="green", fg="white").grid(row=2, column=1, pady=20)

root.mainloop()

