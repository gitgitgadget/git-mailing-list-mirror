From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 3 Sep 2007 15:39:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031538320.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC1186.2010008@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 16:39:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISD5L-0001aH-IU
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 16:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbXICOjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 10:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbXICOjX
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 10:39:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:36579 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751567AbXICOjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 10:39:23 -0400
Received: (qmail invoked by alias); 03 Sep 2007 14:39:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 03 Sep 2007 16:39:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZpEA8DLxZ3PcUq2+NRnZl+W5+fCxsyTawtNddbG
	MK1lJpkqGHbZYk
X-X-Sender: gene099@racer.site
In-Reply-To: <46DC1186.2010008@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57491>

Hi,

On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:

> Johannes Schindelin said the following on 03.09.2007 15:33:
>
> > BTW it would have been way easier to apply your patch, had you 
> > followed SubmittingPatches...
> 
> Heh, I actually tried, using the Thunderbird way. Of course the 
> attachments are non-conforming :-) What was the problem? Whitespace 
> issues, Windows EOL, attachments, or all of the above? :-)

git am said that the patch was empty.

Ciao,
Dscho
