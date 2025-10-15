// Utilidades para manejo de código en las páginas HTML

document.addEventListener('DOMContentLoaded', function() {
    // Función para añadir botones de copia a todos los bloques de código
    function addCopyButtons() {
        const codeBlocks = document.querySelectorAll('pre code');
        
        codeBlocks.forEach((codeBlock, index) => {
            // Crear contenedor para el bloque de código
            const container = document.createElement('div');
            container.className = 'code-block-container';
            
            // Crear botón de copia
            const copyButton = document.createElement('button');
            copyButton.className = 'copy-button';
            copyButton.textContent = 'Copiar';
            copyButton.setAttribute('data-copy-target', `code-block-${index}`);
            
            // Añadir ID único al bloque de código
            const preElement = codeBlock.parentElement;
            preElement.id = `code-block-${index}`;
            
            // Insertar el contenedor antes del pre
            preElement.parentNode.insertBefore(container, preElement);
            
            // Mover el pre al contenedor
            container.appendChild(preElement);
            container.appendChild(copyButton);
            
            // Añadir event listener al botón
            copyButton.addEventListener('click', function() {
                copyCodeToClipboard(codeBlock, copyButton);
            });
        });
    }
    
    // Función para copiar código al portapapeles
    function copyCodeToClipboard(codeElement, button) {
        const codeText = codeElement.textContent;
        
        // Usar la API moderna del portapapeles si está disponible
        if (navigator.clipboard && window.isSecureContext) {
            navigator.clipboard.writeText(codeText).then(function() {
                showCopySuccess(button);
            }).catch(function(err) {
                console.error('Error al copiar: ', err);
                fallbackCopyTextToClipboard(codeText, button);
            });
        } else {
            // Fallback para navegadores más antiguos
            fallbackCopyTextToClipboard(codeText, button);
        }
    }
    
    // Función de respaldo para copiar texto
    function fallbackCopyTextToClipboard(text, button) {
        const textArea = document.createElement("textarea");
        textArea.value = text;
        
        // Evitar scroll hacia el área de texto
        textArea.style.top = "0";
        textArea.style.left = "0";
        textArea.style.position = "fixed";
        
        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();
        
        try {
            const successful = document.execCommand('copy');
            if (successful) {
                showCopySuccess(button);
            } else {
                console.error('Fallback: No se pudo copiar el texto');
            }
        } catch (err) {
            console.error('Fallback: Error al copiar ', err);
        }
        
        document.body.removeChild(textArea);
    }
    
    // Función para mostrar éxito de copia
    function showCopySuccess(button) {
        const originalText = button.textContent;
        button.textContent = '¡Copiado!';
        button.classList.add('copied');
        
        setTimeout(function() {
            button.textContent = originalText;
            button.classList.remove('copied');
        }, 2000);
    }
    
    // Función para añadir sección de descarga de código
    function addDownloadSection() {
        // Buscar enlaces a archivos .R en la página
        const rLinks = [];
        const links = document.querySelectorAll('a[href$=".R"]');
        
        links.forEach(link => {
            rLinks.push({
                url: link.href,
                text: link.textContent.trim(),
                filename: link.href.split('/').pop()
            });
        });
        
        // Si hay enlaces a archivos R, añadir sección de descarga
        if (rLinks.length > 0) {
            const downloadSection = document.createElement('div');
            downloadSection.className = 'download-section';
            
            downloadSection.innerHTML = `
                <h3>📁 Descargar Código R</h3>
                <p>Descarga los archivos de código R utilizados en este análisis:</p>
                <div class="download-links">
                    ${rLinks.map(link => 
                        `<a href="${link.url}" class="download-link" download="${link.filename}">
                            ${link.text}
                        </a>`
                    ).join('')}
                </div>
            `;
            
            // Añadir la sección al final del contenido principal
            const mainContent = document.querySelector('body') || document.body;
            mainContent.appendChild(downloadSection);
        }
    }
    
    // Función para mejorar la sintaxis de código R
    function highlightRSyntax() {
        const codeBlocks = document.querySelectorAll('pre code');
        
        codeBlocks.forEach(codeBlock => {
            let html = codeBlock.innerHTML;
            
            // Palabras clave de R
            const keywords = [
                'function', 'if', 'else', 'for', 'while', 'repeat', 'break', 'next',
                'return', 'TRUE', 'FALSE', 'NULL', 'NA', 'Inf', 'NaN',
                'library', 'require', 'source', 'setwd', 'getwd',
                'c', 'list', 'data.frame', 'matrix', 'array',
                'class', 'typeof', 'length', 'dim', 'names', 'colnames', 'rownames',
                'head', 'tail', 'summary', 'str', 'print', 'cat',
                'plot', 'ggplot', 'geom_', 'aes', 'theme', 'labs',
                'lm', 'glm', 'predict', 'fitted', 'residuals',
                'read.csv', 'write.csv', 'read.table', 'write.table'
            ];
            
            // Aplicar colores a palabras clave
            keywords.forEach(keyword => {
                const regex = new RegExp(`\\b${keyword}\\b`, 'g');
                html = html.replace(regex, `<span class="keyword">${keyword}</span>`);
            });
            
            // Comentarios
            html = html.replace(/#[^\n]*/g, '<span class="comment">$&</span>');
            
            // Strings
            html = html.replace(/"([^"]*)"/g, '<span class="string">"$1"</span>');
            html = html.replace(/'([^']*)'/g, '<span class="string">\'$1\'</span>');
            
            // Números
            html = html.replace(/\b\d+\.?\d*\b/g, '<span class="number">$&</span>');
            
            // Operadores
            html = html.replace(/([<>=!&|]+)/g, '<span class="operator">$1</span>');
            
            codeBlock.innerHTML = html;
        });
    }
    
    // Inicializar todas las funcionalidades
    addCopyButtons();
    addDownloadSection();
    highlightRSyntax();
    
    // Añadir estilos CSS si no están ya incluidos
    if (!document.querySelector('link[href*="code-styles.css"]')) {
        const cssLink = document.createElement('link');
        cssLink.rel = 'stylesheet';
        cssLink.href = 'code-styles.css';
        document.head.appendChild(cssLink);
    }
});
