document.addEventListener("DOMContentLoaded", () => {
    const navLinks = document.querySelectorAll(".nav-link")
    const contentArea = document.querySelector(".content-area")

    const pageTitle = document.querySelector("h1, h2") // Buscar cualquier título principal

    // Manejar clicks en la navegación
    navLinks.forEach((link) => {
        link.addEventListener("click", function (e) {
            // e.preventDefault()

            // Remover clase active de todos los links
            navLinks.forEach((l) => l.classList.remove("active"))

            // Agregar clase active al link clickeado
            this.classList.add("active")

            const navText = this.querySelector(".nav-text")
            if (navText) {
                const originalText = navText.textContent
                navText.textContent = "Cargando..."

                // Restaurar texto después de un momento
                setTimeout(() => {
                    navText.textContent = originalText
                }, 1000)
            }
        })
    })

    function initializeTableFeatures() {
        // Confirmar eliminaciones
        const deleteLinks = document.querySelectorAll('a[href*="eliminar"], button[onclick*="eliminar"]')
        deleteLinks.forEach((link) => {
            link.addEventListener("click", (e) => {
                if (!confirm("¿Está seguro de que desea eliminar este elemento?")) {
                    e.preventDefault()
                }
            })
        })

        // Confirmar cambios de estado
        const stateButtons = document.querySelectorAll(
            'button[onclick*="cambiar_estado"], form[action*="cambiar_estado"] button',
        )
        stateButtons.forEach((button) => {
            button.addEventListener("click", (e) => {
                if (!confirm("¿Está seguro de cambiar el estado de este elemento?")) {
                    e.preventDefault()
                }
            })
        })

        const forms = document.querySelectorAll(".crud-form")
        forms.forEach((form) => {
            form.addEventListener("submit", (e) => {
                const requiredFields = form.querySelectorAll("[required]")
                let isValid = true

                requiredFields.forEach((field) => {
                    if (!field.value.trim()) {
                        field.classList.add("error")
                        isValid = false
                    } else {
                        field.classList.remove("error")
                    }
                })

                if (!isValid) {
                    e.preventDefault()
                    alert("Por favor, complete todos los campos requeridos.")
                }
            })
        })
    }

    initializeTableFeatures()

    const urlParams = new URLSearchParams(window.location.search)
    const currentAction = urlParams.get("action")

    if (currentAction) {
        // Mapear acciones a elementos de navegación
        const actionMap = {
            listar_centros_admin: "centros",
            listar_centros: "centros",
            buscar_centro: "centros",
            editar_centro: "centros",
            crear_centro: "centros",
            listar_usuarios_admin: "usuarios",
            listar_usuarios: "usuarios",
            listar_tipos_usuario_admin: "tipos_usuario",
            listar_tipos_usuario: "tipos_usuario",
        }

        const tableType = actionMap[currentAction]
        if (tableType) {
            const activeLink = document.querySelector(`[data-table="${tableType}"]`)
            if (activeLink) {
                activeLink.classList.add("active")
            }
        }
    }

    function initializeAlerts() {
        const alerts = document.querySelectorAll(".alert")
        alerts.forEach((alert) => {
            // Auto-hide después de 5 segundos
            setTimeout(() => {
                alert.style.opacity = "0"
                setTimeout(() => {
                    alert.style.display = "none"
                }, 300)
            }, 5000)

            // Agregar botón de cerrar
            const closeBtn = document.createElement("button")
            closeBtn.innerHTML = "×"
            closeBtn.className = "alert-close"
            closeBtn.onclick = () => {
                alert.style.opacity = "0"
                setTimeout(() => {
                    alert.style.display = "none"
                }, 300)
            }
            alert.appendChild(closeBtn)
        })
    }

    initializeAlerts()

    const searchForms = document.querySelectorAll(".search-section form")
    searchForms.forEach((form) => {
        const searchInput = form.querySelector('input[type="text"]')
        if (searchInput) {
            searchInput.addEventListener("keypress", (e) => {
                if (e.key === "Enter") {
                    form.submit()
                }
            })
        }
    })

    function enhanceDataTables() {
        const tables = document.querySelectorAll(".data-table")
        tables.forEach((table) => {
            // Agregar hover effect a las filas
            const rows = table.querySelectorAll("tbody tr")
            rows.forEach((row) => {
                row.addEventListener("mouseenter", function () {
                    this.style.backgroundColor = "#f8f9fa"
                })
                row.addEventListener("mouseleave", function () {
                    this.style.backgroundColor = ""
                })
            })
        })
    }

    enhanceDataTables()

    function handleSidebarResponsive() {
        const sidebar = document.querySelector(".sidebar")
        const mainContent = document.querySelector(".main-content")

        if (window.innerWidth <= 768) {
            sidebar.classList.add("mobile")
            mainContent.classList.add("mobile")
        } else {
            sidebar.classList.remove("mobile")
            mainContent.classList.remove("mobile")
        }
    }

    window.addEventListener("resize", handleSidebarResponsive)
    handleSidebarResponsive() // Ejecutar al cargar

    const toggleBtn = document.createElement("button")
    toggleBtn.className = "sidebar-toggle"
    toggleBtn.innerHTML = "☰"
    toggleBtn.onclick = () => {
        const sidebar = document.querySelector(".sidebar")
        sidebar.classList.toggle("show")
    }

    const mainContent = document.querySelector(".main-content")
    if (mainContent) {
        mainContent.insertBefore(toggleBtn, mainContent.firstChild)
    }
})

const additionalStyles = `
.alert {
    position: relative;
    transition: opacity 0.3s ease;
}

.alert-close {
    position: absolute;
    top: 10px;
    right: 15px;
    background: none;
    border: none;
    font-size: 20px;
    cursor: pointer;
    color: inherit;
    opacity: 0.7;
}

.alert-close:hover {
    opacity: 1;
}

.form-control.error {
    border-color: #dc3545;
    box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
}

.sidebar-toggle {
    display: none;
    position: fixed;
    top: 20px;
    left: 20px;
    z-index: 1001;
    background: var(--primary-color);
    color: white;
    border: none;
    padding: 10px;
    border-radius: 5px;
    cursor: pointer;
}

@media (max-width: 768px) {
    .sidebar-toggle {
        display: block;
    }
    
    .sidebar.mobile {
        transform: translateX(-100%);
        transition: transform 0.3s ease;
    }
    
    .sidebar.mobile.show {
        transform: translateX(0);
    }
    
    .main-content.mobile {
        margin-left: 0;
        width: 100%;
    }
}

.nav-link.loading .nav-text {
    opacity: 0.6;
}

.data-table tbody tr {
    transition: background-color 0.2s ease;
}
`

// Agregar estilos adicionales
const styleSheet = document.createElement("style")
styleSheet.textContent = additionalStyles
document.head.appendChild(styleSheet)
