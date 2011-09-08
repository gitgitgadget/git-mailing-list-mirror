From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: [PATCH] Add a note to the README for new contributors
Date: Thu,  8 Sep 2011 17:45:16 +1000
Message-ID: <1315467916-2916-1-git-send-email-andrew.ardill@gmail.com>
References: <1315464479-6876-1-git-send-email-andrew.ardill@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 09:45:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1ZJ1-0001Xj-DZ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 09:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276Ab1IHHpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 03:45:34 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38274 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267Ab1IHHp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 03:45:26 -0400
Received: by gxk21 with SMTP id 21so789649gxk.5
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FlOzROqj7basS6UMMcXgjlAd+GjSYvJfpHQ92OVooc4=;
        b=I9EZcrXGEMB848R6AHFiJXNWfyrFVVjTpYfo49ZlKIu9XKuHm4z+pYLAFXX0LyJlXA
         SjXRYrS9XbGwpgDyDU/0pzBai546lJTvpdKkaLwXjw/v3S2F5Ueg8nsLOnViqC4F6kgu
         HzHFFfGl2sZB0bB1k1/gEsyOZEItSjIVtldiI=
Received: by 10.236.178.10 with SMTP id e10mr2144289yhm.31.1315467925385;
        Thu, 08 Sep 2011 00:45:25 -0700 (PDT)
Received: from localhost ([59.167.165.193])
        by mx.google.com with ESMTPS id x65sm2720689yhh.26.2011.09.08.00.45.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Sep 2011 00:45:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0
In-Reply-To: <1315464479-6876-1-git-send-email-andrew.ardill@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180947>

Signed-off-by: Andrew Ardill <andrew.ardill@gmail.com>
---
 README |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/README b/README
index 67cfeb2..b67a881 100644
--- a/README
+++ b/README
@@ -52,3 +52,7 @@ git.git (stable)" and "What's cooking in git.git (topics)" and
 the discussion following them on the mailing list give a good
 reference for project status, development direction and
 remaining tasks.
+
+If you are looking to contribute to the project, a good place to start
+is http://git-blame.blogspot.com/p/note-from-maintainer.html and in
+Documentation/howto/maintain-git.txt
-- 
1.7.6.msysgit.0
