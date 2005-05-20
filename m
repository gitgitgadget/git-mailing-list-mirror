From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 12:13:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505201211390.2206@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>
  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org> 
 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org> <1116615600.12975.33.camel@dhcp-188>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 21:11:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZCtW-00017c-Ip
	for gcvg-git@gmane.org; Fri, 20 May 2005 21:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVETTLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 15:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVETTLh
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 15:11:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:42380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261554AbVETTL1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 15:11:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KJBLjA014340
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 12:11:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KJBJ8e027807;
	Fri, 20 May 2005 12:11:20 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1116615600.12975.33.camel@dhcp-188>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Kay Sievers wrote:
> 
> Somehting like this?:
>   http://kernel.org/git/?p=git/git.git;a=commitdiff;h=de809dbbce497e0d107562615c1d85ff35b4e0c5

Yes, except I don't think you should repeat the part of the commit message
that you used as a header (so in your example, since you already used "Fix
up previous commit" in the header, don't show it below).

Btw, any chance to see gitweb itself under gitweb on kernel.org?

		Linus
