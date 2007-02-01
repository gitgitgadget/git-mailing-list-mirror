From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .git/info/refs
Date: Thu, 1 Feb 2007 15:03:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702011501250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
 <45B7818F.6020805@zytor.com> <7vireuaj9d.fsf@assigned-by-dhcp.cox.net>
 <45B92332.5060206@zytor.com> <7v3b5yai6c.fsf@assigned-by-dhcp.cox.net>
 <45B928AD.50508@zytor.com> <Pine.LNX.4.63.0701260029580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45BBCD27.5050408@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 15:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCcWs-0007sI-Tb
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 15:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbXBAODG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 09:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422898AbXBAODG
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 09:03:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:40952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422897AbXBAODE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 09:03:04 -0500
Received: (qmail invoked by alias); 01 Feb 2007 14:03:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 01 Feb 2007 15:03:01 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45BBCD27.5050408@zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38354>

Hi,

I just had another idea: why not generate the content of the "cover page" 
in a cron job, every minute or so, and save it into a static index.html? 
This should take quite a load from the server, since not even Perl has to 
be started to serve that page.

Ciao,
Dscho
