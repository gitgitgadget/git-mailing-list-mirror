From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/3] merge-recursive: Add copyright notice
Date: Sat, 12 Nov 2005 00:54:55 +0100
Message-ID: <20051111235455.GB9757@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Nov 12 00:57:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eaiji-0008NV-9e
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 00:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVKKXzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 18:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVKKXzF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 18:55:05 -0500
Received: from [85.8.31.11] ([85.8.31.11]:64148 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750765AbVKKXzB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 18:55:01 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 3A33F40FD; Sat, 12 Nov 2005 01:03:29 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EaijP-0006Qy-00; Sat, 12 Nov 2005 00:54:55 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11650>


Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---


 git-merge-recursive.py |    3 +++
 gitMergeCommon.py      |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

applies-to: ec5d71bfe5c1519652081888a49f36b1bd044975
eeffb2de39045197fe945959e7029ca146540353
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index e6cbdde..21f1e92 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -1,4 +1,7 @@
 #!/usr/bin/python
+#
+# Copyright (C) 2005 Fredrik Kuivinen
+#
 
 import sys, math, random, os, re, signal, tempfile, stat, errno, traceback
 from heapq import heappush, heappop
diff --git a/gitMergeCommon.py b/gitMergeCommon.py
index 1b5bddd..ff6f58a 100644
--- a/gitMergeCommon.py
+++ b/gitMergeCommon.py
@@ -1,3 +1,7 @@
+#
+# Copyright (C) 2005 Fredrik Kuivinen
+#
+
 import sys, re, os, traceback
 from sets import Set
 
---
0.99.9.GIT
