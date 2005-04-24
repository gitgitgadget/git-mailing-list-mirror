From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hash collision count
Date: Sat, 23 Apr 2005 20:43:26 -0400
Message-ID: <426AEBAE.1060402@pobox.com>
References: <426AAFC3.800@pobox.com> <1114297231.10264.12.camel@maze.mythral.org> <426AD835.5070404@pobox.com> <20050423234637.GS13222@pasky.ji.cz> <426AE9ED.4060005@pobox.com> <20050424004039.GU13222@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ray Heasman <lists@mythral.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:41:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPVAW-0000lq-Pt
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVDXAoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVDXAoW
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:44:22 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:4740 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S262208AbVDXAnb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 20:43:31 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DPVDc-0002dT-HD; Sun, 24 Apr 2005 00:43:29 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050424004039.GU13222@pasky.ji.cz>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> -DCOLLISION_CHECK

Cool.  I am happy, then :)

Make sure that's enabled by default...

Thanks,

	Jeff


