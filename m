From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Junio's wishes [Was: Re: Approxidate licensing]
Date: Tue, 10 Oct 2006 15:12:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610101509460.3952@g5.osdl.org>
References: <200610102054.k9AKsQ2a004095@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 00:12:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXPpo-0006AG-4S
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 00:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbWJJWMV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 18:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbWJJWMU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 18:12:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030572AbWJJWMT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 18:12:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9AMC6aX023816
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Oct 2006 15:12:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9AMC4Br027179;
	Tue, 10 Oct 2006 15:12:05 -0700
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200610102054.k9AKsQ2a004095@laptop13.inf.utfsm.cl>
X-Spam-Status: No, hits=-0.468 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28675>



On Tue, 10 Oct 2006, Horst H. von Brand wrote:
>
> There is a small practical problem with that: How would you find out I'm
> using a modified version of your code internally? Also, the "distribution"
> part of GPLv2 is a useful filter: Only such modifications that are
> worthwhile to distribute get back, not each and every corner I paint myself
> into while playing around.

Hey, I obviously agree that the GPLv2 is a good license, but at the same 
time, I think too many people tend to think _just_ about legal issues.

Sometimes the wishes of an author should matter, regardless of whether 
there is any law that forces you to do so. So I personally think a license 
that says: "if you improve this, give out the improvements regardless of 
whether you distribute things further or not" is a nice sentiment, and 
should be honored, regardless of whether you can legally enforce any such 
private tinkering or not.

			Linus
