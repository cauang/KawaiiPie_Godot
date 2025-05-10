import serial
import keyboard

# Configure aqui sua porta serial e baud rate
ser = serial.Serial('COM3', 9600, timeout=1)  # Altere 'COM3' para a porta certa no seu PC

print("Aguardando comandos do ESP32...")

try:
    while True:
        line = ser.readline().decode('utf-8').strip()
        if line == "P1":
            print(">> P1 (Enter)")
            keyboard.press_and_release('enter')
        elif line == "P2":
            print(">> P2 (Space)")
            keyboard.press_and_release('space')
except KeyboardInterrupt:
    print("Encerrado pelo usuário.")
finally:
    ser.close()
