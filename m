From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] git-cvsexportcommit.perl: git-apply no longer needs
 --binary
Date: Tue, 16 Oct 2007 23:49:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710162348260.25221@racer.site>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu>
 <Pine.LNX.4.64.0710161404220.25221@racer.site> <19B03C18-6BBD-4F67-93DC-37B422445C82@mit.edu>
 <200710162320.14917.robin.rosenberg.lists@dewire.com>
 <561D7B44-9EDE-447B-A751-BE6E3A3AD9CC@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Oct 17 00:49:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhvEJ-0007Mx-8G
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 00:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760555AbXJPWt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 18:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760403AbXJPWt2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 18:49:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:46892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759566AbXJPWt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 18:49:27 -0400
Received: (qmail invoked by alias); 16 Oct 2007 22:49:25 -0000
Received: from unknown (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 17 Oct 2007 00:49:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jWnwgGEyjPpzVgve7Eqpd2UAjbjIIEn2nka+Iw8
	zl8SI4C1F2qz/3
X-X-Sender: gene099@racer.site
In-Reply-To: <561D7B44-9EDE-447B-A751-BE6E3A3AD9CC@mit.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61272>

Hi,

On Tue, 16 Oct 2007, Michael Witten wrote:

> On 16 Oct 2007, at 5:20:14 PM, Robin Rosenberg wrote:
> 
> > So all this series does is... making it harder to follow the history?
> 
> If you follow the history solely on patches.
> 
> 
> > Ack for removing the --binary, the rest is just noise
> 
> I think fixing the tabs is more important than removing --binary.
> 
> It's clear the the entropy of tabulation increases over time;
> the tab patch acts as a buffer to reconstruct a clean signal.

Git.  The most advanced TCM - Tab Code Manager.  It's not about source, 
it's about tabs.

;-)

Ciao,
Dscho
