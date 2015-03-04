From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] Ask students to include a link to their microproject in their application
Date: Wed,  4 Mar 2015 08:19:30 +0100
Message-ID: <1425453571-8771-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 08:19:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT3aw-0004Ao-JS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935134AbbCDHTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 02:19:44 -0500
Received: from mx2.imag.fr ([129.88.30.17]:34207 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935130AbbCDHTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 02:19:42 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t247JYM4006853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Mar 2015 08:19:34 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t247JYNR028473;
	Wed, 4 Mar 2015 08:19:34 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YT3ag-0002PB-Nh; Wed, 04 Mar 2015 08:19:34 +0100
X-Mailer: git-send-email 2.3.0.157.g79e124b
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Mar 2015 08:19:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t247JYM4006853
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1426058376.85597@lXHQH552JO8h+BXKISO1rA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264726>

It makes it easier for us when reviewing/selecting candidates.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
(Sending this to the list for comments, but now I can even do the push
myself :-) )

 SoC-2015-Ideas.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/SoC-2015-Ideas.md b/SoC-2015-Ideas.md
index 86de476..d2b7d75 100644
--- a/SoC-2015-Ideas.md
+++ b/SoC-2015-Ideas.md
@@ -16,6 +16,10 @@ way for us to get experience with applicants, but it will also help
 applicants become familiar with Git's development and submission
 process.
 
+Please, include link(s) to the mailing-list discussion(s) related to
+your microproject in your application (e.g. linking to
+[gmane](http://news.gmane.org/gmane.comp.version-control.git)).
+
 ## Summer of code main project ideas
 
 **Students**: Please consider these ideas as starting points for
-- 
2.3.0.157.g79e124b
