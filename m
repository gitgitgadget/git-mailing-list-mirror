From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 00/11] Build in clone
Date: Sat, 8 Mar 2008 18:20:10 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081817500.19665@iabervon.org>
References: <alpine.LNX.1.00.0803081803250.19665@iabervon.org> <alpine.LSU.1.00.0803090014310.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:21:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8LV-0004LF-1v
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbYCHXUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbYCHXUN
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:20:13 -0500
Received: from iabervon.org ([66.92.72.58]:45719 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbYCHXUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:20:12 -0500
Received: (qmail 19396 invoked by uid 1000); 8 Mar 2008 23:20:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:20:10 -0000
In-Reply-To: <alpine.LSU.1.00.0803090014310.3975@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76615>

On Sun, 9 Mar 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sat, 8 Mar 2008, Daniel Barkalow wrote:
> 
> > and 11 adds support for figuring out what the user means with a bundle 
> > and should probably get squashed into 10.
> 
> Yes, it should be squashed into 10, methinks.
> 
> 
> >  contrib/examples/git-clone.sh |  518 ++++++++++++++++++++++++++++++++++++++
> >  git-clone.sh                  |  518 --------------------------------------
> 
> I thought I squashed that bug?

I haven't updated my installed version, and didn't notice until I'd 
written the blurb.

	-Daniel
*This .sig left intentionally blank*
