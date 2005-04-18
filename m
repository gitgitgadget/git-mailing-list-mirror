From: Greg KH <greg@kroah.com>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 08:04:57 -0700
Message-ID: <20050418150456.GC12750@kroah.com>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 17:03:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNXlP-0006wj-DY
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 17:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVDRPGH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 11:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVDRPGH
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 11:06:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:28869 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262094AbVDRPGC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 11:06:02 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3IF5Qi08814;
	Mon, 18 Apr 2005 08:05:26 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DNXo1-3Mp-00; Mon, 18 Apr 2005 08:04:57 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2005 at 04:24:24PM -0700, Linus Torvalds wrote:
> 
> Tools absolutely matter. And it will take time for us to build up that 
> kind of helper infrastructure. So being newbie might be part of it, but 
> it's the smaller part, I say. Rough interfaces is a big issue.

Speaking of tools, you had a "dotest" program to apply patches in email
form to a bk tree.  And from what I can gather, you've changed that to
handle git archives, right?  Any pointers to where I can find this so I
could try to build up some git trees for you to merge with?  I think I
can even make a tree with a merge issue if you want to test that out :)

thanks,

greg k-h
