From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Reordering lines in "git-rebase -i" task sheet
Date: Thu, 22 Nov 2007 22:11:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711222211020.27959@racer.site>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
 <20071122192556.GA14662@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 23:12:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvKHG-0007Ho-M2
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 23:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbXKVWLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 17:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbXKVWLt
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 17:11:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:38068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753003AbXKVWLt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 17:11:49 -0500
Received: (qmail invoked by alias); 22 Nov 2007 22:11:47 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp032) with SMTP; 22 Nov 2007 23:11:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XlF8XHuUXSHZ7ADMdd+8mpFJY/MY/nq6YfmzgQS
	dEfi5fIE4yvb+K
X-X-Sender: gene099@racer.site
In-Reply-To: <20071122192556.GA14662@old.davidb.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65853>

Hi,

On Thu, 22 Nov 2007, David Brown wrote:

> On Thu, Nov 22, 2007 at 01:21:55AM -0800, Junio C Hamano wrote:
> 
> > That is the reason why git commit leaves the first line empty in its 
> > initial template.  It is to allow the user to immediately start 
> > typing.
> 
> Unless of course your editor tries to be "helpful" and remember what 
> line you were on previously in a file.

IMHO this objection is irrelevant, since these helpful editors do not have 
any preference as to where the help text should be.

Hth,
Dscho
