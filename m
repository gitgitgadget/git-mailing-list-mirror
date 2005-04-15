From: Paul Jackson <pj@engr.sgi.com>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 11:29:27 -0700
Organization: SGI
Message-ID: <20050415112927.72a7004f.pj@engr.sgi.com>
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
	<20050415085424.5f61b80b.pj@engr.sgi.com>
	<Pine.LNX.4.61.0504151227590.27637@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, dwmw2@infradead.org, junkio@cox.net,
	pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 20:31:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMVZx-0005pF-Hm
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 20:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVDOScw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 14:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVDOSbN
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 14:31:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:46005 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261912AbVDOSax (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 14:30:53 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3FIqwp3014365;
	Fri, 15 Apr 2005 11:52:58 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3FITWlU14915337;
	Fri, 15 Apr 2005 11:29:32 -0700 (PDT)
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504151227590.27637@cag.csail.mit.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> intra file diffs: here are two versions of the same file. 

Ah so.  Linus faked me out.

I was _sure_ that by "file" he meant "file" -- as in a bucket of bits
with a unique identifying <sha1>.

In that message, I guess by "file" he meant "a version controlled
file, consisting of a series of content versions and meta-data"

That's what I get for trusting Linus to always speak as a kernel
hacker, not an SCM hacker.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
