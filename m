From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The big git command renaming..
Date: Fri, 29 Apr 2005 16:39:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291638260.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org>
 <20050429213540.GA1691@redhat.com> <4272AE05.2070202@zytor.com>
 <Pine.LNX.4.58.0504291511410.18901@ppc970.osdl.org> <4272BE9C.7090906@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:33:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DReyU-00008F-Nx
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 01:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbVD2XiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 19:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVD2XiK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 19:38:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:23516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263070AbVD2Xh4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 19:37:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TNbjs4023855
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 16:37:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TNbhiw012367;
	Fri, 29 Apr 2005 16:37:44 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4272BE9C.7090906@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, H. Peter Anvin wrote:
> 
> If you have any other non-kernel git projects, just let me know and I'll 
> make directories for them.

The others are small and specialized (sparse, and the "git-tools" thing,
and the latter is so much smaler than my BK tools used to be that I
suspect I should just move it into git as the "apply mbox" import thing it
is)

> P.S. Are you still updating the trees in 
> /pub/linux/kernel/people/torvalds/?  They still show up on our change 
> reports, and cause problems for the mirrors.  Perhaps you could replace 
> those trees with symlinks into /pub/scm.

Fixed.

		Linus
