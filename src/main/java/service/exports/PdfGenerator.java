package service.exports;

import com.itextpdf.text.pdf.BaseFont;
import com.lowagie.text.DocumentException;
import org.xhtmlrenderer.pdf.ITextRenderer;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class PdfGenerator {

    // Пути к шрифтам в ресурсах
    private static final String[] FONT_PATHS = {
            "/fonts/DejaVuSans.ttf",       // Основной шрифт
            "/fonts/DejaVuSans-Bold.ttf",  // Жирный вариант
            "/fonts/AriaLuni.ttf"          // Fallback для Unicode
    };

    public byte[] generateFromHtml(String htmlContent) throws IOException, DocumentException {
        if (htmlContent == null || htmlContent.isEmpty()) {
            throw new IOException("HTML-содержание пустое");
        }

        try (ByteArrayOutputStream output = new ByteArrayOutputStream()) {
            ITextRenderer renderer = new ITextRenderer();

            // Настройка шрифтов
            configureFonts(renderer);

            // Установка документа с явным указанием кодировки
            renderer.setDocumentFromString(htmlContent, "UTF-8");
            renderer.layout();
            renderer.createPDF(output);

            return output.toByteArray();
        } catch (com.itextpdf.text.DocumentException e) {
            throw new RuntimeException(e);
        }
    }

    private void configureFonts(ITextRenderer renderer) throws DocumentException, IOException {
        for (String fontPath : FONT_PATHS) {
            try (InputStream fontStream = getClass().getResourceAsStream(fontPath)) {
                if (fontStream != null) {
                    renderer.getFontResolver().addFont(
                            fontPath,
                            BaseFont.IDENTITY_H,
                            BaseFont.EMBEDDED
                    );
                } else {
                    System.err.println("Шрифт не найден: " + fontPath);
                }
            } catch (com.itextpdf.text.DocumentException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
