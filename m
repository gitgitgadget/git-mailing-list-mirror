From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 08:53:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805020851250.2691@eeepc-johanness>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org> <20080502061108.GA1052@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 09:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrq64-0001p3-Tc
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 09:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbYEBHxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 03:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbYEBHxY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 03:53:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:40277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752284AbYEBHxX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 03:53:23 -0400
Received: (qmail invoked by alias); 02 May 2008 07:53:21 -0000
Received: from R595c.r.pppool.de (EHLO eeepc-johanness.samsung.router) [89.54.89.92]
  by mail.gmx.net (mp002) with SMTP; 02 May 2008 09:53:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19TuPNNxNtTrCf8Krwec1uFGsGEXJkgyjGWjNDTDP
	H3Afsmk8Vbewca
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080502061108.GA1052@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80967>

Hi,

On Fri, 2 May 2008, Jeff King wrote:

> On Thu, May 01, 2008 at 10:56:40PM -0700, Junio C Hamano wrote:
> 
> > Hmmm, I thought I heard you cheered on that patch?  Perhaps it was 
> > somebody else.
> 
> Definitely not me. I think it was Dscho.

Yep.

I find it amazingly useful to see the first part, you know, the part with 
the staged changes, instead of them whizzing by and me only seeing the 
last part of the untracked files.  And of course, I do not even see the 
label "Untracked files:", because there are so many.

I agree, though, that the paging only makes sense with FSRX (not only 
FX!), and that "less" should have that as default, too.

Ciao,
Dscho
