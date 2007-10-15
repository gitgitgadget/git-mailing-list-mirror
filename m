From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 09:34:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710150932560.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
  <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
  <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> 
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> 
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net>
 <Pine.LNX.4.64.0710150217120.25221@racer.site> <u4pgtj9rs.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, raa.lkml@gmail.com, ae@op5.se,
	tsuna@lrde.epita.fr, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 10:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhLP5-0001oP-3P
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 10:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbXJOIeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 04:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755053AbXJOIeL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 04:34:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:34275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754916AbXJOIeK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 04:34:10 -0400
Received: (qmail invoked by alias); 15 Oct 2007 08:34:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 15 Oct 2007 10:34:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4wFMvKkn4BCPB0NRJotdVTlkiXXVHdinsV32Nsp
	Qc0GRwKVPF4J2o
X-X-Sender: gene099@racer.site
In-Reply-To: <u4pgtj9rs.fsf@gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60961>

Hi,

On Mon, 15 Oct 2007, Eli Zaretskii wrote:

> No, you need to think in abstractions rather than POSIX-isms, and then 
> let each platform implement those abstractions as appropriate.

Last time I checked, POSIX was already an abstraction, thankyouverymuch.

Anyway, this discussion gets out of hand.  The question was: does Git work 
on Windows natively, and the answer as far as you are concerned is: yes.

Ciao,
Dscho
