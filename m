From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git cole give unexpected error message
Date: Wed, 14 Dec 2005 22:20:03 +0100
Message-ID: <20051214212003.GA17495@mars.ravnborg.org>
References: <20051213212820.GB5232@mars.ravnborg.org> <20051213222829.GE22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 22:20:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eme2W-0000TR-W0
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 22:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVLNVTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 16:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVLNVTg
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 16:19:36 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:55577 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932403AbVLNVTf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 16:19:35 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id 850E22628A9;
	Wed, 14 Dec 2005 22:19:32 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 9DE176AC07C; Wed, 14 Dec 2005 22:20:03 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051213222829.GE22159@pasky.or.cz>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13643>

On Tue, Dec 13, 2005 at 11:28:29PM +0100, Petr Baudis wrote:
> Dear diary, on Tue, Dec 13, 2005 at 10:28:20PM CET, I got a letter
> where Sam Ravnborg <sam@ravnborg.org> said that...
> > cogito being a nice porcelain gives the git errormessage but manage to
> > clean up when the clone fails.
> > So also cogito would benefit from a more descriptive errormessage.
> 
> Well, git clone can fail for many reasons and I don't think the "no such
> repository" one is completely overwhelming, so hinting that by Cogito
> could be quite confusing (theme of the day: usability ;-)).
> 
> The real solution would be proper error reporting by the git daemon.
Which was my point too.
When using cogito it displyed the git error message so having git to
print a sensible error message would also benefit cogito.

	Sam
