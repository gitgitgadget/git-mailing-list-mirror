From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problems with using git
Date: Wed, 1 Mar 2006 16:52:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603011651240.22647@g5.osdl.org>
References: <44063B7C.40609@webdrake.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 01:53:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEc42-0004Q4-Vp
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 01:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWCBAxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 19:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWCBAxD
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 19:53:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750766AbWCBAxC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 19:53:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k220r0DZ007475
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Mar 2006 16:53:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k220quSq030675;
	Wed, 1 Mar 2006 16:52:58 -0800
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
In-Reply-To: <44063B7C.40609@webdrake.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17036>



On Thu, 2 Mar 2006, Joseph Wakeling wrote:
> 
> I'm using openSUSE 10.0 and the package installed is git-core version
> 0.99.3git20050905-2.

I think your problems are just related to the fact that the tutorial is 
newer than your git version.

Just fetch a newer version of git first (0.99.3 should be new enough to 
happily fetch a newer version using git itself, but it might be easier to 
just get a tar-ball), and you'll have an easier time at it.

		Linus
