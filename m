From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitk "hyperlinks" (was Re: Display of merges in gitk)
Date: Sat, 6 Aug 2005 05:36:54 +0200
Message-ID: <20050806033654.GA27953@vrfy.org>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0508050658260.3258@g5.osdl.org> <Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 05:38:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1FVs-0004Bf-Uk
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 05:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbVHFDhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 23:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVHFDhD
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 23:37:03 -0400
Received: from soundwarez.org ([217.160.171.123]:54688 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S263161AbVHFDg7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 23:36:59 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id AAC173C13A; Sat,  6 Aug 2005 05:36:54 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 05, 2005 at 07:37:41AM -0700, Linus Torvalds wrote:
> 
> [ Also Kay Sievers, because the clickability thing sounds like a 
>   potentially good thing for webgit too.. ]
...
> For 2.6.13 we've been reverting some stuff lately, to make sure we get a 
> stable release. That's fine, and when I revert something I try to mention 
> the commit ID of the thing I revert in the message. Apparently others do 
> too, as indicated by a patch I just got from Petr Vandovec. So we've got 
> for example:
> 
>     Undo: d8c4b4195c7d664baf296818bf756775149232d3
>     
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
...
> and when I use gitk, it would be just too damn cool for words if I could 
> easily follow the SHA1's mentioned in the commit message.
...

Damn cool? No problem. :)
  http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=403fe5ae57c831968c3dbbaba291ae825a1c5aaa

Kay
