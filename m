From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] check-ignore doc: fix broken link to ls-files page
Date: Sun, 30 Jun 2013 17:35:28 +0530
Message-ID: <1372593928-403-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 30 14:09:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtGRA-0001Ii-MN
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 14:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab3F3MIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 08:08:43 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:44791 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab3F3MIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 08:08:43 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so3821112pbb.6
        for <git@vger.kernel.org>; Sun, 30 Jun 2013 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Td2IyIlzvsYo5VS52Dee14oSNpk+INW+M8CJPgLg9/Y=;
        b=j/svK0IH2xipfOi1QW3htASgq4jHwjEkgt9dZGJwHtPmadFdVW/SHlHfsz5n7NNQSd
         l2jEjATbmciOjts7dm/5Tt3PNE3s9rursPh2BiYtxJBrY78I5keyWpEvOfwDbGl6oTNR
         0R1S7bDVyjjKZL5fCVVUlNqaFq7roDGUlnlCLYpEBfR/VDUHjpb3qHw6Y86TYWaUYuFl
         wmXNeDmNPruiHMXBVHKGlF99jV7wJNnhwQ3fzWJC0L49zqMk/LHYh9RWw59rF8QdNz2Y
         nLB3yVs+fPFA03e6c89ooEueZ8zYxBNPIoI4G4seDkFzRlQXFVEBeDndmxrYIybHP8L0
         Hukg==
X-Received: by 10.68.203.161 with SMTP id kr1mr19334978pbc.192.1372594122455;
        Sun, 30 Jun 2013 05:08:42 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id ve3sm17139531pbc.14.2013.06.30.05.08.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Jun 2013 05:08:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.643.gebeea52.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229277>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-check-ignore.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 8e1f7ab..d2df487 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -102,7 +102,7 @@ SEE ALSO
 --------
 linkgit:gitignore[5]
 linkgit:gitconfig[5]
-linkgit:git-ls-files[5]
+linkgit:git-ls-files[1]
 
 GIT
 ---
-- 
1.8.3.1.643.gebeea52.dirty
