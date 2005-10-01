From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 17:10:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0509301709350.3378@g5.osdl.org>
References: <200509292317.j8TNHC7S022247@inti.inf.utfsm.cl>
 <Pine.LNX.4.64.0509291742170.3378@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 02:11:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELUyK-0000dy-8n
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 02:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbVJAALL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 20:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbVJAALL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 20:11:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030513AbVJAALJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2005 20:11:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j910Ah4s028312
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Sep 2005 17:10:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j910Ae6C032027;
	Fri, 30 Sep 2005 17:10:40 -0700
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <Pine.LNX.4.64.0509291742170.3378@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9579>



On Thu, 29 Sep 2005, Linus Torvalds wrote:
> 
> I put my git repo on 
> 
> 	kernel.org:/pub/software/editors/uemacs/uemacs.git

Gaah. You guys shamed me into actually trying to clean up the sources a 
bit.

It's by no means done, but some of it is even sparse-clean now.

I suspect there's a lot of it that still works mainly by luck than because 
it does anything right.

		Linus
