From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 09:25:54 +0100
Message-ID: <200710310925.56607.robin.rosenberg.lists@dewire.com>
References: <20071030044026.GA9600@thunk.org> <20071030235823.GA22747@coredump.intra.peff.net> <85pryvzt1h.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pascal Obry <pascal@obry.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Tom Prince <tom.prince@ualberta.net>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 09:23:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In8ri-0001xT-Kk
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 09:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbXJaIXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 04:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbXJaIXk
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 04:23:40 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21571 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbXJaIXj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 04:23:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DE58314706C3;
	Wed, 31 Oct 2007 09:14:45 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08980-03; Wed, 31 Oct 2007 09:14:45 +0100 (CET)
Received: from [10.9.0.10] (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 6F99E14706C2;
	Wed, 31 Oct 2007 09:14:45 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <85pryvzt1h.fsf@lola.goethe.zz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

onsdag 31 oktober 2007 skrev David Kastrup:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Oct 30, 2007 at 12:38:27PM -0700, Linus Torvalds wrote:
> >
> >> So if you want to follow the RFC, you'd better give a real reason. And no, 
> >> the existence of an RFC, and the fact that people use the same name for 
> >> things that superficially _look_ the same is not a reason in itself.
> >> 
> >> So hands up, people. Anybody who asked for RFC quoting. Give a damn 
> >> *reason* already!
> >
> > I didn't ask for RFC quoting, but a nice side effect of URL syntax is
> > that they are machine parseable. If you wanted to write a tool to pick
> > the URLs out of this email and clone them as git repos, then how do you
> > find the end of:
> >
> >   http://host/git repo with spaces in the path
> >
> > compared to:
> >
> >   http://host/git+repo+with+spaces+in+the+path
> 
> You just write <URL:http://host/git repo with spaces in the path> and
> have a good chance it will work.

It doesn't with KMail.

-- robin
