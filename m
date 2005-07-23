From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Sat, 23 Jul 2005 11:32:10 +0100
Message-ID: <1122114730.6863.76.camel@localhost.localdomain>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	 <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	 <20050722204120.GD11916@pasky.ji.cz>
	 <7vr7dqpmm4.fsf@assigned-by-dhcp.cox.net>
	 <20050722212725.GJ11916@pasky.ji.cz>
	 <7v8xzyh1ak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Bryan larsen <bryanlarsen@yahoo.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 12:32:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwHIw-0004qi-Qs
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 12:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVGWKcU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 06:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVGWKcU
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 06:32:20 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:11895 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261596AbVGWKcS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 06:32:18 -0400
Received: from aamta12-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20050723103217.JCZQ27585.mta07-winn.ispmail.ntl.com@aamta12-winn.ispmail.ntl.com>;
          Sat, 23 Jul 2005 11:32:17 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta12-winn.ispmail.ntl.com with ESMTP
          id <20050723103217.JPVM9998.aamta12-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Sat, 23 Jul 2005 11:32:17 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xzyh1ak.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-07-22 at 16:24 -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> > This brings me to another subject, M and N are pretty hard to
> > distinguish visually without close inspection of the output. What about
> > switching to use A instead of N everywhere?
> 
> However, I'd like to see what the extent of damage would be even
> if everybody agrees this is a good change.

Using A instead of N is not a problem for StGIT (and I would prefer A
since it's easier to read). I could also only change the StGIT output
even if git uses N.

-- 
Catalin
