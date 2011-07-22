From: Jack Nagel <jacknagel@gmail.com>
Subject: [PATCH] Documentation: minor grammatical fix in rev-list-options.txt
Date: Thu, 21 Jul 2011 20:33:15 -0500
Message-ID: <1311298395-35050-1-git-send-email-jacknagel@gmail.com>
Cc: Jack Nagel <jacknagel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 03:33:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk4cN-0004Ym-V0
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 03:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab1GVBd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 21:33:26 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:54029 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab1GVBdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 21:33:25 -0400
Received: by pzk37 with SMTP id 37so2760720pzk.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 18:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/65Fww44owVYLhlZPu8EwLJaASOWuff6w1dEvm4ifg4=;
        b=QHHwawvVTPVVIsg90mQzG3De07WTqtGZAWz6ZZbo40MYAywdrZFllCZ4e4dDG593p9
         XUhk+VM8FZ/l1S80DHZBjmQGocufKXyAZxfEnOB4C3IXiw3ouscB3wR736zXhrZADhmj
         3E3NY/sKdODwEnnxXKHZlLc0WzJmnIAZ94j3E=
Received: by 10.68.36.198 with SMTP id s6mr1379883pbj.51.1311298405336;
        Thu, 21 Jul 2011 18:33:25 -0700 (PDT)
Received: from localhost.localdomain ([69.42.228.181])
        by mx.google.com with ESMTPS id b4sm1286202pba.43.2011.07.21.18.33.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 18:33:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177633>

Signed-off-by: Jack Nagel <jacknagel@gmail.com>
---
 Documentation/rev-list-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 554ab8c..39e6207 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -272,7 +272,7 @@ Default mode::
 
 --full-history::
 
-	As the default mode but does not prune some history.
+	Same as the default mode, but does not prune some history.
 
 --dense::
 
-- 
1.7.6
