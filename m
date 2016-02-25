From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 3/5] README.md: move the link to git-scm.com up
Date: Thu, 25 Feb 2016 09:37:28 +0100
Message-ID: <1456389450-27118-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456389450-27118-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 09:38:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYrQu-0002n3-V0
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 09:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760121AbcBYIhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:37:55 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54870 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760113AbcBYIhx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:37:53 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8bdTK008479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 09:37:39 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8bdLN010488;
	Thu, 25 Feb 2016 09:37:39 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456389450-27118-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 25 Feb 2016 09:37:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P8bdTK008479
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456994260.10319@Q+QEowVK8rCCXzUWbQbCxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287342>

The documentation available on git-scm.com is nicely formatted. It's
better to point users to it than to the source code of the
documentation.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 README.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index e54f9e7..5500f8a 100644
--- a/README.md
+++ b/README.md
@@ -23,6 +23,9 @@ Torvalds with help of a group of hackers around the net.
 
 Please read the file [INSTALL][] for installation instructions.
 
+Many Git online resources are accessible from http://git-scm.com/
+including full documentation and Git related tools.
+
 See [Documentation/gittutorial.txt][] to get started, then see
 [Documentation/giteveryday.txt][] for a useful minimum set of commands, and
 [Documentation/git-commandname.txt][] for documentation of each command.
@@ -35,9 +38,6 @@ CVS users may also want to read [Documentation/gitcvs-migration.txt][]
 ("man gitcvs-migration" or "git help cvs-migration" if git is
 installed).
 
-Many Git online resources are accessible from http://git-scm.com/
-including full documentation and Git related tools.
-
 The user discussion and development of Git take place on the Git
 mailing list -- everyone is welcome to post bug reports, feature
 requests, comments and patches to git@vger.kernel.org (read
-- 
2.7.2.334.g35ed2ae.dirty
