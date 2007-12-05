From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Documentation: add --patch option to synopsis of git-add
Date: Wed,  5 Dec 2007 12:28:50 +0100
Message-ID: <1196854130-24256-1-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 05 12:35:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzsX0-00045r-Te
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 12:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXLELeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 06:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbXLELeu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 06:34:50 -0500
Received: from mail13.bluewin.ch ([195.186.18.62]:45886 "EHLO
	mail13.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbXLELet (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 06:34:49 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2007 06:34:49 EST
Received: from localhost.localdomain (83.76.122.69) by mail13.bluewin.ch (Bluewin 7.3.121)
        id 471B42C800C50B84; Wed, 5 Dec 2007 11:28:49 +0000
X-Mailer: git-send-email 1.5.3.7.2094.gff6c-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67146>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Documentation/git-add.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e74f83b..bf94cd4 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -8,7 +8,7 @@ git-add - Add file contents to the index
 SYNOPSIS
 --------
 [verse]
-'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh]
+'git-add' [-n] [-v] [-f] [--interactive | -i] [--patch | -p] [-u] [--refresh]
           [--] <filepattern>...
 
 DESCRIPTION
-- 
1.5.3.7.2094.gff6c-dirty
