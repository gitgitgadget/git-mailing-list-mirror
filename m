From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 12:08:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk> 
 <b0943d9e0511160311k725526d8v@mail.gmail.com>  <7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
  <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
 <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 12:09:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Echd2-0002jX-QP
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 12:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVKQLIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 06:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVKQLIW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 06:08:22 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19621 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750748AbVKQLIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 06:08:21 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BABA713FAEE; Thu, 17 Nov 2005 12:08:20 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 98341B5220; Thu, 17 Nov 2005 12:08:20 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 74A7EB5145; Thu, 17 Nov 2005 12:08:20 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3FF8F13FAEE; Thu, 17 Nov 2005 12:08:20 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12099>

Hi,

On Thu, 17 Nov 2005, Alex Riesen wrote:

> On 11/17/05, Junio C Hamano <junkio@cox.net> wrote:
> > Along with the git wrapper fixes and git-apply bugfix (it did
> 
> cygwin is completely broken. Still debugging, but it looks like the
> old "windows can't unlink/rename open files" problem.

FWIW I had no problems on cygwin (NO_MMAP=YesPlease).

Ciao,
Dscho
