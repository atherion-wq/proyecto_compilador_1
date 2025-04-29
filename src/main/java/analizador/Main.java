package analizador;

import java.io.*;
import java.util.*;
import javax.swing.*;

public class Main {

    public static void main(String[] args) throws Exception {

        JFileChooser fileChooser = new JFileChooser();

        
        fileChooser.setFileFilter(new javax.swing.filechooser.FileNameExtensionFilter("Archivos de texto (*.txt)", "txt"));

        int option = fileChooser.showOpenDialog(null);

        if (option == JFileChooser.APPROVE_OPTION) {
            File selectedFile = fileChooser.getSelectedFile();

        
            if (!selectedFile.getName().toLowerCase().endsWith(".txt")) {
                JOptionPane.showMessageDialog(null, "Por favor selecciona un archivo .txt válido.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            Reader ruta = new FileReader(selectedFile);
            Analizador scanner = new Analizador(ruta);

            Tokens token;


            
            File folder = new File("LexerResult");
            if (!folder.exists()) folder.mkdir();

            try {
                BufferedWriter tokenWriter = new BufferedWriter(new FileWriter(new File(folder, "tokens.txt")));
                Map<String, String> tablaIdentificadores = new LinkedHashMap<>();
                Map<String, String> tablaLiterales = new LinkedHashMap<>();

                while ((token = scanner.yylex()) != null) {
                    if (scanner.lexeme != null) {
                        tokenWriter.write("TOKEN: " + token + "\tLEXEMA: " + scanner.lexeme + "\n");
                    } else {
                        tokenWriter.write("TOKEN: " + token + "\n");
                    }

        
                    switch (token) {
                        case IDENTIFICADOR:
                            tablaIdentificadores.putIfAbsent(scanner.lexeme, "Línea: " + (scanner.getLinea()));
                            break;
                        case LITERAL_INT:
                        case LITERAL_FLOAT:
                        case LITERAL_CHAR:
                        case LITERAL_BOOL:
                        case LITERAL_STRING:
                            if (!tablaLiterales.containsKey(scanner.lexeme)) {
                                tablaLiterales.put(scanner.lexeme, "Tipo: " + token + ", Línea: " + (scanner.getLinea()));
                            }
                            break;
                        default:
                            break;
                    }
                }

                tokenWriter.close();
                BufferedWriter idWriter = new BufferedWriter(new FileWriter(new File(folder, "tabla_identificadores.txt")));
                idWriter.write("TABLA DE IDENTIFICADORES\n");
                for (Map.Entry<String, String> entry : tablaIdentificadores.entrySet()) {
                    idWriter.write("Identificador: " + entry.getKey() + "\t" + entry.getValue() + "\n");
                }
                idWriter.close();

                BufferedWriter litWriter = new BufferedWriter(new FileWriter(new File(folder, "tabla_literales.txt")));
                litWriter.write("TABLA DE LITERALES\n");
                for (Map.Entry<String, String> entry : tablaLiterales.entrySet()) {
                    litWriter.write("Literal: " + entry.getKey() + "\t" + entry.getValue() + "\n");
                }
                litWriter.close();

            } catch (IOException e) {
                System.err.println("Error al escribir en el archivo: " + e.getMessage());
            }

            System.out.println("\n\033[32mTokens y tablas de símbolos escritos en la carpeta LexerResult.\033[0m\n");
        }
    }
}
