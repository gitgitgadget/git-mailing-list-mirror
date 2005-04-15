From: Paul Jackson <pj@engr.sgi.com>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 08:54:24 -0700
Organization: SGI
Message-ID: <20050415085424.5f61b80b.pj@engr.sgi.com>
References: <20050414002902.GU25711@pasky.ji.cz>
	<20050413212546.GA17236@64m.dyndns.org>
	<20050414004504.GW25711@pasky.ji.cz>
	<Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
	<1113556448.12012.269.camel@baythorne.infradead.org>
	<Pine.LNX.4.58.0504150740310.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dwmw2@infradead.org, junkio@cox.net, pasky@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 17:54:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMT8j-0000PC-AE
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 17:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVDOP5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 11:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVDOP5E
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 11:57:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11416 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261841AbVDOP4w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 11:56:52 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3FHYTcm004492;
	Fri, 15 Apr 2005 10:34:39 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3FFsSlU14875838;
	Fri, 15 Apr 2005 08:54:28 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504150740310.7211@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus wrote:
> For example, just doing intra-file diffs is a lot _easier_ and less 
> time-consuming than doing inter-file diffs. 

Um ah ... could you explain what you mean by inter and intra file diffs?

Google found a three year old message by Andrew Morton, discussing
inter and intra file fragmentation on ext2/ext3 file systems and the
find_group_dir() routine.  I don't think that's what you had in mind ;).

When I run the 'diff' command, it usually between two files, not between
two parts of a file.  So I'd have thought inter file diffs were easier.

Clearly, I don't git it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
