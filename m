From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 16:49:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231647390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
 <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 16:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9NuS-0004TA-IA
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961AbXAWPuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbXAWPuE
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:50:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:40757 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932961AbXAWPuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:50:00 -0500
Received: (qmail invoked by alias); 23 Jan 2007 15:49:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 23 Jan 2007 16:49:59 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37536>

Hi,

On Tue, 23 Jan 2007, Linus Torvalds wrote:

> On Tue, 23 Jan 2007, Johannes Schindelin wrote:
> > 
> > Lucky you! Fortunately, I don't have any Windows at home (but I still 
> > have windows, thank God!). So I cannot even be tempted to work on this 
> > thing in my free time.
> 
> Actually, I have been seriously wondering if there is some setup under 
> Wine that I could run, just so that I'd see the Windows development 
> environment for git.

IMHO the best way to go ahead is to download ReactOS, and run it inside 
QEmu. That way you'll get a better idea of the speed and integration.

Ciao,
Dscho
