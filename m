From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] glossary: stop generating automatically
Date: Mon, 19 Mar 2007 14:56:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703191455550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <117427428145-git-send-email-> <1174274281887-git-send-email->
 <11742742813855-git-send-email-> <1174274281258-git-send-email->
 <11742742811304-git-send-email-> <7vaby9n98u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 14:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTILk-000400-Oi
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 14:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933913AbXCSN4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 09:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933909AbXCSN4b
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 09:56:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:46323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933913AbXCSN4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 09:56:30 -0400
Received: (qmail invoked by alias); 19 Mar 2007 13:56:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 19 Mar 2007 14:56:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tSTxVkCVtHb5MQM0pSXDNiCG2wLX1IxPLLZsr6Z
	yMX+ZROeACd+KX
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vaby9n98u.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42620>

Hi,

On Sun, 18 Mar 2007, Junio C Hamano wrote:

> "J. Bruce Fields" <bfields@citi.umich.edu> writes:
> 
> > From: J. Bruce Fields <bfields@citi.umich.edu>
> >
> > The sort_glossary.pl script sorts the glossary, checks for duplicates,
> > and automatically adds cross-references.
> >
> > But it's not so hard to do all that by hand, and sometimes the automatic
> > cross-references are a little wrong; so let's run the script one last
> > time and check in its output.
> 
> This initially raised my eyebrow but after looking at the next
> patch, I tend to agree why automated stuff needs to be lot
> better, or we forget about automation and maintain that by
> hand.
> 
> Dscho, preference?

None at the moment. I am deeply involved in a project, and have next to no 
cycles to spend on Git, let alone documentation :-(

Ciao,
Dscho
