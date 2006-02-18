From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Support ancient systems
Date: Sat, 18 Feb 2006 01:14:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602180109480.525@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0602171517580.24274@wbgn013.biozentrum.uni-wuerzburg.de>
 <94fc236b0602170718t76e01204ib2b50e33eaa5eeaa@mail.gmail.com>
 <20060217170345.GB3468@ELSAMSW37164>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 01:14:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAFjp-00081t-KI
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 01:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWBRAOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 19:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWBRAOK
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 19:14:10 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:30176 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751038AbWBRAOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 19:14:09 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 98860146B78; Sat, 18 Feb 2006 01:14:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 8C11429BE;
	Sat, 18 Feb 2006 01:14:08 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1CEB3146B78; Sat, 18 Feb 2006 01:14:08 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Tim O'Callaghan <timo@dspsrv.com>
In-Reply-To: <20060217170345.GB3468@ELSAMSW37164>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16376>

Hi,

On Fri, 17 Feb 2006, Tim O'Callaghan wrote:

> On Fri, Feb 17, 2006 at 04:18:35PM +0100, Adrien Beau wrote:
> > On 2/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > I just got git to work on an Irix box. These are the changes I needed
> > > to apply. Maybe some of them are of use for other ancient systems... You
> > > know, I like ancient systems. And if I could get my hands on a VMS, I
> > > would try to get git to work on it, too ;-)
> > 
> > You can get free VMS accounts at the Deathrow Cluster:
> > http://deathrow.vistech.net/
> > 
> > If you're serious about using your account, you'll find that the admin
> > team is pretty supportive and friendly.
> 
> You should check out polarhome.com if you want a variety of platforms
> to muck about on, including IRIX, Plan 9, OpenVMS Vax, OpenVMS Alpha
> etc.
> 
> I work on VMS systems at the moment and i thought of attempting to
> port git for the hell of it. I decided not to bother for a variety of
> reasons, but mostly because it looked like too much work :)  

Well, I did not remember that VMS does not have a proper fork() call. So 
maybe it would be easier to port git to MinGW32 first...

BTW, my remark about VMS was more tongue-in-cheek than not...

Ciao,
Dscho
