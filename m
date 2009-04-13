From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: fix 'linkgit' macro in "git-notes.txt"
Date: Tue, 14 Apr 2009 00:03:36 +0200
Message-ID: <20090414000336.51f7d206.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 00:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtUID-0007TW-C1
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 00:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbZDMWEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 18:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbZDMWEn
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 18:04:43 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:43515 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbZDMWEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 18:04:43 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 3FEA24C80D5;
	Tue, 14 Apr 2009 00:04:35 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id ECFE44C8090;
	Tue, 14 Apr 2009 00:04:32 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116493>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-notes.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

This patch applies on pu.

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 3d93625..7136016 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -43,4 +43,4 @@ Documentation by Johannes Schindelin
 
 GIT
 ---
-Part of the gitlink:git[7] suite
+Part of the linkgit:git[7] suite
-- 
1.6.2.2.572.g4420a
