From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Date handling.
Date: Thu, 14 Apr 2005 02:12:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
References: <1113466592.12012.192.camel@baythorne.infradead.org>
 <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 11:08:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM0Jn-0003s3-TB
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 11:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVDNJKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 05:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVDNJKn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 05:10:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:31104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261462AbVDNJKk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 05:10:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3E9Aas4015705
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 02:10:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3E9AZju018001;
	Thu, 14 Apr 2005 02:10:35 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, Linus Torvalds wrote:
> 
> Yeah, I think this is the right thing to do. I can change "commit" to do 
> it.

I take that back. I'd be much happier with you doing and testing it, 
because now I'm crashing.

		Linus
