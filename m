From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Make MINGW port cross-compilable from Linux
Date: Wed, 30 May 2007 14:43:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705301442100.4011@racer.site>
References: <11804928354163-git-send-email-pclouds@gmail.com> 
 <465D1EDD.658483B4@eudaptics.com>  <Pine.LNX.4.64.0705301411190.4011@racer.site>
 <fcaeb9bf0705300618s712be8auf29ba7bd3579bd16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1349415260-1180532589=:4011"
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 15:45:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtOU5-0004xy-2k
	for gcvg-git@gmane.org; Wed, 30 May 2007 15:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbXE3No5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 09:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbXE3No5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 09:44:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:55210 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751188AbXE3No4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 09:44:56 -0400
Received: (qmail invoked by alias); 30 May 2007 13:44:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 30 May 2007 15:44:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8qNwg4m78/HQPDs1XgsZHaObjl6SF1l0YSiaOJo
	Z5AxaSrH0mExgF
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0705300618s712be8auf29ba7bd3579bd16@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48762>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1349415260-1180532589=:4011
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 30 May 2007, Nguyen Thai Ngoc Duy wrote:

> On 5/30/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Wed, 30 May 2007, Johannes Sixt wrote:
> > 
> > > "Nguyễn Thái Ngọc Duy" wrote:
> > > >
> > > > The following patches allow to cross compile mingw port from Linux less
> > painful.
> > >
> > > Thank you. Could you please push this to the mob branch?
> > >
> > > git push mob@repo.or.cz:/srv/git/git/mingw.git +mybranch:mob
> > >
> > > The series should be based on mingw.git's master branch (not devel)!
> > 
> > Is there any good reason why you do that in such a secretive manner? I
> > have not seen this series on the list, just your replies.
> 
> It's vger that should be blamed, not me :) I sent the series to
> Johannes Sixt and CC git@vger but they never came.

That explains it. I notice that your mail did not come through again... 
Maybe vger should grow a facility where you can check _why_ a mail does 
not go through. Sort of frustrating otherwise.

Ciao,
Dscho

--8323584-1349415260-1180532589=:4011--
