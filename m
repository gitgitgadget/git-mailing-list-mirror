From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Non-http dumb protocols
Date: Sun, 1 Jul 2007 21:53:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707012153190.4438@racer.site>
References: <Pine.LNX.4.64.0706301613410.14638@iabervon.org>
 <7vbqewakz8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707011527590.4438@racer.site>
 <Pine.LNX.4.64.0707011444300.14638@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jul 01 22:53:52 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I56QZ-0004G6-Kw
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 22:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbXGAUxl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 16:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbXGAUxl
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 16:53:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:34779 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750738AbXGAUxk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 16:53:40 -0400
Received: (qmail invoked by alias); 01 Jul 2007 20:53:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 01 Jul 2007 22:53:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wJNd42b0wYFZW0/4n6YrfmsWzmICbgOSJlo6GXg
	nNY0gxeVlVvy0x
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707011444300.14638@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51321>

Hi,

On Sun, 1 Jul 2007, Daniel Barkalow wrote:

> Okay, I think I'll go for ditching ssh-fetch/-push, making the 
> commit-walker code more modular, and possibly moving more of the smarts 
> of http-fetch into the common code so that local-fetch is a better test 
> for it and sftp fetch would be possible.

Thanks,
Dscho
