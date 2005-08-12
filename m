From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Re: git-http-pull broken in latest git
Date: Thu, 11 Aug 2005 22:12:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508112211080.12816@iabervon.org>
References: <42F8D472.3080404@de.bosch.com> <20050811223349.GI25280@pasky.ji.cz>
 <7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508111929010.12816@iabervon.org>
 <7vzmrnc3qt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 04:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3OzA-0002BX-2K
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 04:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVHLCJZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 22:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbVHLCJZ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 22:09:25 -0400
Received: from iabervon.org ([66.92.72.58]:3588 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964777AbVHLCJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 22:09:25 -0400
Received: (qmail 16023 invoked by uid 1000); 11 Aug 2005 22:12:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Aug 2005 22:12:38 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmrnc3qt.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Aug 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > It should work anyway,...
> 
> That is true.  Please forget about the "recommendation" to slurp
> packs and not falling back on commit walker.
> 
> Thanks for the patch.

No problem; I had been wondering what the rest of those lines were about 
anyway.

	-Daniel
*This .sig left intentionally blank*
