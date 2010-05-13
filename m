From: Terrence Brannon <schemelab@gmail.com>
Subject: regarding "git status"
Date: Thu, 13 May 2010 13:56:06 +0000 (UTC)
Message-ID: <loom.20100513T155553-871@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 16:00:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCYxS-0008Qc-LO
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 16:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab0EMOAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 10:00:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:45711 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309Ab0EMOAG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 10:00:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OCYxI-0008KQ-Cf
	for git@vger.kernel.org; Thu, 13 May 2010 16:00:05 +0200
Received: from n00.bcrtfl01.us.wh.nameservers.net ([208.55.254.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 May 2010 16:00:04 +0200
Received: from schemelab by n00.bcrtfl01.us.wh.nameservers.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 May 2010 16:00:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 208.55.254.110 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.2) Gecko/20100316 Firefox/3.6.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147006>

In the manpage for git-status
(http://www.kernel.org/pub/software/scm/git/docs/git-status.html) it says:

"Displays paths that have differences between the index file and the current
HEAD commit"

but how could something be added to the index and not be different from the
current HEAD commit? shouldnt this sentence say: "displays paths that have been
added to the index"
