From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] Nicolas Pitre has a new email address
Date: Mon, 14 Sep 2009 02:41:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909140228050.22285@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_/AT2B2Ui2CCBSMa5aRBYeA)"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 08:41:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn5Fb-0006SP-4A
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 08:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbZINGlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 02:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbZINGlO
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 02:41:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27157 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZINGlN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 02:41:13 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KPY00B9V7WSCAE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Sep 2009 02:41:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128438>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_/AT2B2Ui2CCBSMa5aRBYeA)
Content-type: TEXT/PLAIN; charset=VISCII
Content-transfer-encoding: 8BIT

Due to problems at cam.org, my nico@cam.org email address is no longer 
valid.  FRom now on, nico@fluxnic.net should be used instead.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

I was sticking with nico@cam.org since I've been using that address 
for... hmm... something like 17 years now.  A major screw up was needed 
for me to move away from it.

diff --git a/.mailmap b/.mailmap
index 373476b..975e675 100644
--- a/.mailmap
+++ b/.mailmap
@@ -41,6 +41,7 @@ Michele Ballabio <barra_cuda@katamail.com>
 Nanako Shiraishi <nanako3@bluebottle.com>
 Nanako Shiraishi <nanako3@lavabit.com>
 Nguy­n Thái Ng÷c Duy <pclouds@gmail.com>
+<nico@fluxnic.net> <nico@cam.org>
 Philippe Bruhat <book@cpan.org>
 Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
 René Scharfe <rene.scharfe@lsrfire.ath.cx>
diff --git a/diff-delta.c b/diff-delta.c
index a4e28df..464ac3f 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -4,7 +4,7 @@
  * This code was greatly inspired by parts of LibXDiff from Davide Libenzi
  * http://www.xmailserver.org/xdiff-lib.html
  *
- * Rewritten for GIT by Nicolas Pitre <nico@cam.org>, (C) 2005-2007
+ * Rewritten for GIT by Nicolas Pitre <nico@fluxnic.net>, (C) 2005-2007
  *
  * This code is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/git.spec.in b/git.spec.in
index 4be0834..ab224f7 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -233,7 +233,7 @@ rm -rf $RPM_BUILD_ROOT
 * Tue Mar 27 2007 Eygene Ryabinkin <rea-git@codelabs.ru>
 - Added the git-p4 package: Perforce import stuff.
 
-* Mon Feb 13 2007 Nicolas Pitre <nico@cam.org>
+* Mon Feb 13 2007 Nicolas Pitre <nico@fluxnic.net>
 - Update core package description (Git isn't as stupid as it used to be)
 
 * Mon Feb 12 2007 Junio C Hamano <junkio@cox.net>
diff --git a/patch-delta.c b/patch-delta.c
index ef748ce..e02e13b 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -2,7 +2,7 @@
  * patch-delta.c:
  * recreate a buffer from a source and the delta produced by diff-delta.c
  *
- * (C) 2005 Nicolas Pitre <nico@cam.org>
+ * (C) 2005 Nicolas Pitre <nico@fluxnic.net>
  *
  * This code is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/progress.c b/progress.c
index 621c34e..132ed95 100644
--- a/progress.c
+++ b/progress.c
@@ -1,7 +1,7 @@
 /*
  * Simple text-based progress display module for GIT
  *
- * Copyright (c) 2007 by Nicolas Pitre <nico@cam.org>
+ * Copyright (c) 2007 by Nicolas Pitre <nico@fluxnic.net>
  *
  * This code is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/test-delta.c b/test-delta.c
index 3d885ff..af40a3c 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -1,7 +1,7 @@
 /*
  * test-delta.c: test code to exercise diff-delta.c and patch-delta.c
  *
- * (C) 2005 Nicolas Pitre <nico@cam.org>
+ * (C) 2005 Nicolas Pitre <nico@fluxnic.net>
  *
  * This code is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as

--Boundary_(ID_/AT2B2Ui2CCBSMa5aRBYeA)--
