From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 17:47:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0509291742170.3378@g5.osdl.org>
References: <200509292317.j8TNHC7S022247@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 02:49:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL94i-0003G7-FW
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 02:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVI3As0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 20:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVI3As0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 20:48:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932506AbVI3AsX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 20:48:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8U0lx4s005519
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Sep 2005 17:47:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8U0lwZS014235;
	Thu, 29 Sep 2005 17:47:58 -0700
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509292317.j8TNHC7S022247@inti.inf.utfsm.cl>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9531>



On Thu, 29 Sep 2005, Horst von Brand wrote:
> 
> Can I get a URL for the source for your editor? The one on kernel.org
> doesn't compile, and probably hasn't for a long time.

Oh, it compiles with trivial modifications. Not cleanly, but it works.

I put my git repo on 

	kernel.org:/pub/software/editors/uemacs/uemacs.git

but it will take a moment to mirror out. 

The "readme" says non-commercial only, but I asked Daniel Lawrence if it 
was ok to include it in commercial distributions a long time ago, and he 
said yes. Sadly, I've lost that email, so I don't have any paper trail for 
that. So you should consider the readme binding.

> [Yes, there is some (perverse) fun in telling people you use the very same
>  editor than Linus Torvalds :-]> 

The thing is, it's not a wonderful editor. It's small, and good enough, 
but I really wished somebody wrote something that handled UTF-8, for 
example.  But I've got the keybindings hardcoded in my spine, so I can't 
ever change.

		Linus
