From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: markdown 2 man, was Re: Git Community Book
Date: Wed, 30 Jul 2008 15:27:38 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807301514280.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com> <20080729170955.GK32184@machine.or.cz> <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com> <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git list <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 30 15:28:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOBjP-0001l6-8B
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 15:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbYG3N1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 09:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbYG3N1m
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 09:27:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:56138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751586AbYG3N1l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 09:27:41 -0400
Received: (qmail invoked by alias); 30 Jul 2008 13:27:39 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp067) with SMTP; 30 Jul 2008 15:27:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GzfY35sxGZefKSzu1NG2FChEBS+CbEydJlaefP6
	lIUBmpDXL0/Kbk
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90781>

Hi,

On Tue, 29 Jul 2008, Julian Phillips wrote:

> there does exist at least one tool that claims to be able
> to convert from markdown to man: http://johnmacfarlane.net/pandoc/

Just want to mention that it is written in Haskell, so chances are that it 
is even harder to install than asciidoc (I am thinking about non-Linux, 
of course).

Note also that Markdown cannot create TOCs automatically, AFAICT.  So 
probably it would be not all that easy to convert the User Manual to that 
format.

If at all, I would have preferred a format switch to Wiki syntax so that 
we can use the same source on the Git wiki as in our Documentation/ 
directory.  But such a switch could only come after a consensus of the 
Community anyway.

Ciao,
Dscho
