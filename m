From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Tue, 13 Nov 2007 11:19:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711131118360.4362@racer.site>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br>
 <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com>
 <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr>
 <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <vpqzlxiiii6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 13 12:20:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irtoq-0005d0-J8
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 12:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbXKMLUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 06:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbXKMLUU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 06:20:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:35086 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752656AbXKMLUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 06:20:18 -0500
Received: (qmail invoked by alias); 13 Nov 2007 11:20:17 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp038) with SMTP; 13 Nov 2007 12:20:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RLnA3xJsRYrGoku0gcu9P988Xf6xaDl0wZfnnO4
	nJqKjiQbNFEVjE
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqzlxiiii6.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64790>

Hi,

On Tue, 13 Nov 2007, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > But both of Johannes's points apply equally well to an empty bare 
> > repository and to an empty non bare repository.  IOW, bareness does 
> > not matter to the suggestion Johannes gave.
> 
> He was suggesting to create the initial commit before cloning:
> 
> >> So you need to populate the repository before starting _anyway_.

Of course I was suggesting to push into the still empty, bare repository, 
before anybody is cloning.

Ciao,
Dscho
