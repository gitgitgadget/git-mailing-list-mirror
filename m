From: David Kastrup <dak@gnu.org>
Subject: [PATCH] git-svn.txt: fix an obvious misspelling.
Date: Fri, 17 Aug 2007 17:48:53 +0200
Message-ID: <868x7xv015.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 10:45:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPaEK-0001Eq-JU
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbXH0Ipt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 04:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbXH0Ips
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:45:48 -0400
Received: from main.gmane.org ([80.91.229.2]:40583 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbXH0Ipr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:45:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPaE0-0007aQ-Vm
	for git@vger.kernel.org; Mon, 27 Aug 2007 10:45:32 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 10:45:32 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 10:45:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:MDA5PHI1GiMGIW7oJsunN1jVHA0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56786>


Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/git-svn.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 3420c5c..be2e34e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -549,7 +549,7 @@ listed below are allowed:
 ------------------------------------------------------------------------
 
 Keep in mind that the '*' (asterisk) wildcard of the local ref
-(left of the ':') *must* be the farthest right path component;
+(right of the ':') *must* be the farthest right path component;
 however the remote wildcard may be anywhere as long as it's own
 independent path component (surrounded by '/' or EOL).   This
 type of configuration is not automatically created by 'init' and
-- 
1.5.3.GIT
