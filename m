From: Andrew Selder <aselder@mac.com>
Subject: Getting new branches from SVN?
Date: Tue, 13 Jan 2009 23:44:13 +0000 (UTC)
Message-ID: <loom.20090113T234017-639@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 00:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMsxv-0002mh-UX
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 00:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584AbZAMXpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 18:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755669AbZAMXpL
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 18:45:11 -0500
Received: from main.gmane.org ([80.91.229.2]:44745 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800AbZAMXpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 18:45:09 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LMswQ-0005Dz-Pg
	for git@vger.kernel.org; Tue, 13 Jan 2009 23:45:05 +0000
Received: from adsl-75-36-166-15.dsl.pltn13.sbcglobal.net ([75.36.166.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 23:45:02 +0000
Received: from aselder by adsl-75-36-166-15.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 23:45:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.36.166.15 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.5) Gecko/2008120121 Firefox/3.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105560>

Hi.

We started using git-svn at my company and it's going pretty well so far.

The only problem I have is that when new branches and tags are created in SVN,
how do I get those branches to show up in git as remote branches.

I did the normal git svn clone -s -prefix svn/ .... and it found all the
branches and tags up to that point. 

But since then, a couple new SVN branches and tags have been created, and I need
them to appear in my git repo.

I'm sure I just missed something simple, but I couldn't find this.

Thanks,

Andrew
