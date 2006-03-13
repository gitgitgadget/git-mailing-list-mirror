From: Olivier Galibert <galibert@pobox.com>
Subject: Re: What should I use instead of git show?
Date: Mon, 13 Mar 2006 17:58:42 +0100
Message-ID: <20060313165842.GD87487@dspnet.fr.eu.org>
References: <20060313144747.GA81092@dspnet.fr.eu.org> <200603131717.53416.astralstorm@o2.pl> <Pine.LNX.4.64.0603130830050.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Radoslaw Szkodzinski <astralstorm@o2.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 18:00:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIqNc-0001Mw-0t
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 17:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWCMQ6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 11:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWCMQ6o
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 11:58:44 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:53513 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751593AbWCMQ6n (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 11:58:43 -0500
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id CB017A3A6D; Mon, 13 Mar 2006 17:58:42 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603130830050.3618@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17574>

On Mon, Mar 13, 2006 at 08:33:22AM -0800, Linus Torvalds wrote:
> Why not just use "git show"?
> 
> It hasn't gone anywhere that I know of. It's still there.

Oh beautiful.

I had an old (as in 3 months max, but heh) git-tree at work in a
corner from which I had compiled git.  When I saw it didn't have git
show which I have at home I did a git pull, recompile, reinstall.

The new git didn't have git show, so I thought it had been removed
after all.  Turns out, the git pull had broken halfway due to the old
version of git.  It hadn't fast forwarded _all_ the versions.  But the
new git, while not current, has been able to do the complete git pull
this time.  And now I have git show at work too.

Guess you have to update git every month or so if you want to be able
to follow current trees.

  OG.
