From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Mon, 2 Jul 2007 22:05:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707022205210.4071@racer.site>
References: <46893F61.5060401@jaeger.mine.nu>
 <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <vpq7ipittl2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:05:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5T5b-00021Y-IX
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 23:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbXGBVFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 17:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbXGBVFk
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 17:05:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:35653 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755011AbXGBVFk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 17:05:40 -0400
Received: (qmail invoked by alias); 02 Jul 2007 21:05:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 02 Jul 2007 23:05:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ctvZaaRochkLuHOZJ+WBgXP5fEXSAhqk4nbIv2J
	yvc+MTP844Lkpm
X-X-Sender: gene099@racer.site
In-Reply-To: <vpq7ipittl2.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51405>

Hi,

On Mon, 2 Jul 2007, Matthieu Moy wrote:

> Defaulting to --cached would be an obvious way to avoid data-loss. _At 
> least_, mentionning --cached in the error message in case of staged 
> changes would be a considerable step forward.
> 
> At the moment, the non-expert user will have difficulties to unversion 
> the file without deleting it. I just see it as
> 
> $ git rm foo
> error: 'foo' has changes staged in the index
> (hint: to hang yourself, try -f)
> $ _

What's so wrong with our man pages? You know, there have been man hours 
invested in them, and they are exclusively meant for consumption by people 
who do not know about the usage of the commands...

Hth,
Dscho
