From: Paul Jackson <pj@sgi.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Sat, 23 Apr 2005 17:09:49 -0700
Organization: SGI
Message-ID: <20050423170949.3fc879d9.pj@sgi.com>
References: <20050420205633.GC19112@pasky.ji.cz>
	<20050420211919.GA20129@kroah.com>
	<20050420215117.GJ19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
	<20050420222815.GM19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org>
	<Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
	<20050421033526.GA9404@nevyn.them.org>
	<Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
	<20050421042833.GA10934@nevyn.them.org>
	<20050421064931.GA31910@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dan@debian.org, torvalds@osdl.org, greg@kroah.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 02:06:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUeB-0006qf-Um
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVDXALk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVDXALj
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:11:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23727 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262193AbVDXALi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:11:38 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3O1p8P4002657;
	Sat, 23 Apr 2005 18:51:18 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3O09rlU17688347;
	Sat, 23 Apr 2005 17:09:53 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050421064931.GA31910@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> A little off-topic, anyone knows how to turn off that damn alternate
> screen thing on the xterm level? 

Do you mean the 'feature' where it clears the screen of the
last page you were viewing on exit from 'less'?

The following stops that clearing:

    export LESS=-X

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
