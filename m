From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Fri, 3 Apr 2009 01:08:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904030107320.10279@pacific.mpi-cbg.de>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com> <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de> <7v63hmekyv.fsf@gitster.siamese.dyndns.org>
 <49D542FA.3070304@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 01:07:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpW0p-0005J1-FO
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 01:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbZDBXGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 19:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZDBXGX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 19:06:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:44465 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751348AbZDBXGW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 19:06:22 -0400
Received: (qmail invoked by alias); 02 Apr 2009 23:06:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 03 Apr 2009 01:06:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+njGRVuzKnIMVChmqnwWmLGG5wuYUO9CtiO+kwiW
	6MCzo+spVxl6Ld
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49D542FA.3070304@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115504>

Hi,

On Thu, 2 Apr 2009, A Large Angry SCM wrote:

> Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > > What part of the email address is this going to lowercase? Only the
> > > > domain
> > > > name is case agnostic.
> > 
> > That is my understanding of RFC, too.  Let's see where this mail goes to
> > find out how much more lenient the real world is ;-).
> > 
> > 
> 
> Many email providers/servers are lenient when it comes to case in the 
> local part of an email address (after all, they control the 
> interpretation) but not every provider/server is and the RFC is VERY 
> clear on this issue.

And in one of my projects it is _very_ clear that this strict 
interpretation of the RFC, which does not matter in reality, _actively_ 
_hurts_.

In the alternative, can I ask you to adjust my .mailmap in your free time?

Thankyouverymuch,
Dscho
