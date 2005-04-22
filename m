From: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.3 && request for testing
Date: Thu, 21 Apr 2005 23:49:37 -0700
Message-ID: <20050422064936.GA10854@kroah.com>
References: <20050422030931.GA14565@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 08:47:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOrvs-0001m0-4c
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 08:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVDVGu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 02:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVDVGu4
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 02:50:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:10436 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261989AbVDVGuB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 02:50:01 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3M6nqi10973;
	Thu, 21 Apr 2005 23:49:52 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DOryr-2pH-00; Thu, 21 Apr 2005 23:49:37 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050422030931.GA14565@pasky.ji.cz>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2005 at 05:09:31AM +0200, Petr Baudis wrote:
>   Hello,
> 
>   FYI, I've released git-pasky-0.6.3 earlier in the night.

Hm, fun thing to try:
	go into a kernel git tree.
	rm Makefile
	git diff

Watch it as it thinks that every Makefile in the kernel tree is now
gone...

thanks,

greg k-h
