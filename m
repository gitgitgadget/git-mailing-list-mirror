From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] Documentation/git-web--browse.txt: fix small typo
Date: Thu, 15 May 2008 20:52:22 +0300
Message-ID: <20080515175222.GA16056@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 19:54:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwhel-0003ZP-Fr
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 19:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbYEORx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 13:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbYEORx3
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 13:53:29 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:37755 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751543AbYEORx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 13:53:29 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 482B3B1A00103D81; Thu, 15 May 2008 20:52:26 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jwhcs-0004BH-Vb; Thu, 15 May 2008 20:52:22 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82215>

Change "brower.konqueror.path" to "browser.konqueror.path" in
documentation.

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 Documentation/git-web--browse.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 92ef574..5ba0b9f 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -78,7 +78,7 @@ When 'konqueror' is specified by the a command line option or a
 configuration variable, we launch 'kfmclient' to try to open the HTML
 man page on an already opened konqueror in a new tab if possible.
 
-For consistency, we also try such a trick if 'brower.konqueror.path' is
+For consistency, we also try such a trick if 'browser.konqueror.path' is
 set to something like 'A_PATH_TO/konqueror'. That means we will try to
 launch 'A_PATH_TO/kfmclient' instead.
 
-- 
1.5.5.1.262.gc8df9
