# Jupyter Hub конфиг для аутентификации

c = get_config()
# В данном проекте используется наиболее простая система Dummy Authenticatoin 
c.JupyterHub.authenticator_class = 'dummyauthenticator.DummyAuthenticator'

# Ниже комментарии - вырезки из оффициальной документации (https://jupyterhub.readthedocs.io/en/stable/getting-started/authenticators-users-basics.html)

# Set a global password for all users wanting to log in.
c.DummyAuthenticator.password = 'admin'
# Set of usernames that are allowed to log in.
c.DummyAuthenticator.allowed_users = {'admin'}
# Dictionary mapping authenticator usernames to JupyterHub users
c.DummyAuthenticator.username_map = {'admin': 'admin'}
# Set of users that will have admin rights on this JupyterHub
c.DummyAuthenticator.admin_users = {'admin'}