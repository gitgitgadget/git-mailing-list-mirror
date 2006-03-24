From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Fri, 24 Mar 2006 16:12:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603241609510.6002@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
 <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <44223B90.3040500@zytor.com>
 <1143128751.6850.35.camel@neko.keithp.com> <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
 <BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE> <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
 <20060323204825.GE30176@spearce.org> <7vslp84u43.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 16:13:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMnyN-0005zK-Qr
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 16:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWCXPNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 10:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWCXPNE
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 10:13:04 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:52126 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750802AbWCXPNB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 10:13:01 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id CD7A41D1E;
	Fri, 24 Mar 2006 16:12:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id C099CA51;
	Fri, 24 Mar 2006 16:12:57 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id A8FB11D1E;
	Fri, 24 Mar 2006 16:12:57 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslp84u43.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17922>

Hi,

On Thu, 23 Mar 2006, Junio C Hamano wrote:

> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I'm not trying to bash Windows users.  I'm just saying that there's
> > definately a large user base for SCMs such as CVS who just want
> > to check in the latest version of a file they have to maintain.
> > Many of these people are afraid of a command prompt.  Asking them
> > to install Cygwin just to check in a file is a difficult challenge.
> 
> Export your git repository via git-cvsserver and have them use
> TortoiseCVS.  Such "maintain the tip and that is the only thing
> what interest me" people do not even need to know the backend is
> git.

Now if I could only find a way to tell TortoiseCVS which CVS_SERVER to 
use...

Ciao,
Dscho
