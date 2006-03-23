From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 08:01:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
References: <20060322133337.GU20746@lug-owl.de>  <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
  <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>  <44223B90.3040500@zytor.com>
 <1143128751.6850.35.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 17:01:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMSFd-0005ua-Rd
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 17:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWCWQB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 11:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWCWQB0
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 11:01:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161001AbWCWQBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 11:01:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2NG1FDZ032374
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Mar 2006 08:01:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2NG1E1j030765;
	Thu, 23 Mar 2006 08:01:15 -0800
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1143128751.6850.35.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17860>



On Thu, 23 Mar 2006, Keith Packard wrote:
> 
> Note that vendor branches are always made from the first revision along
> a branch, independent of when they occur, so you'll get 1.1.3.1 even if
> the head revision along the trunk is 1.246.

I have to say, that one thing I've learnt during this whole git thing is 
that other SCM's are DAMN CONFUSED.

I used to think that git was potentially hard to understand. Not so. git 
is an absolute paragon of logic and easy-to-understand concepts.

Compared to SVN (can anybody sat "trunk/branch/tag confusion") and CVS, 
git is not only a hell of a lot more capable, it's just more logical.

We will hereby start scouring the net for people who say git is hard to 
understand and use, and just kill them. They clearly are just polluting 
the gene pool.

		Linus
