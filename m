From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] user-manual: mention git gui citool (commit, amend)
Date: Sun, 5 Aug 2007 15:48:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051547410.14781@racer.site>
References: <20070803125634.GB28323@fieldses.org> <1186318785677-git-send-email-prohaska@zib.de>
 <Pine.LNX.4.64.0708051457110.14781@racer.site> <17AA7EBE-B755-4F26-9C7E-AF6D762811F2@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bfields@fieldses.org, gitster@pobox.com, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 16:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHhPP-0004ps-UC
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 16:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbXHEOsl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 10:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbXHEOsl
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 10:48:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:37866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752213AbXHEOsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 10:48:40 -0400
Received: (qmail invoked by alias); 05 Aug 2007 14:48:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 05 Aug 2007 16:48:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wdrBpEv0wsjCsBn2VzOsoRHw0PLIho22KgZlSga
	tlsz7nbI1Jj0nB
X-X-Sender: gene099@racer.site
In-Reply-To: <17AA7EBE-B755-4F26-9C7E-AF6D762811F2@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55028>

Hi,

On Sun, 5 Aug 2007, Steffen Prohaska wrote:

> On Aug 5, 2007, at 3:58 PM, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Sun, 5 Aug 2007, Steffen Prohaska wrote:
> > 
> > > git gui is especially useful because it allows to select diff hunks.
> > 
> > You should give a _big_ _fat_ _red_ warning there.
> > 
> > If you selectively commit diff hunks, you _never_ tested what you
> > committed.
> > 
> > That is the reason we're not advertising git add -i more actively.
> 
> Hmm... If you do 'git cherry-pick' or 'git rebase' you also did
> not test what you committed. Should we advertise them less
> actively as well?

But you have that state in your working tree!  Big difference there!

Ciao,
Dscho
