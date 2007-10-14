From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Sun, 14 Oct 2007 21:14:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710142112540.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git list <git@vger.kernel.org>, Eli Zaretskii <eliz@gnu.org>,
	Make Windows <make-w32@gnu.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Oct 14 22:14:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih9rI-0003J4-5Y
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 22:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbXJNUOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 16:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbXJNUOb
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 16:14:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:51017 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752283AbXJNUOa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 16:14:30 -0400
Received: (qmail invoked by alias); 14 Oct 2007 20:14:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 14 Oct 2007 22:14:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/K3tn0+O/X3CFXQ95VTtBS8O9Sw20k+02lVLMC9
	+a1ZOV4TL8t6Nj
X-X-Sender: gene099@racer.site
In-Reply-To: <47126957.1020204@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60898>

Hi,

On Sun, 14 Oct 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
>
> > I do not see any reason why libification helps the user experience on 
> > Windows.
> 
> I was under the impression that the windows port suffers from Windows' 
> lack of a proper fork() and friends and that a proper library would help 
> solving those problems. Perhaps I was misinformed.

It suffered.  Until Hannes Sixt did a very fine job which cumulated in the 
patch series he posted yesterday.  Of course, this work is the reason 
msysGit is functional.

Ciao,
Dscho
