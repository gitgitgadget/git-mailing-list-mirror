From: Greg KH <greg@kroah.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 00:11:33 -0700
Message-ID: <20050623071133.GA12304@kroah.com>
References: <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com> <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org> <42BA45B1.7060207@pobox.com> <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org> <20050623062045.GA11638@kroah.com> <Pine.LNX.4.58.0506222338290.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 09:18:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlLy7-0002TX-0W
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 09:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVFWHSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 03:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVFWHNq
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 03:13:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:1699 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262352AbVFWHLt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 03:11:49 -0400
Received: from [192.168.0.10] (c-24-22-112-187.hsd1.or.comcast.net [24.22.112.187])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j5N7Bci12678;
	Thu, 23 Jun 2005 00:11:38 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DlLs5-3Cx-00; Thu, 23 Jun 2005 00:11:33 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506222338290.11175@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2005 at 11:51:40PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 22 Jun 2005, Greg KH wrote:
> > 
> > Hm, that doesn't work right now.
> 
> Yeah, my suggested mod sucks.
> 
> Try the following slightly modified version instead, with
> 
> 	git fetch rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.12.y.git tag v2.6.12.1
> 
> and now it should work.

Yes, that patch works for me.

thanks,

greg k-h
