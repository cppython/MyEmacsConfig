#
# -*-encoding:gbk-*-
# ���python��sys.path��������semantic��

import sys

print '\n'.join([path.replace("\\", "/") for path in sys.path if path.strip() and not path.endswith('.zip')])
