From: Stefan Naewe <stefan.naewe@googlemail.com>
Subject: [PATCH] README: git lives at http://git-scm.com these days
Date: Wed,  7 Oct 2009 14:14:24 +0200
Message-ID: <1254917664-892-1-git-send-email-stefan.naewe+git@gmail.com>
Cc: gitster@pobox.com, Stefan Naewe <stefan.naewe+git@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 07 14:25:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvVaR-0008PR-MR
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 14:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933034AbZJGMXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 08:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933030AbZJGMXh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 08:23:37 -0400
Received: from mail-ew0-f225.google.com ([209.85.219.225]:51287 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933025AbZJGMXg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 08:23:36 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2009 08:23:36 EDT
Received: by ewy25 with SMTP id 25so4725186ewy.21
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=31UGaTRHgRLq1F7mE5pHZN2NbIdjzcSsCWrWBm2k/hU=;
        b=KmN0CdrPr+pjjSs3VEU3ZMc0NfXkWkbOQ/OWQt+qqh1BaYxNn2qpwiyPQ3W6OkPE2D
         q8DqsPMBxDZMS5b3HPEedp9rXt1TYKuAc/CrLaTxhi1I3f3CtxPoe7pL08FZtwYiCR8X
         Cc65b+jEFB00xeUygwl/79GIcswZe4wujjmIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=skI1HVRNA2OMnJuDlnCddAl2Jt4P20ZBvwMYg4YUDP/uFfKr3xa3SYkWc6FQ4hO2Wm
         fKArV84QcJBrYtrarwF3a9Dx1BwJ4jS6co1bKnDX485hLDMFY2HWSxoo7r/uWpyYet+k
         yoby5ZLpOKNhkzcx3JHXQE5FievvFZsd579Uc=
Received: by 10.211.160.4 with SMTP id m4mr3170070ebo.24.1254917680470;
        Wed, 07 Oct 2009 05:14:40 -0700 (PDT)
Received: from localhost.localdomain (dyndsl-095-033-117-238.ewe-ip-backbone.de [95.33.117.238])
        by mx.google.com with ESMTPS id 5sm181013eyh.8.2009.10.07.05.14.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 05:14:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129644>

Signed-off-by: Stefan Naewe <stefan.naewe+git@gmail.com>
---
 README |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/README b/README
index c932ab3..67cfeb2 100644
--- a/README
+++ b/README
@@ -37,7 +37,7 @@ CVS users may also want to read Documentation/gitcvs-migration.txt
 ("man gitcvs-migration" or "git help cvs-migration" if git is
 installed).
 
-Many Git online resources are accessible from http://git.or.cz/
+Many Git online resources are accessible from http://git-scm.com/
 including full documentation and Git related tools.
 
 The user discussion and development of Git take place on the Git
-- 
1.6.4.4
