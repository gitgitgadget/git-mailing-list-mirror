From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: support single-letter abbreviations for the
 actions
Date: Sat, 29 Sep 2007 22:48:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709292243280.28395@racer.site>
References: <Pine.LNX.4.64.0709290231300.28395@racer.site> <46FE7D0B.4060806@qumranet.com>
 <Pine.LNX.4.64.0709292156090.28395@racer.site> <46FEC00B.7050208@qumranet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 23:49:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbkBc-0008UD-9I
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 23:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbXI2VtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 17:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbXI2VtN
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 17:49:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:54816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753861AbXI2VtM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 17:49:12 -0400
Received: (qmail invoked by alias); 29 Sep 2007 21:49:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 29 Sep 2007 23:49:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HpTok+DfHReih96IXpx8ojiVPn2f3Cy/nCjZndd
	eBvPvKosLdVh8g
X-X-Sender: gene099@racer.site
In-Reply-To: <46FEC00B.7050208@qumranet.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59495>

Hi,

On Sat, 29 Sep 2007, Avi Kivity wrote:

> > > Can we make "amend" like squash, except that it keeps the first 
> > > commit's authorship instead of the second?  I often merge a commit 
> > > with some minor fix that comes later, and usually want to keep the 
> > > original author record.

Thinking about this again... Maybe it is a better semantics anyway? What 
do others think?

Ciao,
Dscho
