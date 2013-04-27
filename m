From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] documentation: trivial whitespace cleanups
Date: Sat, 27 Apr 2013 17:00:07 -0500
Message-ID: <1367100007-13711-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 28 00:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWDBc-0006By-DC
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 00:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3D0WB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 18:01:27 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:59706 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab3D0WB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 18:01:26 -0400
Received: by mail-oa0-f53.google.com with SMTP id m6so5004569oag.26
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=8d/NFw31vMhQbd3qP4/nIHA9DGHi6zMcBKTbPtvWTVg=;
        b=fUa4INkM2PgiWCCaU9Bv8676qgUJYlPLB+Dwx6VPWNctAbtQGwhVC8xozivprDYxoq
         OftQNefd8OZzXmF9YtJH4red4Exoz4g5OJSxxDel9g9bhdEWn+pGwVHK6AmTVLszVo/a
         fgw55ByJmo8kJG64mlGPYFz3aEbrCY6qu9loCpwW0d5C5u0hHAp7Mqa83hQ90/FLhwJE
         wPCzUrMjVzFONC8xXUT8VJR2FX6M7vpKYGsdkwuBqa71W3pvHGijfVsCL1fUEbiPYmGe
         ZlYspNxaBX0KhQpYnB/Rakb2K1Uq9QjZAmF0HSeLxo48HB+xryvG1rJ43J0sVmRtpBFo
         N+7g==
X-Received: by 10.182.66.41 with SMTP id c9mr20123778obt.76.1367100085762;
        Sat, 27 Apr 2013 15:01:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ri8sm2173172oeb.0.2013.04.27.15.01.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 15:01:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222708>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c67038b..6e53fc5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1104,11 +1104,11 @@ format.thread::
 	value disables threading.
 
 format.signoff::
-    A boolean value which lets you enable the `-s/--signoff` option of
-    format-patch by default. *Note:* Adding the Signed-off-by: line to a
-    patch should be a conscious act and means that you certify you have
-    the rights to submit this work under the same open source license.
-    Please see the 'SubmittingPatches' document for further discussion.
+	A boolean value which lets you enable the `-s/--signoff` option of
+	format-patch by default. *Note:* Adding the Signed-off-by: line to a
+	patch should be a conscious act and means that you certify you have
+	the rights to submit this work under the same open source license.
+	Please see the 'SubmittingPatches' document for further discussion.
 
 format.coverLetter::
 	A boolean that controls whether to generate a cover-letter when
@@ -1225,7 +1225,7 @@ gitcvs.dbname::
 
 gitcvs.dbdriver::
 	Used Perl DBI driver. You can specify any available driver
-        for this here, but it might not work. git-cvsserver is tested
+	for this here, but it might not work. git-cvsserver is tested
 	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
 	reported *not* to work with 'DBD::mysql'. Experimental feature.
 	May not contain double colons (`:`). Default: 'SQLite'.
-- 
1.8.2.1.1031.g2ee5873
