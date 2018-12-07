Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7788F20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 17:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLGRFC (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 12:05:02 -0500
Received: from mout.web.de ([212.227.17.11]:40659 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeLGRFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 12:05:01 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaTeV-1hBlRN1mrX-00mH0E; Fri, 07
 Dec 2018 18:04:58 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, svnpenn@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/3] git clone <url> C:\cygwin\home\USER\repo' is working (again)
Date:   Fri,  7 Dec 2018 18:04:56 +0100
Message-Id: <20181207170456.8994-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
In-Reply-To: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LaBS37p3vbgGVAZlYLq3UTOddOMm3NHlw7ZLpyy2sri5EcMhEBz
 MMcM6J5IdwDmJbBWGquI0a/MQvzHvuwSWW5vyzkBEN2aJluOfUqQnufRYHCHfQt/tDgwLtl
 74FE1d1yc1cBf54E/mgV3unck+LsYGys6fl4YHt8FQo+jNngP/TVPwxQOFNl05TdFh4brBa
 49846kymOtE5dU0oBnHGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YZ+5dkHKnAg=:JAZr3n/7hQzpe51q4E8zSd
 DRgAFRlTcHLVXV757DyfdHzlCvScPtJl/Ik3Gbc29a6jFC03+OuCKLhgBMNgT0HW6ubgHYKNe
 nnbIm5qRncZqMr29PfKSsJpm0+e50JP2Vybo+z0x/gfs5TB1ysCJqoFm68hLM515jxE94S3kK
 YH/+OqDSt0WGgeKv3cldT1BA4xBuzp6d3XvlOQ8U86/lFNfuJo+TYzkMBOsebsZXDLjfh6wV3
 H+tYrulK9hYXkz51OJ4jJS6OQ1iiGdRrrZfW18c2ya+/KZ9qftlYPWaXrH6MFhjVjFvXtAIwR
 xC4kRxI8kysJxcxjIwSgijVa9X3hjvMwsFo/BL1GiS2dnwQ4Jf/bE7aPRlDYyg/SDpncYu0Cf
 UFsfbOx5BEPbvmxYwFslDPM6J16cW4qHNJkEaEoCRRNAIRXtrQht9A+PZYsPsJ27xhs4/17Gh
 doCnVoK21IX4gqx0himKTRe7YqSN6dxMgMBUzQFRB6DKUxvLVxQTU8kwB4MbL0V6Ve3DaZUYe
 RLot6NeJH4LGxryPDRNQaxzsz6+O9f+ay39KCJMIblj3AWPn/TDFpzlZ//sk28kdLYwpI9Mps
 trGVCmeMksx3jJq+MdBBsr7fZfOmO8dLngOMuHPePsh3oj7IdvrlPFUDr9qIm6RQ2KDNh2KHk
 7W90XxD3qRuM9//+7viw0P2/7gcKGSnsoWU7DfZ1ZcIhhvngYOggkme3q4Ihgly82l8o33dE7
 aC3XtZKO75kpdeFhOUa1lRVUegm1vROmUUNY3x4RuYq3arMgpIiOAep5gTzhHWKwvJ0vKzcge
 TqbfAW9FfXsq+YIlXZN8aQGqm/6XEE6XvyNMfXJCe1FrojquTyNDFU8fNZJLn82o2PO6Dcq5P
 O/sZhyYfL5hpo8XWGe6OgO7uRV3NY6fN0PYtjr/5FUUOZ2/JIJaBqIyUIfqQoU
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

Instead of duplicating the code, it is extracted into compat/mingw-cygwin.[ch]
Some need for refactoring and cleanup came up in the review, they are adressed
in a seperate commit.

Reported-By: Steven Penny <svnpenn@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 compat/cygwin.c       | 19 -------------------
 compat/cygwin.h       |  2 --
 compat/mingw-cygwin.c | 28 ++++++++++++++++++++++++++++
 compat/mingw-cygwin.h | 20 ++++++++++++++++++++
 compat/mingw.c        | 29 +----------------------------
 compat/mingw.h        | 20 --------------------
 config.mak.uname      |  4 ++--
 git-compat-util.h     |  3 ++-
 8 files changed, 53 insertions(+), 72 deletions(-)
 delete mode 100644 compat/cygwin.c
 delete mode 100644 compat/cygwin.h
 create mode 100644 compat/mingw-cygwin.c
 create mode 100644 compat/mingw-cygwin.h

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
diff --git a/compat/mingw-cygwin.c b/compat/mingw-cygwin.c
new file mode 100644
index 0000000000..c63d7acb9c
--- /dev/null
+++ b/compat/mingw-cygwin.c
@@ -0,0 +1,28 @@
+#include "../git-compat-util.h"
+
+int mingw_cygwin_skip_dos_drive_prefix(char **path)
+{
+	int ret = has_dos_drive_prefix(*path);
+	*path += ret;
+	return ret;
+}
+
+int mingw_cygwin_offset_1st_component(const char *path)
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
diff --git a/compat/mingw-cygwin.h b/compat/mingw-cygwin.h
new file mode 100644
index 0000000000..66ccc909ae
--- /dev/null
+++ b/compat/mingw-cygwin.h
@@ -0,0 +1,20 @@
+#define has_dos_drive_prefix(path) \
+	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
+int mingw_cygwin_skip_dos_drive_prefix(char **path);
+#define skip_dos_drive_prefix mingw_cygwin_skip_dos_drive_prefix
+static inline int mingw_cygwin_is_dir_sep(int c)
+{
+	return c == '/' || c == '\\';
+}
+#define is_dir_sep mingw_cygwin_is_dir_sep
+static inline char *mingw_cygwin_find_last_dir_sep(const char *path)
+{
+	char *ret = NULL;
+	for (; *path; ++path)
+		if (is_dir_sep(*path))
+			ret = (char *)path;
+	return ret;
+}
+#define find_last_dir_sep mingw_cygwin_find_last_dir_sep
+int mingw_cygwin_offset_1st_component(const char *path);
+#define offset_1st_component mingw_cygwin_offset_1st_component
diff --git a/compat/mingw.c b/compat/mingw.c
index 34b3880b29..038e96af9d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -350,7 +350,7 @@ static inline int needs_hiding(const char *path)
 		return 0;
 
 	/* We cannot use basename(), as it would remove trailing slashes */
-	mingw_skip_dos_drive_prefix((char **)&path);
+	mingw_cygwin_skip_dos_drive_prefix((char **)&path);
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
diff --git a/config.mak.uname b/config.mak.uname
index 3ee7da0e23..9346f67922 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -187,7 +187,7 @@ ifeq ($(uname_O),Cygwin)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
-	COMPAT_OBJS += compat/cygwin.o
+	COMPAT_OBJS += compat/mingw-cygwin.o
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),FreeBSD)
@@ -526,7 +526,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	DEFAULT_HELP_FORMAT = html
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
+	COMPAT_OBJS += compat/mingw.o compat/mingw-cygwin.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
 	BASIC_CFLAGS += -DWIN32 -DPROTECT_NTFS_DEFAULT=1
diff --git a/git-compat-util.h b/git-compat-util.h
index 09b0102cae..7ece969b22 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -193,10 +193,11 @@
 #endif
 
 #if defined(__CYGWIN__)
-#include "compat/cygwin.h"
+#include "compat/mingw-cygwin.h"
 #endif
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
+#include "compat/mingw-cygwin.h"
 #include "compat/mingw.h"
 #elif defined(_MSC_VER)
 #include "compat/msvc.h"
-- 
2.19.0.271.gfe8321ec05

