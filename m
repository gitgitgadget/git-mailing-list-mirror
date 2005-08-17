From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk with hyperspace support
Date: Tue, 16 Aug 2005 20:02:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508162001040.3553@g5.osdl.org>
References: <17154.33520.584666.701545@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 05:03:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5ECs-0003O0-Qj
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 05:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVHQDDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 23:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVHQDDA
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 23:03:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750805AbVHQDC7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 23:02:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7H32vjA025407
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Aug 2005 20:02:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7H32uNt030193;
	Tue, 16 Aug 2005 20:02:57 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17154.33520.584666.701545@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 17 Aug 2005, Paul Mackerras wrote:
> 
> I would like to get some feedback about what people think of the
> visual effect of this new approach, and in particular whether having
> the lines jump into hyperspace loses information that people find
> useful.

Me likee. Maybe some knob to tune how eagerly this happens?

> The new version is at:
> 
> http://ozlabs.org/~paulus/gitk/gitk.hs

".hs" made firefox think it was haskell. Confusing ;)

			Linus
