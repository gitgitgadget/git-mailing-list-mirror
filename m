From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] README: fix broken mailing list archive link
Date: Tue, 29 Jan 2013 16:10:39 +0530
Message-ID: <1359456039-20562-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 11:40:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U08bm-0007uE-O7
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 11:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab3A2Kjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 05:39:44 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64060 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab3A2Kjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 05:39:43 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so321235pac.29
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer;
        bh=EBlPvn1teqzJdSCAlVLCVNJyhU6E4TObX5XgKQcFqYU=;
        b=obhPNSTd1ewkvgwmSn5mpabv1WXmqNhhbcGczc2VxPCSASnyJyjSQd/7RJjavHG3Tr
         YDsWs8uTouL00KluB/GfFe0lzZPfE8VOwibifQx/2Lc8HS+ymnvYmAhH76N+VpcWqSj6
         HAuUolmGWo4Fb6h5sfHUe03dN2KW0UKaOBO1a8xJ8pqHmDRkynw+mLfyPfyJ61GeqWY5
         L7fuvNWxmflJ/9qfnaBfoS1m9h0cNyo+Au8Uno+zpYhiHND7DoZEfH/yumqPQ0YhI1ra
         ZBnFM4J3RS5wP2Lzl6fgrd0nuw/JzuHHLHLTN8St1hEaszLIkZyOzbfQXRsG9qOZuY0p
         Rh/A==
X-Received: by 10.66.76.37 with SMTP id h5mr1563873paw.33.1359455983034;
        Tue, 29 Jan 2013 02:39:43 -0800 (PST)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id kl3sm8184776pbc.15.2013.01.29.02.39.40
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 02:39:42 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214925>

marc.theaimsgroup.com does not exist anymore, so replace it
with a link to the archive on GMane.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 README |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 49713ea..3aae16a 100644
--- a/README
+++ b/README
@@ -47,8 +47,8 @@ requests, comments and patches to git@vger.kernel.org (read
 Documentation/SubmittingPatches for instructions on patch submission).
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org. The mailing list archives are
-available at http://marc.theaimsgroup.com/?l=git and other archival
-sites.
+available at http://thread.gmane.org/gmane.comp.version-control.git/
+and other archival sites.
 
 The messages titled "A note from the maintainer", "What's in
 git.git (stable)" and "What's cooking in git.git (topics)" and
-- 
1.7.10.4
