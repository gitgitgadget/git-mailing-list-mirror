From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [osol-bugs] access() behaves strange when used as root
Date: Tue, 23 May 2006 13:54:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605231349180.5623@g5.osdl.org>
References: <f3d7535d0605230818l6ecb9b87gd38afc75941c5fdd@mail.gmail.com> 
 <20060523153415.GB3638@greyarea>  <20060523154213.GB21587@totally.trollied.org>
  <f3d7535d0605231035p6e2d8ef8qefefe43a8b11e739@mail.gmail.com> 
 <44735D61.nail4RQ116Y06@burner> <f3d7535d0605231343h51bfb2c9w1d15536b92874a88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 22:54:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FidtS-0008Qn-VY
	for gcvg-git@gmane.org; Tue, 23 May 2006 22:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWEWUyN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 16:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWEWUyN
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 16:54:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932192AbWEWUyM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 16:54:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4NKsAtH027301
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 13:54:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4NKs8i1020697;
	Tue, 23 May 2006 13:54:09 -0700
To: Stefan Pfetzing <stefan.pfetzing@gmail.com>
In-Reply-To: <f3d7535d0605231343h51bfb2c9w1d15536b92874a88@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20636>



On Tue, 23 May 2006, Stefan Pfetzing wrote:
>
> Hi Joerg,

Don't bother talking to Joerg.

He's a certified loon, and thinks Solaris is correct by definition. He's 
insane. He thinks that anybody who does anything different from Solaris is 
by definition not just wrong, but actively evil, even when the "anything 
different" is clearly superior (ie he thinks that Solaris device naming is 
not only sane, but claims that everybody else should do it that way).

If you ever wondered why "cdrecord" takes a default device argument of the 
forma "dev=0,1,0" or other random numbers, it's Joerg.

So just ignore him. I hope the OpenSolaris lists have saner people around.

		Linus
