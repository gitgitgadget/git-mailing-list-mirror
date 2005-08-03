From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] list shortlog items in commit order
Date: Tue, 02 Aug 2005 23:58:25 -0400
Message-ID: <42F040E1.5000706@pobox.com>
References: <Pine.LNX.4.63.0508021713230.15300@localhost.localdomain> <7vvf2oklwy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 05:59:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0AOw-0000AQ-Kh
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 05:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVHCD6g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 23:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVHCD6g
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 23:58:36 -0400
Received: from mail.dvmed.net ([216.237.124.58]:27114 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262025AbVHCD6e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 23:58:34 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1E0AOi-0008Jw-SP; Wed, 03 Aug 2005 03:58:30 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf2oklwy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> 
>>The current shortlog list is backward making it look odd.
>>This reverses it so things appear more logically.
> 
> 
> Sorry, I do not know how the shortlog looked like in BK days,
> but it would be nice to match that order.  I do not have
> preference either way myself.
> 
> I'll let it simmer and let the list decide, but I think the
> kernel folks care the most about this one, so I am asking the
> original authors, Linus and Jeff, if they want to go for it, or
> veto it.

<shrug>  I don't really care either way.

	Jeff
