From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Removal of "--merge-order"?
Date: Fri, 24 Feb 2006 09:23:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602240918030.3771@g5.osdl.org>
References: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org>
 <Pine.LNX.4.58.0602240840520.7894@shark.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 18:23:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCgfJ-0000JP-Kf
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 18:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWBXRXf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 12:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWBXRXe
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 12:23:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28563 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932279AbWBXRXe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 12:23:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1OHNTDZ003468
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Feb 2006 09:23:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1OHNOBO031262;
	Fri, 24 Feb 2006 09:23:27 -0800
To: "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0602240840520.7894@shark.he.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16716>



On Fri, 24 Feb 2006, Randy.Dunlap wrote:
> 
> I'm just a lowly user, but I see people trying to export git
> trees to other SCMs, and they seem to prefer merge-order.
> This is your chance to correct me about:
> (a) how I am wrong; (b) how they are wrong.  8;)

Well, I didn't even realize anybody at all was using it. I've never seen 
any mention of it, and considering how ungodly slow it is, I would have 
expected somebody to pipe up about it..

I did a google search for "git" and "merge-order", and the only actual use 
(as opposed to mention in a man-page) I found in the 20 hits google showed 
was an old version of gitk.

> I've heard/seen you say that merge-order is not interesting,
> but I still believe that *your* merge order of the Linux kernel
> tree is almost all that people really care about.

Could you actually point to somebody using it? They're hiding it well.

> Apparently I needed to go to LCA to hear you discuss git.

I certainly never delved into any of that.. 

		Linus
