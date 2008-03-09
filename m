From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Add a library function to add an alternate to the
 alternates file
Date: Sun, 9 Mar 2008 19:26:27 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803091914590.19665@iabervon.org>
References: <alpine.LNX.1.00.0803091842100.19665@iabervon.org> <alpine.LSU.1.00.0803092357230.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 00:27:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYUv8-0004A7-Fq
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 00:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbYCIX0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 19:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbYCIX0a
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 19:26:30 -0400
Received: from iabervon.org ([66.92.72.58]:51972 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbYCIX0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 19:26:30 -0400
Received: (qmail 21441 invoked by uid 1000); 9 Mar 2008 23:26:27 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2008 23:26:27 -0000
In-Reply-To: <alpine.LSU.1.00.0803092357230.3975@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76684>

On Mon, 10 Mar 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 9 Mar 2008, Daniel Barkalow wrote:
> 
> > This is in the core so that, if the alternates file has already been 
> > read, the addition can be parsed and put into effect for the current 
> > process.
> 
> Yes, I like your two patches.
> 
> BTW so to avoid clashing, I just send what my cumulative "clean-up" patch 
> for builtin-clone is:
> 
> -- snipsnap --
> [PATCH] builtin-clone: misc clean-ups

They all look good to me.

	-Daniel
*This .sig left intentionally blank*
