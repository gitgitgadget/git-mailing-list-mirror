From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Wanted - a file browser interface to git
Date: Tue, 18 Oct 2005 18:07:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181806250.3369@g5.osdl.org>
References: <dj45np$e88$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 03:09:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES2R2-0003HR-Uc
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 03:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVJSBH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 21:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVJSBH5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 21:07:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751361AbVJSBH4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 21:07:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9J17sFC020764
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 18:07:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9J17rIi009333;
	Tue, 18 Oct 2005 18:07:53 -0700
To: John Ellson <ellson@research.att.com>
In-Reply-To: <dj45np$e88$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10252>



On Tue, 18 Oct 2005, John Ellson wrote:
> 
> An example is:  "I know that file xxx contained algorithm yyy at some point in
> the past and now I'd like to browse back through the history of xxx to find
> the exact details."

You are aware of "git whatchanged -p xxx", right?

Yeah, it's not graphical, and I agree that it might be very cool to have a 
graphical version of it. But I thought I'd mention it even so. A 
surprising number of people seem to have never realized, and at least for 
me personally, it's one of the most common things I do.

		Linus
