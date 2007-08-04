From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-gui console app ?
Date: Sat, 4 Aug 2007 12:29:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041225520.14781@racer.site>
References: <20070804101058.GA520@Mac2.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Erik Colson <eco@ecocode.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 13:30:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHHpk-0000PH-Fz
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 13:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbXHDLaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 07:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754103AbXHDLaJ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 07:30:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:54695 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751694AbXHDLaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 07:30:07 -0400
Received: (qmail invoked by alias); 04 Aug 2007 11:30:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 04 Aug 2007 13:30:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184lphzAB44ErDS99HPMa9Rs7IZoHS4N9uxDorX0Y
	bjr4WrbsmT1eYj
X-X-Sender: gene099@racer.site
In-Reply-To: <20070804101058.GA520@Mac2.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54823>

Hi,

On Sat, 4 Aug 2007, Erik Colson wrote:

> git-gui is a nice application and I like to use it while developping.
> However as probably a lot of developpers do, I regularly code in Emacs
> from a distant ssh client.
> Therefor I'd want to find some app like git-gui running in console...
> Does this exist or is there a project in development ?

There is tig.  http://repo.or.cz/w/tig.git

It is something similar to gitk but based on curses, so it is a viewer for 
now.  But I do not see any fundamental reason why it should not be 
possible to teach it many of the tricks git-gui does.

Just fork it (you can even do that on repo.or.cz; tig.git is mirrored 
there), and give it a go!

Ciao,
Dscho
