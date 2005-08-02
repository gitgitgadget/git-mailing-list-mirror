From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch] list shortlog items in commit order
Date: Tue, 02 Aug 2005 18:41:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508021840070.15300@localhost.localdomain>
References: <Pine.LNX.4.63.0508021713230.15300@localhost.localdomain>
 <7vvf2oklwy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@ppc970.osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 00:44:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E05Sb-0008RF-9o
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 00:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVHBWmC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 18:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVHBWmC
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 18:42:02 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22485 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261461AbVHBWmB
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 18:42:01 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IKM00C6V9POW6@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Aug 2005 18:41:49 -0400 (EDT)
In-reply-to: <7vvf2oklwy.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Aug 2005, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > The current shortlog list is backward making it look odd.
> > This reverses it so things appear more logically.
> 
> Sorry, I do not know how the shortlog looked like in BK days,
> but it would be nice to match that order.

This is precisely why I made this patch: to make it look like the BK 
shortlog.


Nicolas
