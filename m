From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 6/6] Documentation/git-log.txt: capitalize section names
Date: Mon, 15 Jul 2013 19:55:25 +0200
Message-ID: <1373910925-18422-7-git-send-email-Matthieu.Moy@imag.fr>
References: <20130715173536.GB14690@google.com>
 <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: jrnieder@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 19:57:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyn1O-000506-GY
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab3GOR5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:57:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45514 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910Ab3GOR5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:57:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6FHtvr6010136
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 19:55:57 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uyn0B-00043r-IK; Mon, 15 Jul 2013 19:55:59 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Uyn0B-0004ob-8U; Mon, 15 Jul 2013 19:55:59 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jul 2013 19:55:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FHtvr6010136
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374515761.28323@IKwb9QpBhHxdFn1LpHcdsQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230506>

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
