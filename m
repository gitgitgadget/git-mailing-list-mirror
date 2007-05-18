From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Documentation (mainly user-manual) patches
Date: Thu, 17 May 2007 23:37:46 -0400
Message-ID: <20070518033746.GB30144@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 05:38:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HotHx-0002Pf-Gt
	for gcvg-git@gmane.org; Fri, 18 May 2007 05:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbXERDhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 23:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755796AbXERDhs
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 23:37:48 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53671 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511AbXERDhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 23:37:47 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HotHm-0004ZH-Lv; Thu, 17 May 2007 23:37:46 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47568>

Please pull from the maint branch at

	git://linux-nfs.org/~bfields/git.git maint

This is mainly revisions of the patches posted a few days ago, which
were uncontraversial, so I won't resend them.  (They did need more
proofreading than usual, though--thanks to everyone who helped!)

One final patch wasn't included before, so I'll follow up with that.

--b.

 Documentation/glossary.txt                       |  228 +++--
 Documentation/howto/dangling-objects.txt         |  109 --
 Documentation/howto/isolate-bugs-with-bisect.txt |   65 --
 Documentation/howto/make-dist.txt                |   52 -
 Documentation/howto/using-topic-branches.txt     |  296 ------
 Documentation/user-manual.txt                    | 1192 +++++++++++++++++-----
 6 files changed, 1046 insertions(+), 896 deletions(-)
