From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] SPECIFYING RANGES typo fix: it it => it is
Date: Mon, 30 Apr 2007 21:37:57 +0300
Organization: Private
Message-ID: <irbdwvwa.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 20:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiamC-0000wu-2d
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 20:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423629AbXD3Six (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 14:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423639AbXD3Six
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 14:38:53 -0400
Received: from main.gmane.org ([80.91.229.2]:59061 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423629AbXD3Siv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 14:38:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hialn-0004bt-C5
	for git@vger.kernel.org; Mon, 30 Apr 2007 20:38:43 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 20:38:43 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 20:38:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:5FMSKfWaSywK4lgoFlqoD4Y5g/E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45873>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-rev-parse.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index a8bf656..7757abe 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -255,7 +255,7 @@ reachable from `r1` from the set of commits reachable from
 A similar notation "`r1\...r2`" is called symmetric difference
 of `r1` and `r2` and is defined as
 "`r1 r2 --not $(git-merge-base --all r1 r2)`".
-It it the set of commits that are reachable from either one of
+It is the set of commits that are reachable from either one of
 `r1` or `r2` but not from both.
 
 Two other shorthands for naming a set that is formed by a commit
-- 
1.5.1.2.GIT
