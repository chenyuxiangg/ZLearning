import os
import shutil

git_root_path = "E:\\git\\cyxblog_relate\\"
git_mods_path = "DST\\mods"
local_mods_path = "E:\\SteamLibrary\\steamapps\\common\\Don't Starve Together\\mods"

def copy_allfile(srcdir, dstdir):
    if (not os.path.isdir(srcdir)) or (not os.path.isdir(dstdir)):
        print("please check two paths if exist or not:\n\t{}\n\t{}.".format(srcdir, dstdir))
        return False
    srcfiles = os.listdir(srcdir)
    fileobj_cnt = 0
    dirobj_cnt = 0
    for object in srcfiles:
        object_path = os.path.join(srcdir, object)
        if os.path.isfile(object_path):
            fileobj_cnt += 1
            shutil.copy(object_path, dstdir)
        elif os.path.isdir(object_path):
            dirobj_cnt += 1
            shutil.copytree(object_path, dstdir)
    print("from:\n\t{}\nto:\n\t{}".format(srcdir, dstdir))
    print("copy file nums: {}, copy dir nums: {}".format(fileobj_cnt, dirobj_cnt))
    return True

copy_allfile(git_root_path+git_mods_path, local_mods_path)