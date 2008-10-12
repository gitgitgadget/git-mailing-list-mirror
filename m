From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 10:59:27 -0700
Message-ID: <20081012175927.GB4856@spearce.org>
References: <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com> <20081012152427.GA4607@elte.hu> <20081012153952.GV10544@machine.or.cz> <20081012165954.GA2317@elte.hu> <m3tzbhk94k.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ingo Molnar <mingo@elte.hu>, Petr Baudis <pasky@suse.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 20:01:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp5GA-0007sG-Mm
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 20:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbYJLR72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 13:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbYJLR72
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 13:59:28 -0400
Received: from george.spearce.org ([209.20.77.23]:60356 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbYJLR72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 13:59:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 50B8C3835F; Sun, 12 Oct 2008 17:59:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3tzbhk94k.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98039>

Jakub Narebski <jnareb@gmail.com> wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > Soapbox: in fact it would be outright stupid to limit the kernel 
> > source's availability artificially by not making HTTP a tier-one access 
> > method.
> 
> Hopefully there should soon be here "smart" HTTP server [...]
> 
> It is WIP, but I'm not sure how far it is from completion.

Its still not even prototyped.  I'm supposed to be spending my 20%
time at Google on the Git-in-HTTP documentation and implementation,
so I can feed patches to the list for review.

Sadly, my current 80% project has been demanding >120% of my time
these past 5 weeks, so I have not been able to touch the Git-in-HTTP
concept in that time period.

Most of my 80% project has to be wrapped up by this time next
week.  Afterwards I'm going to try and dedicate at least a week
to Git-in-HTTP and get caught up.  I sort of have to; its part of
my goals for my performance evaluation.  Even if the list winds
up rejecting my implementation, I still have to put it out there
for discussion.

-- 
Shawn.
