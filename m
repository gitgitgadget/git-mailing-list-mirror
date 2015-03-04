From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] Disclaimer about the number of slots.
Date: Wed,  4 Mar 2015 08:19:31 +0100
Message-ID: <1425453571-8771-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1425453571-8771-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 08:19:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT3ax-0004Ao-6e
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbbCDHTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 02:19:46 -0500
Received: from mx1.imag.fr ([129.88.30.5]:32875 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935132AbbCDHTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 02:19:44 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t247JZeZ002753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Mar 2015 08:19:35 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t247JZRd028476;
	Wed, 4 Mar 2015 08:19:35 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YT3ah-0002PP-QS; Wed, 04 Mar 2015 08:19:35 +0100
X-Mailer: git-send-email 2.3.0.157.g79e124b
In-Reply-To: <1425453571-8771-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 04 Mar 2015 08:19:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t247JZeZ002753
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1426058375.60241@sfpqWG6nb9/O9tb0NPJLIQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264727>

This is debatable, but this may discourrage students who picked Git more
or less at random. If I read
https://code.google.com/p/google-summer-of-code/wiki/ProgramStatistics
correctly, the average number of slots per organization is closer to 10
than 2, hence students have better chance to get accepted in other
organizations.

OTOH, 2 slots is not so much worse than the 3 we had last year. And now
that Dscho is volunteer to mentor a GSoC too, we may actually end up
accepting 3 students.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
So, sending this in case other people think it's a good idea, but I
won't fight for it in case you don't think it is.

 SoC-2015-Ideas.md | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/SoC-2015-Ideas.md b/SoC-2015-Ideas.md
index d2b7d75..23c8313 100644
--- a/SoC-2015-Ideas.md
+++ b/SoC-2015-Ideas.md
@@ -20,6 +20,11 @@ Please, include link(s) to the mailing-list discussion(s) related to
 your microproject in your application (e.g. linking to
 [gmane](http://news.gmane.org/gmane.comp.version-control.git)).
 
+## Note about the number of slots
+
+In 2015, the Git organization has very limited mentoring capacity.
+We will probably be able to accept 2 students only this year.
+
 ## Summer of code main project ideas
 
 **Students**: Please consider these ideas as starting points for
-- 
2.3.0.157.g79e124b
