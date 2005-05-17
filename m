From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: git-rev-list  in local commit order
Date: Tue, 17 May 2005 17:05:07 +0000
Organization: linutronix
Message-ID: <1116349507.17296.31.camel@tglx.tec.linutronix.de>
References: <4127.10.10.10.24.1116107046.squirrel@linux1>
	 <1116186533.11872.152.camel@tglx>
	 <4971.10.10.10.24.1116187076.squirrel@linux1>
	 <1116189873.11872.171.camel@tglx>
	 <1102.10.10.10.24.1116189916.squirrel@linux1>
	 <1116191636.11872.195.camel@tglx>
	 <1273.10.10.10.24.1116192097.squirrel@linux1>
	 <1116192629.11872.201.camel@tglx>
	 <1392.10.10.10.24.1116193437.squirrel@linux1>
	 <1116195235.11872.213.camel@tglx>
	 <1629.10.10.10.24.1116278725.squirrel@linux1>
	 <Pine.LNX.4.58.0505161638090.18337@ppc970.osdl.org>
	 <1116323520.17296.12.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0505170833330.18337@ppc970.osdl.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 19:36:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY5we-0007vj-IT
	for gcvg-git@gmane.org; Tue, 17 May 2005 19:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVEQRdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 13:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVEQRap
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 13:30:45 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21939
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261827AbVEQR32
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 13:29:28 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 3A5AD65C003;
	Tue, 17 May 2005 19:29:09 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 866BA282C9;
	Tue, 17 May 2005 19:05:04 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505170833330.18337@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-05-17 at 08:43 -0700, Linus Torvalds wrote:
> > My idea of repository id was not the notion of workspace seperation. I
> > dont care in which directory and on which machine you or who ever
> > commits a line of code. I care where the change appears in a public
> > repository, which is unique.
> 
> You seem to think that the repository on master.kernel.org is more 
> important than the one on my private machine, and you're _wrong_.

For me yes, as I have no access to your private ones and I can only rely
on the integrity of the public accessible ones.

For the individual developer the private workspaces are surely more
important. I never doubted that, but I do not care whether you use one
or ten workspaces and which one of them you blow away or use for
updating of master.kernel.org. 

tglx


