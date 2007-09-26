From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add ability to specify SMTP server port when using
 git-send-email.
Date: Wed, 26 Sep 2007 02:42:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709260239210.28395@racer.site>
References: <1190759927-19493-1-git-send-email-glenn@rempe.us>
 <7vabra2rv3.fsf@gitster.siamese.dyndns.org> <1A0CAB9D-5C99-4FD7-B3AC-9B3161FD8663@rempe.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Glenn Rempe <glenn@rempe.us>
X-From: git-owner@vger.kernel.org Wed Sep 26 03:43:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaLw8-00059d-3I
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 03:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbXIZBnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 21:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752930AbXIZBnS
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 21:43:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:39393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753012AbXIZBnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 21:43:18 -0400
Received: (qmail invoked by alias); 26 Sep 2007 01:43:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 26 Sep 2007 03:43:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6a5IPo0n6pxbl83S/44f9bdGwrVcVA72SZUJrh7
	x0Zsu6NN2cZfOb
X-X-Sender: gene099@racer.site
In-Reply-To: <1A0CAB9D-5C99-4FD7-B3AC-9B3161FD8663@rempe.us>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59206>

Hi,

On Tue, 25 Sep 2007, Glenn Rempe wrote:

> > * The indentation was horrible.  Maybe your tabstop is set
> >   incorrectly?
> 
> Can you be more detailed on the definition of 'horrible'? :-) I am using 
> Textmate on OS X with soft tab stops (2 spaces).  What should it be to 
> look less horrible on your end?  Or is the issue that I indent fewer 
> tabstops than you expect? If so, sorry since perl is not my usual 
> language and Ruby 2 space (soft tab) indentation looks right to my eye.

We use soft tabs, with the standard up-to 8 spaces, so that short sighted 
people like me can still see that the line is actually indented.

In related news, I just saw that we never mention the 80 characters per 
line convention in code, or the 76 characters per line for commit messages 
(because of the 4 space indent git-log does -- ouch ;-)

Ciao,
Dscho
