From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/5] README.md: add hyperlinks on filenames
Date: Thu, 25 Feb 2016 09:37:27 +0100
Message-ID: <1456389450-27118-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456389450-27118-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 09:38:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYrR5-0002ug-IS
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 09:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760139AbcBYIiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:38:07 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35284 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760123AbcBYIiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:38:05 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8bcrw012977
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 09:37:38 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8bdLM010488;
	Thu, 25 Feb 2016 09:37:39 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456389450-27118-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Feb 2016 09:37:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P8bcrw012977
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456994260.24654@Ib+DqLYeMenvwxfByzjFTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287343>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 README.md | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/README.md b/README.md
index 600779c..e54f9e7 100644
--- a/README.md
+++ b/README.md
@@ -21,17 +21,17 @@ License version 2 (some parts of it are under different licenses,
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
 
@@ -41,7 +41,7 @@ including full documentation and Git related tools.
 The user discussion and development of Git take place on the Git
 mailing list -- everyone is welcome to post bug reports, feature
 requests, comments and patches to git@vger.kernel.org (read
-Documentation/SubmittingPatches for instructions on patch submission).
+[Documentation/SubmittingPatches][] for instructions on patch submission).
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org. The mailing list archives are
 available at http://news.gmane.org/gmane.comp.version-control.git/,
@@ -51,3 +51,10 @@ The maintainer frequently sends the "What's cooking" reports that
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
