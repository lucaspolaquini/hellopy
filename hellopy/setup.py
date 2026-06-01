from setuptools import setup, find_packages
with open("readme.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()
setup(
    name='hellopy-package',
    version='1.0.0',
    packages=find_packages(),
    description='Lib para dizer olá em Python',
    author='Lucas Faria Polaquini',
    author_email='cmte.lucas@hotmail.com',
    url='https://github.com/lucaspolaquini/hellopy',  
    license='MIT',  
    long_description=long_description,
    long_description_content_type='text/markdown'
)
