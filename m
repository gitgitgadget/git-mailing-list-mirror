From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 10:58:30 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org>
References: <20071029174000.GA4449@efreet.light.src>
 <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
 <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
 <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
 <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
 <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
 <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org>
 <vpq8x5kh4rr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Tom Prince <tom.prince@ualberta.net>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:00:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImvNP-0008CD-Kg
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 18:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbXJ3R7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 13:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbXJ3R73
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 13:59:29 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38701 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754565AbXJ3R72 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 13:59:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UHwVLA026864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 10:58:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UHwUD3020166;
	Tue, 30 Oct 2007 10:58:30 -0700
In-Reply-To: <vpq8x5kh4rr.fsf@bauges.imag.fr>
X-Spam-Status: No, hits=-2.432 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62718>



On Tue, 30 Oct 2007, Matthieu Moy wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Nobody cares about git being consistent with a web browser.
> 
> Why do you keep talking about web browser?
> 
> URLs are _not_ a web-browser thing. A web browser is just _one_
> example of program which uses URLs.

I keep talking about a web browser, because THE ONLY POINT of following a 
standard is to interoperate.

So if you cannot find something to interoperate with, why the hell would 
you care about the standard?

So here's a question: why do people bother to quote irrelevant RFC's?

Following those RFC's would make git not interoperate WITH ITSELF, and use 
illogically different formats for the same things.

So if you want to make that RFC have any relevance what-so-ever, then show 
some interoperability issue. Which is why I'm bringing up a web browser: 
that interop issue simply *does*not*exist*.

Why is that so hard to understand?

			Linus
