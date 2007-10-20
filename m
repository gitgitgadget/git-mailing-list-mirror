From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 21 Oct 2007 00:33:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710210031130.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> 
 <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>
  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, Andreas Ericsson <ae@op5.se>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 04:23:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjQTh-0006KU-25
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 04:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbXJUCXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 22:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbXJUCXe
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 22:23:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:55391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750831AbXJUCXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 22:23:33 -0400
Received: (qmail invoked by alias); 20 Oct 2007 23:33:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 21 Oct 2007 01:33:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/khi0YMYTk4ip/nlD2ZqF0tD5+LdE0TNjK87wSWz
	eAmBA+HOd3RH07
X-X-Sender: gene099@racer.site
In-Reply-To: <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61865>

Hi,

On Sun, 21 Oct 2007, Jakub Narebski wrote:

> On 10/20/07, Steffen Prohaska <prohaska@zib.de> wrote:
> 
> > Maybe we could group commands into more categories?
> >
> > plumbing: should be hidden from the 'normal' user. Porcelain
> >    should be sufficient for every standard task.
> 
> The problem is division between what is porcelain and what is plumbing. 
> Some commands are right on border (git-fsck, git-update-index, 
> git-rev-parse comes to mind).

Sorry, but my impression from the latest mails was that the commands are 
fine.  What is lacking is a nice, _small_ collection of recommended 
workflows.  And when we have agreed on such a set of workflows, we 
optimize the hell out of them.  Only this time it is not performance, but 
user-friendliness.

Hmm?

Ciao,
Dscho
