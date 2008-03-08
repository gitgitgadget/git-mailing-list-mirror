From: William Tanksley <wtanksleyjr+git@gmail.com>
Subject: Can git be stopped from inserting conflict markers during a merge?
Date: Sat, 8 Mar 2008 17:55:47 +0000 (UTC)
Message-ID: <loom.20080308T174918-559@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 21:25:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY5c0-0000DS-SA
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 21:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbYCHUZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 15:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbYCHUZG
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 15:25:06 -0500
Received: from main.gmane.org ([80.91.229.2]:43323 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755629AbYCHUZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 15:25:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JY5bK-0004T9-70
	for git@vger.kernel.org; Sat, 08 Mar 2008 20:25:02 +0000
Received: from ip72-197-27-16.sd.sd.cox.net ([72.197.27.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 20:25:02 +0000
Received: from wtanksleyjr+git by ip72-197-27-16.sd.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 20:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 72.197.27.16 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080201 Firefox/2.0.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76578>

I started using Mercurial a while ago, and I'd like to move up to git (for a
number of reasons). The one thing that's stopping me is that (having recently
escaped subversion and cvs) I'm now used to NOT having to worry about conflict
markers being shoved into files. To put it simply, I really like how Mercurial
does that one thing.

So, given the git is probably the ultimate in configurability, what do I need to
do to make it not insert merge markers?

Thanks for a great VCS.

-Wm

