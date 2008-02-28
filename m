From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] New test to check the real "subtree" case
Date: Thu, 28 Feb 2008 09:45:03 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802280944110.22527@racer.site>
References: <7vprun32m2.fsf@gitster.siamese.dyndns.org> <20080228015122.GB31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 10:46:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUfLB-0001ga-Q7
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 10:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494AbYB1Jph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 04:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbYB1Jph
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 04:45:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:51068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753421AbYB1Jph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 04:45:37 -0500
Received: (qmail invoked by alias); 28 Feb 2008 09:45:34 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp013) with SMTP; 28 Feb 2008 10:45:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oqfwENSAoBU4p2bsyNOsZ/OrFgzPfcpzoSdkqH8
	5Htw5yAtbXsRLq
X-X-Sender: gene099@racer.site
In-Reply-To: <20080228015122.GB31441@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75374>

Hi,

On Thu, 28 Feb 2008, Miklos Vajna wrote:

> On Sat, Feb 23, 2008 at 11:16:21AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> > A new test t6029 currently only tests the strategy is available,
> > but it should be enhanced to check the real "subtree" case.
> 
> i think something like this should do it.
> 
>  t/t3035-merge-subtree.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++

Why yet another file?  Why not enhance t6029, as suggested?

Ciao,
Dscho
