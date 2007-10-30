From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 13:30:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710301324390.30120@woody.linux-foundation.org>
References: <20071029174000.GA4449@efreet.light.src>
 <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
 <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
 <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
 <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
 <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
 <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org>
 <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org>
 <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org>
 <86tzo81hrd.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Pascal Obry <pascal@obry.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Tom Prince <tom.prince@ualberta.net>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:32:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImxlO-0005al-V0
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 21:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbXJ3UcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 16:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbXJ3UcI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 16:32:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52523 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754408AbXJ3UcG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 16:32:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UKUpbV002814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 13:30:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UKUoXJ026735;
	Tue, 30 Oct 2007 13:30:50 -0700
In-Reply-To: <86tzo81hrd.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=-2.431 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62752>



On Tue, 30 Oct 2007, Randal L. Schwartz wrote:
> 
> Therefore, I propose that the git docs refrain from calling these things
> "URLs" because they're not, and instead adopt something like "GRL" (git
> resources locator) or whatever.

They're called "GIT URLS" right now. I'd have hoped that was descriptive 
enough. But maybe not.

I think it's stupid to make up a new name, it's not like it's really 
ambiguous *or* as if people really think in terms of RFC's.

Let's face it: people talk and use email, even when they don't have a clue 
about SMTP. And in practice, you'll never see any difference, apart from 
the obvious extension of using the ssh format and the direct local path 
thing.

		Linus
