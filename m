From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tracking files across tree reorganizations
Date: Wed, 14 Dec 2005 15:39:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512141538440.3292@g5.osdl.org>
References: <43A08B8F.1000901@zytor.com> <20051214223656.GJ22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 00:41:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmgE5-0002Hj-It
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 00:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVLNXj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 18:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVLNXj7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 18:39:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38630 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965024AbVLNXj6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 18:39:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBENdrDZ014476
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Dec 2005 15:39:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBENdqe6013269;
	Wed, 14 Dec 2005 15:39:52 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051214223656.GJ22159@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13659>



On Wed, 14 Dec 2005, Petr Baudis wrote:
> 
> Linus is against it.
> 
> Cogito will do it anyway ;-), when someone sends me a nice patch or when
> I get to it (probably not very soon). I imagine it like this:

I warn people that if cogito starts polluting the commit messages too 
much, I'll stop pulling from such trees.

		Linus
