From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Mon, 22 Feb 2010 09:37:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002220936030.20986@pacific.mpi-cbg.de>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org>  <4B8233DE.7050106@viscovery.net>  <7v4ol9lngk.fsf@alter.siamese.dyndns.org> <6672d0161002220017u7270c637k83a796cfc8730a64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1937937292-1266827874=:20986"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:34:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjThC-0000sY-DP
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 09:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab0BVIbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 03:31:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:45972 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751680Ab0BVIbI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 03:31:08 -0500
Received: (qmail invoked by alias); 22 Feb 2010 08:31:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 22 Feb 2010 09:31:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WQycOR9VWUy/26uz5ZF4U2T4fea/x1Xm4XfPf/X
	LU/XG1wzl/2/TK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <6672d0161002220017u7270c637k83a796cfc8730a64@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140655>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1937937292-1266827874=:20986
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 22 Feb 2010, Björn Gustavsson wrote:

> On Mon, Feb 22, 2010 at 8:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > In the meantime, please run "git log --oneline --first-parent master..pu",
> > pick "ce8d258 Merge 'jn/maint-fix-pager'" from the output, and use the
> > second parent ce8d258^2 instead.
> 
> I use a simple Perl script called create-topic-branches.
> It can be found here:
> 
> http://gist.github.com/275033

IIRC Thomas Rast did something similar in the wake of the @{-<n>} work, 
but unfortunately, it did not make it into contrib, it seems.

Ciao,
Dscho

--8323328-1937937292-1266827874=:20986--
