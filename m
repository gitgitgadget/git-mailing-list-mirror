From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix interesting git-rev-list corner case
Date: Fri, 29 Jul 2005 18:28:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507291827000.29650@g5.osdl.org>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org>
 <20050730001158.GF32263@mythryan2.michonline.com> <Pine.LNX.4.58.0507291816060.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 03:49:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DygT2-0007iv-Ig
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 03:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVG3BdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 21:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVG3Bap
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 21:30:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262808AbVG3B2z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 21:28:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6U1SmjA000339
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Jul 2005 18:28:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6U1SlRw002444;
	Fri, 29 Jul 2005 18:28:48 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <Pine.LNX.4.58.0507291816060.29650@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Jul 2005, Linus Torvalds wrote:
> 
>		, but any time we _depend_ on dates
> one way or the other that would be a good.

"_not_ be a good _thing_". I don't know what strange brain-glitch I had
there.

I had kind of hoped my kids would be all grown up before their dad started 
losing his marbles. Oh, well..

			Linus
