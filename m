From: Frederik Hohlfeld <frederik.hohlfeld@gmail.com>
Subject: Re: exit status 141 from git-svn
Date: Tue, 24 Jun 2008 19:24:38 +0000 (UTC)
Message-ID: <loom.20080624T192256-150@post.gmane.org>
References: <loom.20080623T145909-992@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 21:26:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBE9P-0000H6-Io
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261AbYFXTYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756198AbYFXTYs
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:24:48 -0400
Received: from main.gmane.org ([80.91.229.2]:57391 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764AbYFXTYs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:24:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBE8D-0006rv-KY
	for git@vger.kernel.org; Tue, 24 Jun 2008 19:24:45 +0000
Received: from e179254177.adsl.alicedsl.de ([85.179.254.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 19:24:45 +0000
Received: from frederik.hohlfeld by e179254177.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 19:24:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.179.254.177 (Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9) Gecko/2008061015 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86118>

Frederik Hohlfeld <frederik.hohlfeld <at> gmail.com> writes:

> I have init'ed a git repository with git svn init.
> 
> Now I'm using git svn fetch, but it stops after just a few files/revisions. The
> exit status is 141.
> 
> What does this 141 want to tell me?

No one?

Both git svn clone and git svn fetch stop after just a dozen or so revisions and
only continue after calling the command again. For yet another few revisions.

I'd like to get a clue what's happening. A git problem? A svn problem?

Current Git Windows version.

Thanks
Frederik Hohlfeld
