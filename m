From: Paul Jackson <pj@sgi.com>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sat, 23 Apr 2005 22:02:36 -0700
Organization: SGI
Message-ID: <20050423220236.26f834ee.pj@sgi.com>
References: <20050423205847.7758bfaa.pj@sgi.com>
	<Pine.LNX.4.21.0504240018350.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 06:58:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZC4-0007lM-Bd
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 06:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVDXFCz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVDXFCz
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:02:55 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:50886 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262256AbVDXFCu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 01:02:50 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3O5RKrK020068;
	Sat, 23 Apr 2005 22:27:20 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3O52elU17755586;
	Sat, 23 Apr 2005 22:02:43 -0700 (PDT)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504240018350.30848-100000@iabervon.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The winning solution via private email:

	mkdir linux
	cd linux
	git init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Another email was missing the 'scm' term.

I still don't see how to get to the official 2.6.12-rc3:

	a2755a80f40e5794ddc20e00f781af9d6320fafb

But it looks like a kernel now - thanks !!

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
