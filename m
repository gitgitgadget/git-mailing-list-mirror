From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Sun, 14 Dec 2008 12:24:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812141224030.2014@eeepc-johanness>
References: <7v7i632mg9.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812141142300.2014@eeepc-johanness> <20081214111548.GB6499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 14 12:24:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBp4z-0005N0-Kq
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbYLNLWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYLNLWw
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:22:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:36513 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752918AbYLNLWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:22:51 -0500
Received: (qmail invoked by alias); 14 Dec 2008 11:22:49 -0000
Received: from ini-firewall.unizh.ch (EHLO eeepc-johanness) [130.60.5.218]
  by mail.gmx.net (mp011) with SMTP; 14 Dec 2008 12:22:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZdQBWvABZEbLTUGOl0zCXkarAHbQjq2/WUgqKHv
	Jq+FQ6Uen7mvMk
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20081214111548.GB6499@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103071>

Hi,

On Sun, 14 Dec 2008, Jeff King wrote:

> On Sun, Dec 14, 2008 at 11:44:23AM +0100, Johannes Schindelin wrote:
> 
> > > * mv/um-pdf (Wed Dec 10 23:44:50 2008 +0100) 1 commit
> > >  - Add support for a pdf version of the user manual
> > > 
> > > I do not have a new enough combination of dblatex and asciidoc myself 
> > > but this would help interested people.
> > 
> > I haven't had a look at the patches, but isn't "pdflatex" supposed to be 
> > the common way to get .pdf files from LaTeX sources?
> 
> But we don't have latex sources; we have docbook sources. Hence dblatex
> (which does the conversion to PDF internally, so it is a bit of a
> misnomer).

Indeed, I was fooled.

Thanks for the clarification,
Dscho
