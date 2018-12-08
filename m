Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25C4F20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 15:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLHPLO (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 10:11:14 -0500
Received: from mout.web.de ([212.227.17.12]:43645 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbeLHPLO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 10:11:14 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWS3S-1gxdPZ34xu-00XctK; Sat, 08
 Dec 2018 16:11:11 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, svnpenn@gmail.com, johannes.schindelin@gmx.de
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/1] git clone <url> C:\cygwin\home\USER\repo' is working (again)
Date:   Sat,  8 Dec 2018 16:11:09 +0100
Message-Id: <20181208151109.2097-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
In-Reply-To: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:obB03m8EjG9FK4g8EYIy3aFq7dtRzb1N/YRKarjjs5GXUEN8e1x
 LsvLB//YpAThxRielc1azdHPTKzJn5D3i5UphWfjfVt+8dLHFkTpojKYK4CBiivLo2l6bEs
 jxzClplk+lG/EeRv8YNxFJDaoJIUnnyDMMr6GfWhecgPHLYKzxW6bm90BUJRoXVTR3QPMbG
 NIFOz669m7uGchc26Jv6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rYcFnfmCl5Q=:V0z73Ou/3Ig7taQ8l03v46
 /RKbo0kF7ZoH6uvx8wwn98tX6/7Vfe/5KSI+1Y9PKocWRWmJ3uI8qjNKtHOY7AofMFKc9g/Sg
 MZyJLtD8B0b9XshaxRmmbKiZi7U5/+8pjd5/SYv9g5sdy5/x4oyHoUSTkS6QKVSqgkEh2eXtX
 9ZH04s9M7aYDcJrLiD0Olh3z8/VJ9UUESCW+KZJPwfxmjmfuOSN45H11LrKIGEHq5MOGKH+TZ
 +Nn4vbSQcQxloFWETy9uuqbotwx0vj3BmT0PvgslZuUvCjAZFxZh1I3viiByrDuef0BRlCjxe
 7MvoVXoVv9XX7LyclNp/j61EZF7G5wtawyQjZGC9jP3gIrQOfhKABcGL77oGT47+gIyIpZVuz
 olcWKWpI6fyIjzgYGnEEfqjs7adSko0JBbxvxuIjrDiijgf+Wj3gW2Z+7kCE6Vck4ormKNtAm
 +7X6HbHcPcmifu0Qi1csgpextsUNTxT9jZsRBULm1SAdHvyNKl76L/h9p+r/mgAG3SdlNP93w
 T1hiFAdc3OkJJb5DRMXFSyZCmwZT7THj0kSSBl1DSJ/bTew03U+wfmhBg4iQHDYcNopfKb/hN
 fPgY4us/9rl8C8Y4z0fsunVvwRMzToyIQqae/8/ldsNg+O1r49cOmu3zxER9WOEWKCVouUsDi
 TPbn3xY6Hvo7WdezI7rnqC6TciulThN0/Un7rxszi4br3/p0nBn3bfOytjNPnSfDJLCv1SJff
 hqNkXCQ8uKUoF0EnSvc9uhiGwludEjllC5Bzmxqa+zTbNi33JEZRxCI7XaiDs51soAfHi8pub
 ovJ7e08YjO702oPJcgZts2eFUVGb2oClgjZ5+Uk2hdHE1eKHGf4vXqrpsIBEVf6Z20eql8YuE
 Pa2vsaxNAGfRjWOaJwr3OuxxhJ/RGEo0oJimlmOVPBX0qBM8DD4LpzXroP3Vzr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

A regression for cygwin users was introduced with commit 05b458c,
 "real_path: resolve symlinks by hand".

In the the commit message we read:
  The current implementation of real_path uses chdir() in order to resolve
    symlinks.  Unfortunately this isn't thread-safe as chdir() affects a
      process as a whole...

The old (and non-thread-save) OS calls chdir()/pwd() had been
replaced by a string operation.
The cygwin layer "knows" that "C:\cygwin" is an absolute path,
but the new string operation does not.

"git clone <url> C:\cygwin\home\USER\repo" fails like this:
fatal: Invalid path '/home/USER/repo/C:\cygwin\home\USER\repo'

The solution is to implement has_dos_drive_prefix(), skip_dos_drive_prefix()
is_dir_sep(), offset_1st_component() and convert_slashes() for cygwin
in the same way as it is done in 'Git for Windows' in compat/mingw.[ch]

Extract the needed code into compat/win32/path-utils.[ch] and use it
for cygwin as well.

Reported-by: Steven Penny <svnpenn@gmail.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
Changes since V2:
- Settled on a better name:
  The common code is in compat/win32/path-utils.c/h
- Skip the 2 patches which "only" do a cleanup (for a moment)
  put those cleanups onto the "todo stack".
- The "DOS" moniker is still used for 2 reasons:
  Windows inherited the "drive letter" concept from DOS,
  and everybody (tm) familar with the code and the path handling
  in Git is used to that wording.
  Even if there was a better name, it needed to be addressed
  in a patch series different from this one.
  Here I want to fix a reported regression.
   
And, before any cleanup is done, I sould like to ask if anybody
can build the code with VS and confirm that it works, please ?

Thanks for the reviews, testing and comment.

compat/cygwin.c           | 19 -------------------
 compat/cygwin.h           |  2 --
 compat/mingw.c            | 29 +----------------------------
 compat/mingw.h            | 20 --------------------
 compat/win32/path-utils.c | 28 ++++++++++++++++++++++++++++
 compat/win32/path-utils.h | 20 ++++++++++++++++++++
 config.mak.uname          |  3 ++-
 git-compat-util.h         |  3 ++-
 8 files changed, 53 insertions(+), 71 deletions(-)
 delete mode 100644 compat/cygwin.c
 delete mode 100644 compat/cygwin.h
 create mode 100644 compat/win32/path-utils.c
 create mode 100644 compat/win32/path-utils.h

diff --git a/compat/cygwin.c b/compat/cygwin.c
deleted file mode 100644
index b9862d606d..0000000000
--- a/compat/cygwin.c
+++ /dev/null
@@ -1,19 +0,0 @@
-#include "../git-compat-util.h"
-#include "../cache.h"
-
-int cygwin_offset_1st_component(const char *path)
-{
-	const char *pos = path;
-	/* unc paths */
-	if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
-		/* skip server name */
-		pos = strchr(pos + 2, '/');
-		if (!pos)
-			return 0; /* Error: malformed unc path */
-
-		do {
-			pos++;
-		} while (*pos && pos[0] != '/');
-	}
-	return pos + is_dir_sep(*pos) - path;
-}
diff --git a/compat/cygwin.h b/compat/cygwin.h
deleted file mode 100644
index 8e52de4644..0000000000
--- a/compat/cygwin.h
+++ /dev/null
@@ -1,2 +0,0 @@
-int cygwin_offset_1st_component(const char *path);
-#define offset_1st_component cygwin_offset_1st_component
diff --git a/compat/mingw.c b/compat/mingw.c
index 34b3880b29..27e397f268 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -350,7 +350,7 @@ static inline int needs_hiding(const char *path)
 		return 0;
 
 	/* We cannot use basename(), as it would remove trailing slashes */
-	mingw_skip_dos_drive_prefix((char **)&path);
+	win_path_utils_skip_dos_drive_prefix((char **)&path);
 	if (!*path)
 		return 0;
 
@@ -2275,33 +2275,6 @@ pid_t waitpid(pid_t pid, int *status, int options)
 	return -1;
 }
 
-int mingw_skip_dos_drive_prefix(char **path)
-{
-	int ret = has_dos_drive_prefix(*path);
-	*path += ret;
-	return ret;
-}
-
-int mingw_offset_1st_component(const char *path)
-{
-	char *pos = (char *)path;
-
-	/* unc paths */
-	if (!skip_dos_drive_prefix(&pos) &&
-			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
-		/* skip server name */
-		pos = strpbrk(pos + 2, "\\/");
-		if (!pos)
-			return 0; /* Error: malformed unc path */
-
-		do {
-			pos++;
-		} while (*pos && !is_dir_sep(*pos));
-	}
-
-	return pos + is_dir_sep(*pos) - path;
-}
-
 int xutftowcsn(wchar_t *wcs, const char *utfs, size_t wcslen, int utflen)
 {
 	int upos = 0, wpos = 0;
diff --git a/compat/mingw.h b/compat/mingw.h
index 8c24ddaa3e..30d9fb3e36 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -443,32 +443,12 @@ HANDLE winansi_get_osfhandle(int fd);
  * git specific compatibility
  */
 
-#define has_dos_drive_prefix(path) \
-	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
-int mingw_skip_dos_drive_prefix(char **path);
-#define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
-static inline int mingw_is_dir_sep(int c)
-{
-	return c == '/' || c == '\\';
-}
-#define is_dir_sep mingw_is_dir_sep
-static inline char *mingw_find_last_dir_sep(const char *path)
-{
-	char *ret = NULL;
-	for (; *path; ++path)
-		if (is_dir_sep(*path))
-			ret = (char *)path;
-	return ret;
-}
 static inline void convert_slashes(char *path)
 {
 	for (; *path; path++)
 		if (*path == '\\')
 			*path = '/';
 }
-#define find_last_dir_sep mingw_find_last_dir_sep
-int mingw_offset_1st_component(const char *path);
-#define offset_1st_component mingw_offset_1st_component
 #define PATH_SEP ';'
 extern char *mingw_query_user_email(void);
 #define query_user_email mingw_query_user_email
diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
new file mode 100644
index 0000000000..6cb9a6a745
--- /dev/null
+++ b/compat/win32/path-utils.c
@@ -0,0 +1,28 @@
+#include "../../git-compat-util.h"
+
+int win_path_utils_skip_dos_drive_prefix(char **path)
+{
+	int ret = has_dos_drive_prefix(*path);
+	*path += ret;
+	return ret;
+}
+
+int win_path_utils_offset_1st_component(const char *path)
+{
+	char *pos = (char *)path;
+
+	/* unc paths */
+	if (!skip_dos_drive_prefix(&pos) &&
+			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
+		/* skip server name */
+		pos = strpbrk(pos + 2, "\\/");
+		if (!pos)
+			return 0; /* Error: malformed unc path */
+
+		do {
+			pos++;
+		} while (*pos && !is_dir_sep(*pos));
+	}
+
+	return pos + is_dir_sep(*pos) - path;
+}
diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
new file mode 100644
index 0000000000..c931b2a890
--- /dev/null
+++ b/compat/win32/path-utils.h
@@ -0,0 +1,20 @@
+#define has_dos_drive_prefix(path) \
+	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
+int win_path_utils_skip_dos_drive_prefix(char **path);
+#define skip_dos_drive_prefix win_path_utils_skip_dos_drive_prefix
+static inline int win_path_utils_is_dir_sep(int c)
+{
+	return c == '/' || c == '\\';
+}
+#define is_dir_sep win_path_utils_is_dir_sep
+static inline char *win_path_utils_find_last_dir_sep(const char *path)
+{
+	char *ret = NULL;
+	for (; *path; ++path)
+		if (is_dir_sep(*path))
+			ret = (char *)path;
+	return ret;
+}
+#define find_last_dir_sep win_path_utils_find_last_dir_sep
+int win_path_utils_offset_1st_component(const char *path);
+#define offset_1st_component win_path_utils_offset_1st_component
diff --git a/config.mak.uname b/config.mak.uname
index 3ee7da0e23..60876e26f4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -187,7 +187,7 @@ ifeq ($(uname_O),Cygwin)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
-	COMPAT_OBJS += compat/cygwin.o
+	COMPAT_OBJS += compat/win32/path-utils.o
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),FreeBSD)
@@ -527,6 +527,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
+		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
 	BASIC_CFLAGS += -DWIN32 -DPROTECT_NTFS_DEFAULT=1
diff --git a/git-compat-util.h b/git-compat-util.h
index 09b0102cae..5702556c89 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -193,10 +193,11 @@
 #endif
 
 #if defined(__CYGWIN__)
-#include "compat/cygwin.h"
+#include "compat/win32/path-utils.h"
 #endif
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
+#include "compat/win32/path-utils.h"
 #include "compat/mingw.h"
 #elif defined(_MSC_VER)
 #include "compat/msvc.h"
-- 
2.19.0.271.gfe8321ec05

