From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Controversial blob munging series
Date: Mon, 23 Apr 2007 18:54:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231853390.8822@racer.site>
References: <11772221041630-git-send-email-junkio@cox.net>
 <Pine.LNX.4.64.0704231540580.8822@racer.site>
 <Pine.LNX.4.64.0704231725520.22673@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg1oa-0004OX-S2
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 18:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbXDWQyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbXDWQyd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 12:54:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:50428 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754089AbXDWQyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 12:54:32 -0400
Received: (qmail invoked by alias); 23 Apr 2007 16:54:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 23 Apr 2007 18:54:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xxVxf3U9x8YeHIHXJ5Icrbv5gD+OnnfsjRtqxvm
	AszbAfSJKvd+JU
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0704231725520.22673@reaper.quantumfyre.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45334>

Hi,

On Mon, 23 Apr 2007, Julian Phillips wrote:

> On Mon, 23 Apr 2007, Johannes Schindelin wrote:
> 
> > Being stuck with Pine, which still does not do Maildir, and wanting
> > to be able to read my mails as distributed as I am working on documents
> > and software projects, I always dreamt of having all my mail in Git.
> >
> > With filters, it should be relatively easy to do that. Before checking in,
> > the individual mailbox files are split, the contents are put into the
> > object database, and the mailbox file is replaced by a text file
> > consisting of the SHA1s of the mails.
> >
> > Ideally, I would eventually not only teach Pine to understand Maildir
> > format, but read and store the mails in a Git backend. Alas, I am way too
> > lazy for that.
> 
> You do know about Eduardo Chappa's patches for pine?  In particular
> http://staff.washington.edu/chappa/pine/info/maildir.html.

I did not.

Thanks,
Dscho
