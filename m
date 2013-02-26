From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH] RelNotes/1.8.1.5: mention correct 'Fixes since'
Date: Tue, 26 Feb 2013 07:12:29 +0000
Message-ID: <1361862749-4920-1-git-send-email-stefan.naewe@gmail.com>
Cc: Stefan Naewe <stefan.naewe@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 08:13:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAEik-00012m-6z
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 08:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758163Ab3BZHMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 02:12:37 -0500
Received: from mail96.atlas.de ([194.156.172.86]:24127 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756077Ab3BZHMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 02:12:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id DC63210140;
	Tue, 26 Feb 2013 08:12:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id EWe4wpRNBWme; Tue, 26 Feb 2013 08:12:35 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue, 26 Feb 2013 08:12:35 +0100 (CET)
Received: from localhost (as112671.atlas.de [10.200.54.97])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 093F72716A;
	Tue, 26 Feb 2013 08:12:34 +0100 (CET)
X-Mailer: git-send-email 1.8.1.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217129>

RelNotes/1.8.1.5.txt mentions 'Fixes since v1.8.1.5'
which should obviously be empty. This fixes it.

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
 Documentation/RelNotes/1.8.1.5.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/1.8.1.5.txt b/Documentation/RelNotes/1.8.1.5.txt
index 92da6b2..0fb94a9 100644
--- a/Documentation/RelNotes/1.8.1.5.txt
+++ b/Documentation/RelNotes/1.8.1.5.txt
@@ -1,7 +1,7 @@
 Git 1.8.1.5 Release Notes
 =========================
 
-Fixes since v1.8.1.5
+Fixes since v1.8.1.4
 --------------------
 
  * "git apply --summary" has been taught to make sure the similarity
-- 
1.8.1.msysgit.1
