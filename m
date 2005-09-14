From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: dumb transports not being welcomed..
Date: Wed, 14 Sep 2005 04:25:16 +0200
Message-ID: <20050914022516.GA3379@vrfy.org>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net> <20050913211444.GA27029@mars.ravnborg.org> <7vacig1wrb.fsf@assigned-by-dhcp.cox.net> <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509131525250.26803@g5.osdl.org> <7vwtlkvbk0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509131554060.26803@g5.osdl.org> <7vpsrcvafm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 04:26:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFMxj-0002Ts-9C
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 04:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVINCZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 22:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVINCZV
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 22:25:21 -0400
Received: from soundwarez.org ([217.160.171.123]:38865 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S964979AbVINCZU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 22:25:20 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id D1E0859D83; Wed, 14 Sep 2005 04:25:16 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsrcvafm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8508>

On Tue, Sep 13, 2005 at 04:02:05PM -0700, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Tue, 13 Sep 2005, Junio C Hamano wrote:
> >> 
> >> Ah, no I didn't.  For future reference, how can I find that kind
> >> of thing myself (not "what was not in 0.99.4", but "what did
> >> kernel.org run a week ago")?
> >
> > I don't know. Hpa did an announcement when kernel.org switched to 0.99.4, 
> > but I never saw any announcement of upgrades (I only noticed that the date 
> > on /usr/bin/git is now Sep 7 a coupld of days ago - no proof of upgrade, 
> > but _something_ happened six days ago ;)
> 
> Thanks, that much I could have figured out myself.

That's easier:

  $ rpm -q git-core
  git-core-0.99.6-1

  $ rpm -q cogito
  cogito-0.14-1

Kay
