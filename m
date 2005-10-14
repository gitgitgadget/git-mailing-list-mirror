From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Fri, 14 Oct 2005 15:56:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510141543030.23242@iabervon.org>
References: <867jciz18w.fsf@blue.stonehenge.com> <864q7kqsa4.fsf@blue.stonehenge.com>
 <7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net> <86achcoyvz.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 21:53:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQVal-0002Y0-78
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 21:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVJNTvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 15:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVJNTvo
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 15:51:44 -0400
Received: from iabervon.org ([66.92.72.58]:50693 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750703AbVJNTvo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2005 15:51:44 -0400
Received: (qmail 28493 invoked by uid 1000); 14 Oct 2005 15:56:41 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Oct 2005 15:56:41 -0400
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86achcoyvz.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10122>

On Fri, 14 Oct 2005, Randal L. Schwartz wrote:

> My previous message mentioned cogito.git breaking.  This message
> was triggered because git.git itself broke.
> 
> Unfortunately, git.git hasn't been updated since the last time I
> worked around the problem by switching to rsync again, but when it
> does, I'll capture the breakage this time.

Can you give a general description of what happens? I've noticed that I 
sometimes get spurious error messages that don't actually affect the 
download, which I haven't tracked down yet.

	-Daniel
*This .sig left intentionally blank*
