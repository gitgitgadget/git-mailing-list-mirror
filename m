From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: fix git-clone manpage not to refer to
 itself
Date: Tue, 20 Nov 2007 11:28:11 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711201126430.27959@racer.site>
References: <87ejeq1131.fsf@osv.gnss.ru>
 <Pine.LNX.4.64.0711191430460.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <3FC9A391-AED0-4988-B1F7-EE5C06AD1137@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 12:29:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuRHn-0000Ro-FY
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 12:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbXKTL2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 06:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755818AbXKTL2l
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 06:28:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:41738 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752278AbXKTL2k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 06:28:40 -0500
Received: (qmail invoked by alias); 20 Nov 2007 11:28:38 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp056) with SMTP; 20 Nov 2007 12:28:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18g9gh1fUYgNkgMJ8WniBO4a11nAL96ZEE4XllcA7
	+hHSErs8mb43t/
X-X-Sender: gene099@racer.site
In-Reply-To: <3FC9A391-AED0-4988-B1F7-EE5C06AD1137@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65541>

Hi,

On Tue, 20 Nov 2007, Wincent Colaiuta wrote:

> El 19/11/2007, a las 14:35, Johannes Schindelin escribi?:
> 
> > - it makes writing the perl script to do a very tiny subset of 
> > asciidoc formatting much harder.  We encounter enough problems with 
> > the different versions of asciidoc/docbook combinations that I think 
> > this perl script would be actually useful.
> > 
> > I know that the user manual uses some advanced features, too, but it 
> > did not use ifdef in the main text, for example, let alone nested 
> > ifdefs, which your patch would encourage much more than the source 
> > before.
> 
> Out of curiosity, have you done any more work on that WIP AsciiDoc 
> replacement since you last wrote to the list about it back in October?

Yes.  I rewrote it three times, and the third time is not finished, but 
slowed down to a glacial pace.  You can see the continental shift at my 
repository on repo.or.cz (it's the "dscho" fork of git.git).

Ciao,
Dscho
