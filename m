From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: looking for "market share" analysis of SCMs.
Date: Wed, 21 May 2008 23:28:56 +0300
Message-ID: <20080521202856.GA3066@mithlond.arda.local>
References: <48329282.1040407@tikalk.com> <46a038f90805202210v5d0f75cekbad51da89c46f47@mail.gmail.com> <bd6139dc0805202221v6fc476e8rcdb1822b17d8c13@mail.gmail.com> <200805212139.25909.robin.rosenberg.lists@dewire.com> <alpine.LNX.1.00.0805211556380.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	sverre@rabbelier.nl, Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 21 22:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyuwm-0002SL-1Q
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 22:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758418AbYEUU3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 16:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761128AbYEUU3M
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 16:29:12 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:45181 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S937126AbYEUU3K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 16:29:10 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 482C7E62004BD372; Wed, 21 May 2008 23:28:58 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jyuvg-0002BZ-3d; Wed, 21 May 2008 23:28:56 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0805211556380.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82581>

Daniel Barkalow wrote (2008-05-21 16:07 -0400):

> I think tar and diff are necessary to install git-core or any other
> .deb, so it's unsurprising that they've got a 100% market share by
> that metric. Until Debian switches to a git-based package format,
> git's not going to catch up to those...

Yes, tar and diff are in every Debian system and can't be casually
removed:

  $ aptitude remove tar
  [...]

  WARNING: Performing this action will probably cause your system to break!
           Do NOT continue unless you know EXACTLY what you are doing!
  To continue, type the phrase "I am aware that this is a very bad idea":
