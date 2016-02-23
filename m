From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/5] README.md: add hyperlinks on filenames
Date: Tue, 23 Feb 2016 18:40:26 +0100
Message-ID: <1456249229-30454-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: emma.westby@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:41:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYGxZ-000618-Es
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbcBWRlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:41:09 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46917 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754733AbcBWRlI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:41:08 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHexdV021011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 18:40:59 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHf0l6012837;
	Tue, 23 Feb 2016 18:41:01 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 18:40:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NHexdV021011
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456854060.68841@5nbxnYG7c2dL/EL774FU4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287088>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 README.md | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/README.md b/README.md
index 907eb3b..750fdda 100644
--- a/README.md
+++ b/README.md
@@ -20,17 +20,17 @@ License version 2 (some parts of it are under different licenses,
 compatible with the GPLv2). It was originally written by Linus
 Torvalds with help of a group of hackers around the net.
 
-Please read the file INSTALL for installation instructions.
+Please read the file [INSTALL][] for installation instructions.
 
-See Documentation/gittutorial.txt to get started, then see
-Documentation/giteveryday.txt for a useful minimum set of commands, and
-Documentation/git-commandname.txt for documentation of each command.
+See [Documentation/gittutorial.txt][] to get started, then see
+[Documentation/giteveryday.txt][] for a useful minimum set of commands, and
+[Documentation/git-commandname.txt][] for documentation of each command.
 If git has been correctly installed, then the tutorial can also be
 read with "man gittutorial" or "git help tutorial", and the
 documentation of each command with "man git-commandname" or "git help
 commandname".
 
-CVS users may also want to read Documentation/gitcvs-migration.txt
+CVS users may also want to read [Documentation/gitcvs-migration.txt][]
 ("man gitcvs-migration" or "git help cvs-migration" if git is
 installed).
 
@@ -40,7 +40,7 @@ including full documentation and Git related tools.
 The user discussion and development of Git take place on the Git
 mailing list -- everyone is welcome to post bug reports, feature
 requests, comments and patches to git@vger.kernel.org (read
-Documentation/SubmittingPatches for instructions on patch submission).
+[Documentation/SubmittingPatches][] for instructions on patch submission).
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org. The mailing list archives are
 available at http://news.gmane.org/gmane.comp.version-control.git/,
@@ -50,3 +50,10 @@ The maintainer frequently sends the "What's cooking" reports that
 list the current status of various development topics to the mailing
 list.  The discussion following them give a good reference for
 project status, development direction and remaining tasks.
+
+[INSTALL]: INSTALL
+[Documentation/gittutorial.txt]: Documentation/gittutorial.txt
+[Documentation/giteveryday.txt]: Documentation/giteveryday.txt
+[Documentation/git-commandname.txt]: Documentation/git-commandname.txt
+[Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
+[Documentation/SubmittingPatches]: Documentation/SubmittingPatches
-- 
2.7.2.334.g35ed2ae.dirty
