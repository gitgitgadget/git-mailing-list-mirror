From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Fri, 2 Sep 2005 14:09:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509021358000.23242@iabervon.org>
References: <Pine.LNX.4.63.0508171655250.13502@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0508171341380.23242@iabervon.org>
 <Pine.LNX.4.63.0508172156090.17234@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0508171630140.23242@iabervon.org>
 <Pine.LNX.4.63.0508180009180.18104@wgmdd8.biozentrum.uni-wuerzburg.de>
 <430C8C31.1070902@progeny.com> <7v4q9eak9k.fsf@assigned-by-dhcp.cox.net>
 <43174090.5070503@progeny.com> <7vek88tib4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 20:06:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBFuy-0005d3-Oj
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 20:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVIBSFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 14:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVIBSFZ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 14:05:25 -0400
Received: from iabervon.org ([66.92.72.58]:21521 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750760AbVIBSFY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 14:05:24 -0400
Received: (qmail 25215 invoked by uid 1000); 2 Sep 2005 14:09:13 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Sep 2005 14:09:13 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek88tib4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8025>

On Thu, 1 Sep 2005, Junio C Hamano wrote:

> Tim Ottinger <tottinge@progeny.com> writes:
> 
> > git-update-cache for instance?
> > I am not sure which 'cache' commands need to be 'index' now.
> 
> Logically you are right, but I suspect that may not fly well in
> practice.  Too many of us have already got our fingers wired to
> type cache, and the glossary is there to describe both cache and
> index.

My vote's for changing the official names, but keeping symlinks for the 
old names. As far as I know, there aren't any actual conflicts, and we 
might as well have new users pick up the logical names. I particularly 
think "git merge" would be really good to have.

	-Daniel
*This .sig left intentionally blank*
