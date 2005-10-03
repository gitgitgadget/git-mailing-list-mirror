From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What to expect after 0.99.8
Date: Mon, 3 Oct 2005 16:12:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510031608170.23242@iabervon.org>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <20051003200233.GC15593@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 22:10:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMWbe-0000FM-Qo
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 22:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbVJCUIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 16:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbVJCUIM
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 16:08:12 -0400
Received: from iabervon.org ([66.92.72.58]:58117 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932682AbVJCUIL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 16:08:11 -0400
Received: (qmail 29683 invoked by uid 1000); 3 Oct 2005 16:12:51 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Oct 2005 16:12:51 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051003200233.GC15593@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9650>

On Mon, 3 Oct 2005, Nick Hengeveld wrote:

> On Mon, Oct 03, 2005 at 03:43:02PM -0400, Daniel Barkalow wrote:
> 
> >  * Accept patches to fetch multiple objects by HTTP in parallel.
> > 
> > I think this may be necessary to get good performance without rsync for 
> > repositories hosted without specific git support.
> 
> I have a version of this almost working, but it's a nontrivial patch
> that feels more like a post-1.0 thing to me.

I'd be interested to see it anyway.

	-Daniel
*This .sig left intentionally blank*
