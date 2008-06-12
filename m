From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Typo in RelNotes.
Date: Thu, 12 Jun 2008 00:53:30 -0400
Message-ID: <20080612045330.GB25992@sigill.intra.peff.net>
References: <alpine.LNX.1.00.0806120434290.5838@localhost> <905315640806112059r713bf807l20a1bc1e14ce4e27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 06:54:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6epP-0003ER-EV
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 06:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYFLExd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 00:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYFLExd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 00:53:33 -0400
Received: from peff.net ([208.65.91.99]:1166 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbYFLExc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 00:53:32 -0400
Received: (qmail 4201 invoked by uid 111); 12 Jun 2008 04:53:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 12 Jun 2008 00:53:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2008 00:53:30 -0400
Content-Disposition: inline
In-Reply-To: <905315640806112059r713bf807l20a1bc1e14ce4e27@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84699>

On Wed, Jun 11, 2008 at 08:59:37PM -0700, Tarmigan wrote:

> On Wed, Jun 11, 2008 at 7:38 PM, Mikael Magnusson <mikachu@gmail.com> wrote:
> >  * "git init --bare" is a synonym for "git --bare init" now.
> >
> > -* "git gc --auto" honors a new pre-aut-gc hook to temporarily disable it.
> > +* "git gc --auto" honors a new pre-auto-gc hook to temporarily disable it.
> >
> >  * "git log --pretty=tformat:<custom format>" gives a LF after each entry,
> >   instead of giving a LF between each pair of entries which is how
> 
> Any interest in fixing the typo on the next line while you're at it?

Maybe I am blind, but I don't see a typo. Are you referring to tformat,
which looks like a typo, but is actually correct?

-Peff
