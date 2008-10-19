From: Fredrik Skolmli <fredrik@frsk.net>
Subject: [PATCH] Documentation: Spelling fix
Date: Sun, 19 Oct 2008 18:09:43 +0200
Message-ID: <20081019160943.GA20862@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 20 08:30:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kras4-0001Bb-62
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 18:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbYJSQJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 12:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbYJSQJv
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 12:09:51 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:50292 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbYJSQJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 12:09:51 -0400
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1Kraqe-0007C7-0a; Sun, 19 Oct 2008 18:09:44 +0200
Received: from fredrik by asterix.frsk.net with local (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1Kraqd-0003Aa-IO; Sun, 19 Oct 2008 18:09:43 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98618>


Signed-off-by: Fredrik Skolmli <fredrik@frsk.net>
---
 Documentation/git-checkout.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 2b344e1..ea05a7a 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -88,7 +88,7 @@ This would tell us to use "hack" as the local branch when branching
 off of "origin/hack" (or "remotes/origin/hack", or even
 "refs/remotes/origin/hack").  If the given name has no slash, or the above
 guessing results in an empty name, the guessing is aborted.  You can
-exlicitly give a name with '-b' in such a case.
+explicitly give a name with '-b' in such a case.
 
 --no-track::
 	Ignore the branch.autosetupmerge configuration variable.
-- 
1.5.6.5
