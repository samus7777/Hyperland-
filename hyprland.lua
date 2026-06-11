
--------------------------------------------------
--           HYPRLAND LUA CONFIGURATION
--               Configurado por fernudev
--        Adaptado y comentado en español
--             Compatible con Hyprland 0.55.3
--------------------------------------------------

--------------------------------------------------
-- MONITOR
--------------------------------------------------
-- Monitor principal:
-- output="" significa monitor por defecto.
-- preferred usa la resolución y frecuencia recomendadas.
-- auto posiciona automáticamente el monitor.
-- auto en scale usa el escalado automático.

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

--------------------------------------------------
-- PROGRAMAS
--------------------------------------------------

-- Terminal predeterminada
local terminal = "kitty"

-- Explorador de archivos
local fileManager = "nautilus"

-- Menú de aplicaciones
local menu = "rofi -show drun"

-- Navegador web
local browser = "firefox"

-- Modificador principal (tecla Super o Windows)
local mainMod = "SUPER"

--------------------------------------------------
-- AUTOINICIO
--------------------------------------------------
-- Se ejecuta una sola vez al iniciar Hyprland.

hl.on("hyprland.start", function()

    -- Variables necesarias para xdg-desktop-portal
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    hl.exec_cmd("dbus-update-activation-environment --systemd --all")

    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Barra superior
    hl.exec_cmd("waybar")

    -- Demonio del fondo de pantalla
    hl.exec_cmd("swww-daemon")

    -- Cursor Bibata
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 12")

end)

--------------------------------------------------
-- VARIABLES DE ENTORNO
--------------------------------------------------

-- Tamaño del cursor
hl.env("XCURSOR_SIZE", "24")

-- Entorno actual
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Variables para Qt
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "0")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Aplicaciones Electron
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Firefox en Wayland
hl.env("MOZ_ENABLE_WAYLAND", "1")

--------------------------------------------------
-- APARIENCIA GENERAL
--------------------------------------------------

hl.config({

    general = {

        -- Espacio entre ventanas
        gaps_in = 5,

        -- Espacio exterior
        gaps_out = 20,

        -- Tamaño del borde
        border_size = 2,

        -- Colores del borde
        col = {

            active_border = {
                colors = {
                    "rgba(33ccffee)",
                    "rgba(00ff99ee)"
                },

                angle = 45
            },

            inactive_border = "rgba(595959aa)"
        },

        -- Permite redimensionar usando el borde
        resize_on_border = true,

        -- Desactivar tearing
        allow_tearing = false,

        -- Layout utilizado
        layout = "dwindle"
    },

    decoration = {

        -- Redondeo de las ventanas
        rounding = 5,

        shadow = {

            -- Activar sombras
            enabled = true,

            -- Alcance de la sombra
            range = 50,

            -- Intensidad
            render_power = 9,

            -- Color de la sombra
            color = "rgba(0,0,0,0.6)"
        },

        blur = {

            -- Desactivar desenfoque
            enabled = false,

            size = 3,

            passes = 1
        }
    }
})

--------------------------------------------------
-- ANIMACIONES
--------------------------------------------------
-- Curva personalizada equivalente a:
-- bezier = myBezier, 0.05, 0.9, 0.1, 1.05

hl.curve("myBezier", {
    type = "bezier",
    points = {
        {0.05, 0.9},
        {0.1, 1.05}
    }
})

-- Animaciones principales

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 7,
    bezier = "myBezier"
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 7,
    bezier = "default",
    style = "popin 80%"
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "default"
})

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 8,
    bezier = "default"
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 7,
    bezier = "default"
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "default"
})

--------------------------------------------------
-- LAYOUT DWINDLE
--------------------------------------------------
-- Configuración del layout en espiral

hl.config({
    dwindle = {

        -- Permite pseudotile
        pseudotile = true,

        -- Mantiene las divisiones al crear nuevas ventanas
        preserve_split = true
    }
})

--------------------------------------------------
-- LAYOUT MASTER
--------------------------------------------------

hl.config({
    master = {

        -- Las nuevas ventanas pasan a ser la principal
        new_is_master = true
    }
})

--------------------------------------------------
-- GESTOS
--------------------------------------------------
-- Deslizar con tres dedos para cambiar de workspace

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

--------------------------------------------------
-- CONFIGURACIÓN MISC
--------------------------------------------------

hl.config({
    misc = {

        -- Desactiva los wallpapers anime de Hyprland
        force_default_wallpaper = -1,

        -- Oculta el logo al iniciar
        disable_hyprland_logo = true
    }
})

--------------------------------------------------
-- XWAYLAND
--------------------------------------------------
-- Escalado para aplicaciones X11

hl.config({
    xwayland = {

        force_zero_scaling = true
    }
})

--------------------------------------------------
-- INPUT
--------------------------------------------------

hl.config({

    input = {

        -- Distribución del teclado español
        kb_layout = "es",

        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        -- El foco sigue al ratón
        follow_mouse = 1,

        -- Sensibilidad general
        sensitivity = 0.7,

        touchpad = {

            -- Scroll natural
            natural_scroll = true
        }
    }
})

--------------------------------------------------
-- CONFIGURACIÓN DE DISPOSITIVOS
--------------------------------------------------
-- Configuración específica para un ratón

hl.device({

    name = "epic mouse V1",

    -- Reduce sensibilidad
    sensitivity = -0.5
})

--------------------------------------------------
-- REGLAS DE VENTANAS
--------------------------------------------------

-- Rofi permanece enfocado
hl.window_rule({
    name = "rofi-stayfocused",
    match = {
        class = "Rofi"
    },

    stay_focused = true
})

-- Rofi recibe la entrada del teclado
hl.window_rule({
    name = "rofi-forceinput",
    match = {
        class = "Rofi"
    },

    force_input = true
})

-- Waypaper abre en modo flotante
hl.window_rule({
    name = "waypaper-float",
    match = {
        class = "waypaper"
    },

    float = true
})

-- Transparencia para Visual Studio Code
hl.window_rule({
    name = "vscode-opacity",
    match = {
        class = "^Code$"
    },

    opacity = {
        active = 0.98,
        inactive = 0.98
    }
})

-- Kitty flotante
hl.window_rule({
    name = "float-kitty",

    match = {
        class = "^float_kitty$"
    },

    float = true,

    size = {
        width = 1450,
        height = 800
    }
})

--------------------------------------------------
-- ATAJOS PRINCIPALES
--------------------------------------------------

-- Abrir terminal
hl.bind(
    mainMod .. " + Return",
    hl.dsp.exec_cmd(terminal)
)

-- Abrir terminal flotante
hl.bind(
    mainMod .. " + ALT + Return",
    hl.dsp.exec_cmd(terminal .. " --class float_kitty")
)

-- Cerrar ventana activa
hl.bind(
    mainMod .. " + Q",
    hl.dsp.window.close()
)

-- Salir de Hyprland
hl.bind(
    mainMod .. " + M",
    hl.dsp.exit()
)

-- Abrir administrador de archivos
hl.bind(
    mainMod .. " + E",
    hl.dsp.exec_cmd(fileManager)
)

-- Cambiar entre flotante y mosaico
hl.bind(
    mainMod .. " + V",
    hl.dsp.window.float({
        action = "toggle"
    })
)

-- Abrir Rofi
hl.bind(
    mainMod .. " + Space",
    hl.dsp.exec_cmd(menu)
)

-- Activar pseudotile
hl.bind(
    mainMod .. " + P",
    hl.dsp.window.pseudo()
)

-- Alternar división de Dwindle
hl.bind(
    mainMod .. " + J",
    hl.dsp.layout("togglesplit")
)

-- Abrir Firefox
hl.bind(
    mainMod .. " + F",
    hl.dsp.exec_cmd(browser)
)

-- Abrir Waypaper
hl.bind(
    mainMod .. " + SHIFT + W",
    hl.dsp.exec_cmd("waypaper")
)

--------------------------------------------------
-- MOVIMIENTO DEL FOCO
--------------------------------------------------

-- Izquierda
hl.bind(
    mainMod .. " + left",
    hl.dsp.focus({
        direction = "left"
    })
)

-- Derecha
hl.bind(
    mainMod .. " + right",
    hl.dsp.focus({
        direction = "right"
    })
)

-- Arriba
hl.bind(
    mainMod .. " + up",
    hl.dsp.focus({
        direction = "up"
    })
)

-- Abajo
hl.bind(
    mainMod .. " + down",
    hl.dsp.focus({
        direction = "down"
    })
)

--------------------------------------------------
-- WORKSPACES
--------------------------------------------------
-- Cambiar entre escritorios con SUPER + [0-9]
-- Mover ventana actual con SUPER + SHIFT + [0-9]

for i = 1, 10 do

    local key = i % 10

    -- Cambiar al workspace
    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({
            workspace = i
        })
    )

    -- Mover ventana al workspace
    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({
            workspace = i
        })
    )

end

--------------------------------------------------
-- VOLUMEN
--------------------------------------------------

-- Subir volumen
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1"
    ),
    {
        locked = true,
        repeating = true
    }
)

-- Bajar volumen
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ),
    {
        locked = true,
        repeating = true
    }
)

--------------------------------------------------
-- BRILLO
--------------------------------------------------

-- Aumentar brillo
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd(
        "brightnessctl set +5%"
    ),
    {
        locked = true,
        repeating = true
    }
)

-- Disminuir brillo
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd(
        "brightnessctl set 5%-"
    ),
    {
        locked = true,
        repeating = true
    }
)

--------------------------------------------------
-- CAPTURAS DE PANTALLA
--------------------------------------------------

-- Tecla Print
hl.bind(
    "Print",
    hl.dsp.exec_cmd(
        "hyprshot -m output --clipboard-only"
    )
)

--------------------------------------------------
-- WORKSPACE ESPECIAL (SCRATCHPAD)
--------------------------------------------------

-- Abrir workspace especial
hl.bind(
    mainMod .. " + S",
    hl.dsp.workspace.toggle_special(
        "magic"
    )
)

-- Mover ventana actual al scratchpad
hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.window.move({
        workspace = "special:magic"
    })
)

--------------------------------------------------
-- CAMBIO DE WORKSPACES CON LA RUEDA DEL RATÓN
--------------------------------------------------

hl.bind(
    mainMod .. " + mouse_down",
    hl.dsp.focus({
        workspace = "e+1"
    })
)

hl.bind(
    mainMod .. " + mouse_up",
    hl.dsp.focus({
        workspace = "e-1"
    })
)

--------------------------------------------------
-- MOVER Y REDIMENSIONAR VENTANAS CON EL RATÓN
--------------------------------------------------

-- Arrastrar ventana
hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    {
        mouse = true
    }
)

-- Redimensionar ventana
hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    {
        mouse = true
    }
)

--------------------------------------------------
-- FIN DE LA CONFIGURACIÓN
--------------------------------------------------
-- Configuración basada en:
-- Hyprland 0.55.3
-- Config original de fernudev
-- Adaptada a Lua y documentada en español
--------------------------------------------------

