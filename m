From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [OT] Activision (Re: use binmode(STDOUT) in git-status)
Date: Wed, 30 Nov 2005 00:56:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511300055360.22317@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com>
 <438B2859.6060109@zytor.com> <Pine.LNX.4.63.0511281700100.11362@wbgn013.biozentrum.uni-wuerzburg.de>
 <438B2B90.9010500@zytor.com> <Pine.LNX.4.63.0511281756001.11697@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051129221221.GC3033@steel.home> <7vwtir846o.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 00:57:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhFKc-0000Wy-BC
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 00:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVK2X4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 18:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVK2X4P
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 18:56:15 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:59565 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751398AbVK2X4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 18:56:14 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A48B313FA77; Wed, 30 Nov 2005 00:56:13 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 80496B5388; Wed, 30 Nov 2005 00:56:13 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5F58B9B3A4; Wed, 30 Nov 2005 00:56:13 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B52EC13FA77; Wed, 30 Nov 2005 00:56:12 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtir846o.fsf_-_@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12970>

Hi,

On Tue, 29 Nov 2005, Junio C Hamano wrote:

> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Johannes Schindelin, Mon, Nov 28, 2005 17:56:58 +0100:
> >> > if you're running Cygwin, wouldn't Cygwin's Perl make a lot more sense?
> >> 
> >> I thought so, too, but I guess there's a reason that Activision's perl was 
> >> used.
> >
> > the reason were incompatible scripts (notably, the ones expecting crlf).
> 
> I wonder why people keep saying Activision ;-).  Taken with my
> use of frotz and nitfol in the examples [*1*], somebody might
> confuse us with a group of old Infocom [*2*] fans.

Hey, you 0wn3d me there.
