From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Documentation/git-commit.txt: correct bad list formatting.
Date: Mon, 6 Aug 2007 14:56:32 +0200
Message-ID: <86zm14by43.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 15:19:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II2Uu-0000JI-9T
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 15:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765635AbXHFNTB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 09:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765472AbXHFNSZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 09:18:25 -0400
Received: from main.gmane.org ([80.91.229.2]:52760 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765432AbXHFNST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 09:18:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1II2TP-0001rv-5u
	for git@vger.kernel.org; Mon, 06 Aug 2007 15:18:15 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 15:18:15 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 15:18:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:Ae9fk0uLUPVuGk7EqJkvgFqbue8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55145>



Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/git-commit.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 63599d3..e54fb12 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -19,6 +19,7 @@ Use 'git commit' to store the current contents of the index in a new
 commit along with a log message describing the changes you have made.
 
 The content to be added can be specified in several ways:
+
 1. by using gitlink:git-add[1] to incrementally "add" changes to the
    index before using the 'commit' command (Note: even modified
    files must be "added");
-- 
1.5.3.rc4.21.ga63eb
