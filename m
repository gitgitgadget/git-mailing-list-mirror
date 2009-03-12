From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Generalised bisection
Date: Thu, 12 Mar 2009 11:55:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>  <200903100808.15875.chriscool@tuxfamily.org>  <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>  <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com> 
 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com> <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1133572879-1236855327=:10279"
Cc: Ealdwulf Wuffinga <ealdwulf@googlemail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 11:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhiZN-0005Qt-4n
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 11:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbZCLKxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 06:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbZCLKxr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 06:53:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:35770 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753374AbZCLKxq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 06:53:46 -0400
Received: (qmail invoked by alias); 12 Mar 2009 10:53:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 12 Mar 2009 11:53:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++aLRXQsq+MHQ0+0bIIAtkxOUJ5VDwlx6pg3HIo4
	0e/JUkBz67VA9g
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113041>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1133572879-1236855327=:10279
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 12 Mar 2009, John Tapsell wrote:

> 2009/3/11 Ealdwulf Wuffinga <ealdwulf@googlemail.com>:
> > [John will get this twice, sorry; not used to this mail interface yet.]
> >
> > On Wed, Mar 11, 2009 at 9:35 AM, John Tapsell <johnflux@gmail.com> wrote:
> >
> >> mpmath might be the more annoying dependency - what functions do you
> >> use from it?  Could they trivially be reimplemented?
> >
> > What I use is the multiprecision floating point number class. doubles
> > don't seem to be long enough.
> 
> Hmm, really really?  Sometimes this sort of thing can be fixed by just 
> readjusting the formulas.  What formulas are you using that require more 
> precision than doubles?

Maybe you could post the formulae instead of forcing people to deduct them 
from the source code?

Thanks,
Dscho
--8323328-1133572879-1236855327=:10279--
