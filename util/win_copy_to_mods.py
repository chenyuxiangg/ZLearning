import os

git_root_path = "cyxblog_relate"
git_mods_path = "DST\\mods"
local_mods_path = "E:\\SteamLibrary\\steamapps\\common\\Don't Starve Together\\mods"

def copy_allfile(srcdir, dstdir):
    if (not os.path.isdir(srcdir)) or (not os.path.isdir(dstdir)):
        print("please check two paths if exist or not:\n\t{}\n\t{}.".format(srcdir, dstdir))
        return False
    srcfiles = os.listdir(srcdir)
    for object in srcfiles:
        test