From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: git-send-email and pine alias format
Date: Tue, 24 Jul 2007 09:51:06 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0707240950530.19035@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0707231146160.6889@blarg.am.freescale.net>
 <7vodi2i97j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 16:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDLkK-0003Pr-0A
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 16:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbXGXOvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 10:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbXGXOvf
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 10:51:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:48875 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbXGXOve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 10:51:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l6OEpTed023874;
	Tue, 24 Jul 2007 09:51:30 -0500
X-X-Sender: galak@blarg.am.freescale.net
In-Reply-To: <7vodi2i97j.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53604>

On Mon, 23 Jul 2007, Junio C Hamano wrote:

> Kumar Gala <galak@kernel.crashing.org> writes:
>
> > I was wondering why we don't parse the pine alias format according to the
> > following spec:
> >
> > http://www.washington.edu/pine/tech-notes/low-level.html
> >
> > I'd expect something like, to get the address field.
>
> My guess is simply because we got a "works-for-us" regexp by
> observing the program's behaviour, done by real Pine users.  On
> top of that, probably nobody knew and/or bothered to check if
> there is such "official spec" available.
>
> Could you send a signed and testable patch to the list so other
> Pine users can try it out please?  After seeing a few Ack's on
> the list, I'd like to apply it and preferably do so before 1.5.3
> final.

Ok, done.

- k
