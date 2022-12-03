import os
import shutil

git_root_path = "cyxblog_relate"
git_mods_path = "DST\\mods"
local_mods_path = "E:\\SteamLibrary\\steamapps\\common\\Don't Starve Together\\mods"

def copy_allfile(srcdir, dstdir):
    if (not os.path.isdir(srcdir)) or (not os.path.isdir(dstdir)):
        print("please check two paths if exist or not:\n\t{}\n\t{}.".format(srcdir, dstdir))
        return False
    srcfiles = os.listdir(srcdir)
    objcnt = 0
    for object in srcfiles:
        object_path = os.path.join(srcdir, object)
        if os.path.exists(object_path):
            objcnt += 1
            shutil.copy(object_path, dstdir)
    print("from:\n\t{}\nto:\n\t{}".format(srcdir, dstdir))
    print("copy files num: {}.".format(objcnt))

copy_allfile(git_root_path+git_mods_path, local_mods_path)