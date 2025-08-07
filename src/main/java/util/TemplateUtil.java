package util;

import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;
import org.thymeleaf.templateresolver.ClassLoaderTemplateResolver;

import java.util.Map;

public class TemplateUtil {

    private static final TemplateEngine engine = createEngine();

    private static TemplateEngine createEngine() {
        TemplateEngine templateEngine = new TemplateEngine();
        ClassLoaderTemplateResolver resolver = new ClassLoaderTemplateResolver();
        resolver.setPrefix("/templates/");
        resolver.setSuffix(".html");
        resolver.setTemplateMode("HTML5");
        resolver.setCharacterEncoding("UTF-8");
        resolver.setCacheable(false);

        templateEngine.setTemplateResolver(resolver);
        return templateEngine;
    }

    public static String process(String templateName, Map<String, Object> model) {
        Context context = new Context();
        context.setVariables(model);
        return engine.process(templateName, context);
    }
}