From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFE] git rebase doesn't say it failed
Date: Mon, 10 Mar 2008 13:29:55 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803101329430.3975@racer.site>
References: <429AC7A2-511E-496F-9C1C-4627604EBBFB@gmail.com> <alpine.LSU.1.00.0803101207120.3975@racer.site> <fr37gm$9k4$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2089080222-1205152195=:3975"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:30:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYh9G-0002mz-Np
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 13:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbYCJM3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 08:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbYCJM3w
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 08:29:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:57401 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751059AbYCJM3v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 08:29:51 -0400
Received: (qmail invoked by alias); 10 Mar 2008 12:29:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 10 Mar 2008 13:29:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+q/INagHaq3Ek6ZCOpqlj7YdScBfpt/ULi+a2cWw
	RncL/PzznyRkmT
X-X-Sender: gene099@racer.site
In-Reply-To: <fr37gm$9k4$2@ger.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76724>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-2089080222-1205152195=:3975
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 10 Mar 2008, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> >> Git was unable to rebase due to the files above.  Please commit them or move
> >> them out of the way.
> >> Hint: See "git reset --help" for a suggestion about saving work in progress.
> > 
> > The same comment I gave last week applies here: people complained that Git 
> > was too chatty.  I tend to agree, since the important information was lost 
> > in the huge amount of text.  Now you say we should make it chatty again?
> 
> --verbose option, anyone?

Patches welcome,
Dscho

--8323584-2089080222-1205152195=:3975--
