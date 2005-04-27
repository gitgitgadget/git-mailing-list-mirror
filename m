From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: import mbox?
Date: Wed, 27 Apr 2005 16:21:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271620150.18901@ppc970.osdl.org>
References: <42701B79.8080106@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:14:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvjP-0001We-Fc
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVD0XTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVD0XTh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:19:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:38826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262092AbVD0XTa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 19:19:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RNJRs4029312
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 16:19:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RNJQk1016828;
	Wed, 27 Apr 2005 16:19:27 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42701B79.8080106@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Jeff Garzik wrote:
>
> Sorry for the FAQ, but I didn't see this in any of the scripts in the 
> 'git' archives, nor in the README.
> 
> What script should kernel developers use, to import an mbox full of patches?

I've got a "tools" project at

	kernel.org:/pub/linux/kernel/people/torvalds/git-tools.git

which has my old "dotest" scripts re-written for git (yeah, yeah, three 
years and two generations later, I still call the damn thing "dotest". I'm 
not very good at this tool naming thing ;)

		Linus
