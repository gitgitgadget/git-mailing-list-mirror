From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] Documentation: help: specify supported html browsers.
Date: Tue, 29 Jan 2008 07:08:29 +0100
Message-ID: <20080129070829.52985c45.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 07:03:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJjYd-0004Xm-Cv
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 07:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413AbYA2GC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 01:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbYA2GC1
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 01:02:27 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:60950 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413AbYA2GC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 01:02:26 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 458BA1AB2C8;
	Tue, 29 Jan 2008 07:02:25 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 01A801AB2C6;
	Tue, 29 Jan 2008 07:02:24 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71954>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-help.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 09904c7..fb77ca3 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -58,6 +58,16 @@ is available in PATH.
 +
 Note that the script tries, as much as possible, to display the HTML
 page in a new tab on an already opened browser.
++
+The following browsers are currently supported by 'git-help--browse':
++
+* firefox (this is the default under X Window when not using KDE)
+* iceweasel
+* konqueror (this is the default under KDE)
+* w3m (this is the default outside X Window)
+* links
+* lynx
+* dillo
 
 CONFIGURATION VARIABLES
 -----------------------
-- 
1.5.4.rc1.24.gf78d
