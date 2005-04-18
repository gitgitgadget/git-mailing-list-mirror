From: Paul Jackson <pj@sgi.com>
Subject: Re: optimize gitdiff-do script
Date: Mon, 18 Apr 2005 12:17:56 -0700
Organization: SGI
Message-ID: <20050418121756.2a4b6e2e.pj@sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
	<20050416232810.23430.78712.sendpatchset@sam.engr.sgi.com>
	<20050416234344.GQ19099@pasky.ji.cz>
	<20050416171009.0bedbab4.pj@sgi.com>
	<20050418082334.25359013.pj@sgi.com>
	<20050418183038.GB5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 21:15:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNbhw-0000HY-MT
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 21:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVDRTS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVDRTS4
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 15:18:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32726 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262169AbVDRTSy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 15:18:54 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3IKwQCF015431;
	Mon, 18 Apr 2005 13:58:36 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3IJI0lU15758911;
	Mon, 18 Apr 2005 12:18:03 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418183038.GB5554@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pasky wrote:
> But what I said still holds - this can go
> in only after we have a shell library sharing the common functions

Ah - thanks for repeating that - it didn't sink in the first time.

Good idea.

> Yes, sorry about that; I had a lot of mail traffic lately ...

No problem.  I hope you're having fun at the center of this cyclone.

> I cannot guarantee I will look at it immediately, though.

Good.  You priorities sound fine to me.

I'll rework the patches and send them along again in a few days,
when I get a chance.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
