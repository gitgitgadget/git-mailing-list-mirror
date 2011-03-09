From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH] Fix typo in t/README
Date: Wed, 09 Mar 2011 21:25:09 +0100
Message-ID: <4D77E225.8060009@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 09 21:25:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxPwh-00072N-7b
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 21:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257Ab1CIUZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 15:25:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:50794 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab1CIUZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 15:25:16 -0500
Received: from [192.168.2.100] (p579A5606.dip.t-dialin.net [87.154.86.6])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0M9ulU-1PqnA22chs-00BYmI; Wed, 09 Mar 2011 21:25:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
X-Provags-ID: V02:K0:eSIY/O0tiIjRIwuN0UCllA5/HpLAeu6wdTDUq7I6zWO
 yk8BzQ7w2RH6LGijBVO5eg0Klr8ptqVXrt5ejRwnsgPF86tgaQ
 tW7bGZSpEwOkpWf/GcaK9iBWJkDFz8Sena5dtkTnA623K51bdi
 0YZUbHBn4Eh8glR3z6mpNc6qojtb8bZymLfPSBoCvGNxhbR7QY
 9QAMtk0yIxv7hRhPMqEfm4LwSEQ1lbSMHRa/q71LMg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168754>


Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
 t/README |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/README b/t/README
index 25f7d2d..78c9e65 100644
--- a/t/README
+++ b/t/README
@@ -328,7 +328,7 @@ Keep in mind:
 Skipping tests
 --------------
 
-If you need to skip tests you should do so be using the three-arg form
+If you need to skip tests you should do so by using the three-arg form
 of the test_* functions (see the "Test harness library" section
 below), e.g.:
 
-- 
1.7.4.1.48.g5673d
