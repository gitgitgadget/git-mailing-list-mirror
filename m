From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 01:48:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610190144450.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
 <eh64tk$rug$2@sea.gmane.org> <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE>
 <eh6dgr$pu8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Thu Oct 19 01:48:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaL8w-00083c-RT
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 01:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945903AbWJRXsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 19:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945910AbWJRXsK
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 19:48:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:38357 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1945903AbWJRXsJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 19:48:09 -0400
Received: (qmail invoked by alias); 18 Oct 2006 23:48:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 19 Oct 2006 01:48:06 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Charles Duffy <cduffy@spamcop.net>
In-Reply-To: <eh6dgr$pu8$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29300>

Hi,

On Wed, 18 Oct 2006, Charles Duffy wrote:

> The point is that core, pervasive functionality can be modified at 
> runtime, with no recompilation or installation of tools not included in 
> the bzr package itself, simply by dropping a directory into place.

Please note that this is not welcome here. I _need_ to trust my SCM. And 
_that_ means that no strange non-mainline beast can be allowed to change 
core features.

So, the wonderful upside of plugins you described here are actually the 
reason I will never, _never_ use bzr with plugins.

Ciao,
Dscho

--

It's not paranoia. It's called experience.
