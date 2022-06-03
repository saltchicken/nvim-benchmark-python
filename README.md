# nvim-benchmark-python
### Dependencies
```sh
pip install pytest
```
### Usage
Place cursor on the line of the desired function
```
:CreateTests <assert value> <function parameters>
```
Creates file in the same directory with "test_" prepended. Note that the pytest module is required.
```
:!exec pytest
```
