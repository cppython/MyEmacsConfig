#
# -*-encoding:gbk-*-
# 获得python的sys.path，供设置semantic用

import sys

print '\n'.join([path.replace("\\", "/") for path in sys.path if path.strip() and not path.endswith('.zip')])
