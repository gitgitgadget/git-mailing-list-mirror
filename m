From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 12:42:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603231239020.26286@g5.osdl.org>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
 <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <Pine.LNX.4.64.0603221717120.26286@g5.osdl.org>
 <20060323200306.GG31387@lug-owl.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 21:44:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMWet-00024A-TJ
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 21:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWCWUmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 15:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWCWUmq
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 15:42:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43984 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422680AbWCWUmj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 15:42:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2NKgMDZ016885
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Mar 2006 12:42:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2NKgK88018628;
	Thu, 23 Mar 2006 12:42:21 -0800
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060323200306.GG31387@lug-owl.de>
X-Spam-Status: No, hits=0.8 required=5 tests=UPPERCASE_25_50
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17868>



On Thu, 23 Mar 2006, Jan-Benedict Glaw wrote:
>
> Switching from origin to #CVSPS_NO_BRANCH

Ahh. I had some other changes to my cvsps, so I never saw this. I just 
turned the #CVSPS_NO_BRANCH thing into HEAD.

		Linus
