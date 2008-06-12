From: Mikael Magnusson <mikachu@gmail.com>
Subject: [PATCH] Typo in RelNotes.
Date: Thu, 12 Jun 2008 04:38:38 +0200 (CEST)
Message-ID: <alpine.LNX.1.00.0806120434290.5838@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 04:46:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6cpM-0003RZ-30
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 04:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbYFLCpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 22:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbYFLCpV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 22:45:21 -0400
Received: from mail.bredband2.net ([82.209.166.4]:11455 "EHLO
	smtp.bredband2.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753031AbYFLCpU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 22:45:20 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jun 2008 22:45:20 EDT
Received: (qmail 11900 invoked from network); 12 Jun 2008 02:38:46 -0000
Received: from kr-lun-154-152-233-83.3.cust.bredband2.com (HELO mika.l3ib.org) ([83.233.152.154])
          (envelope-sender <mikachu@gmail.com>)
          by smtp.bredband2.net (qmail-ldap-1.03) with SMTP
          for <gitster@pobox.com>; 12 Jun 2008 02:38:46 -0000
User-Agent: Alpine 1.00 (LNX )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84692>

Signed-off-by: Mikael Magnusson <mikachu@gmail.com>

---

This is the first patch I send for git so I hope i didn't do anything silly :).

  Documentation/RelNotes-1.5.6.txt |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes-1.5.6.txt b/Documentation/RelNotes-1.5.6.txt
index a79e4b9..ac4881e 100644
--- a/Documentation/RelNotes-1.5.6.txt
+++ b/Documentation/RelNotes-1.5.6.txt
@@ -70,7 +70,7 @@ Updates since v1.5.5

  * "git init --bare" is a synonym for "git --bare init" now.

-* "git gc --auto" honors a new pre-aut-gc hook to temporarily disable it.
+* "git gc --auto" honors a new pre-auto-gc hook to temporarily disable it.

  * "git log --pretty=tformat:<custom format>" gives a LF after each entry,
    instead of giving a LF between each pair of entries which is how
-- 
1.5.5.GIT


--
Mikael Magnusson
