import tkinter as tk

def calcular(pantalla):
    try:
        resultado = eval(pantalla.get())
        pantalla.delete(0, tk.END)
        pantalla.insert(0, resultado)
    except:
        pantalla.delete(0, tk.END)
        pantalla.insert(0, "Error")

ventana = tk.Tk()
ventana.title("Calculadora")
ventana.geometry("300x400")

pantalla = tk.Entry(ventana, font=("Arial", 25), justify="right")
pantalla.pack(fill="x", padx=10, pady=10)

botones = [
    "7", "8", "9", "/",
    "4", "5", "6", "*",
    "1", "2", "3", "-",
    "0", ".", "=", "+"
]

frame = tk.Frame(ventana)
frame.pack()

for i, texto in enumerate(botones):
    fila = i // 4
    columna = i % 4
    if texto == "=":
        btn = tk.Button(frame, text=texto, command=lambda: calcular(pantalla))
    else:
        btn = tk.Button(frame, text=texto, command=lambda t=texto: pantalla.insert(tk.END, t))
    btn.grid(row=fila, column=columna, padx=5, pady=5, ipadx=10, ipady=10)

ventana.mainloop()