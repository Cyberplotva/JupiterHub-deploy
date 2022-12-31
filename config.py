# jupyterhub_authenticator_config

c = get_config()
c.JupyterHub.authenticator_class = 'dummyauthenticator.DummyAuthenticator'

# Set a global password for all users wanting to log in.
c.DummyAuthenticator.password = 'admin'
# Set of usernames that are allowed to log in.
c.DummyAuthenticator.allowed_users = {'admin'}
# Dictionary mapping authenticator usernames to JupyterHub users
c.DummyAuthenticator.username_map = {'admin': 'admin'}
# Set of users that will have admin rights on this JupyterHub
c.DummyAuthenticator.admin_users = {'admin'}