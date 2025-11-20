# Dotfiles-Devpods

## Requisitos
- .devcontainer/devcontainer.json
  -> Especificacion de devcontainer
- .devcontainer/json
  -> descarga mise

## Formas de instalar binarios
- chezmoi externals: .chezmoiexternals/mise.toml
    -> esencial para el setup del flujo de trabajo
- mise global: dot_config/mise/config.toml
    -> Disponible en todo el sistema
- proyecto: 
        mise.toml 
            -> este se instala en el /workspace/repositorio , paquetes especificos del proyecto para el equipo
        scripts/setup (es llamado en devcontainer.json como postcreatecommand) 
            -> Hace que funcoine mise, y potencialmente permite personalizar el proeycto

## Formas de correr scripts
- 1º postcreate(devcontainer.json) al crear el contenedor
    -> para setup del proyecto
- 2º install.sh al clonar nuestros dotfiles
    -> para que chezmoi aplique nuestos dotfiles 
- 3º chezmoi scripts cuando chezmoi aplica nuestros dotfiles
    -> ahora lo uso para sincronizar cambios en los dotfiles con el hash
