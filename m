From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/5] Documentation/git-log.txt: capitalize section names
Date: Mon, 15 Jul 2013 15:07:19 +0200
Message-ID: <1373893639-13413-6-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqa9lof2e4.fsf@anie.imag.fr>
 <1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: stefanbeller@googlemail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 15:10:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyiY7-0005si-6b
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 15:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522Ab3GONKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 09:10:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40263 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756078Ab3GONKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 09:10:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r6FD7s2l019963
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 15:07:54 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UyiVP-0000YQ-Cf; Mon, 15 Jul 2013 15:07:55 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1UyiVP-0003XT-2E; Mon, 15 Jul 2013 15:07:55 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jul 2013 15:07:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FD7s2l019963
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374498476.48243@C04EnR3JBWdvXsKfn1TbKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230465>

This is the convention in other files and even at the beginning of git-log.txt

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-log.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2ea79ba..2eda5e4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -97,7 +97,7 @@ include::rev-list-options.txt[]
 
 include::pretty-formats.txt[]
 
-Common diff options
+COMMON DIFF OPTIONS
 -------------------
 
 :git-log: 1
@@ -105,7 +105,7 @@ include::diff-options.txt[]
 
 include::diff-generate-patch.txt[]
 
-Examples
+EXAMPLES
 --------
 `git log --no-merges`::
 
@@ -161,12 +161,12 @@ git log -L '/int main/',/^}/:main.c::
 `git log -3`::
 	Limits the number of commits to show to 3.
 
-Discussion
+DISCUSSION
 ----------
 
 include::i18n.txt[]
 
-Configuration
+CONFIGURATION
 -------------
 
 See linkgit:git-config[1] for core variables and linkgit:git-diff[1]
-- 
1.8.3.1.495.g13f33cf.dirty
