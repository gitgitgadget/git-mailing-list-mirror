From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Tiny bug report, interaction between alias and help
Date: Sat, 19 Jan 2008 23:23:25 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801192323040.5731@racer.site>
References: <20080119142750.GA9182@phenix.progiciels-bpi.ca> <20080119174146.GA3913@coredump.intra.peff.net> <alpine.LSU.1.00.0801192252060.5731@racer.site> <20080119225723.GA17170@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Fran=E7ois_Pinard?= <pinard@iro.umontreal.ca>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 20 00:24:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGN2p-0008Dy-7a
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 00:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbYASXXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 18:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758600AbYASXXi
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 18:23:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:45961 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758369AbYASXXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 18:23:37 -0500
Received: (qmail invoked by alias); 19 Jan 2008 23:23:35 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp055) with SMTP; 20 Jan 2008 00:23:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193mFRWAp53BDtkOkZFRPItmeeqUi2jvtDQl043Lm
	LKqoOeQDLwp8hF
X-X-Sender: gene099@racer.site
In-Reply-To: <20080119225723.GA17170@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71143>

Hi,

On Sat, 19 Jan 2008, Jeff King wrote:

> On Sat, Jan 19, 2008 at 10:55:24PM +0000, Johannes Schindelin wrote:
> 
> > Urgh... We really have something like that in git?  Looks like a prime 
> > candidate for refactoring a la
> 
> Yes, my patch was a one-off "how about this?". I already have a 
> refactored version in my tree (that also converts cmd_help to use 
> parse_options), but I am holding on to it until post-1.5.4.

Very nice!

Thanks,
Dscho
