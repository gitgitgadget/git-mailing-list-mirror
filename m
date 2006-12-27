From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: What's in git.git (stable)
Date: Tue, 26 Dec 2006 17:19:03 -0800 (PST)
Message-ID: <368927.59162.qm@web31804.mail.mud.yahoo.com>
References: <7vd566ciwq.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 27 02:19:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzNRu-0004PV-DQ
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 02:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875AbWL0BTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 20:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbWL0BTF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 20:19:05 -0500
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:41386 "HELO
	web31804.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932875AbWL0BTF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Dec 2006 20:19:05 -0500
Received: (qmail 60753 invoked by uid 60001); 27 Dec 2006 01:19:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=0zGAqEI7kStWQ3oghPEYaLMGoFPcYx/04srJwqTecXFcdz+6xFQnOzN0/CTZvPWsums7SzX+IuiUnXUHjfr4ko4ifTR55Vxl9iJm3fnNmDPOLEgVipXpQ54grNLRQR29nOTwLxvqjso8xcrh3N6i0NknHuDZWf1dn3ztmPWXrtI=;
X-YMail-OSG: _Kwt3EwVM1m4yVg3oQbFaQJ.qfmoEFKdRoYz7B9i
Received: from [71.84.31.238] by web31804.mail.mud.yahoo.com via HTTP; Tue, 26 Dec 2006 17:19:03 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd566ciwq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35442>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> >> I am not quite sure about that.  An old timer would work in a
> >> newly cloned repository after all, and what this "newbie
> >> protection" is breaking is not existing repositories but
> >> expectation from existing users.
> >
> > Hmm, "newbie protection" doesn't sound good.  It sounds like
> > "screw the old-timers and let's change well-established workflow".
> 
> As far as I am concerned, this is a topic already closed four
> days ago with commit fb8696d9.
> 
> Are you way too behind, are you rubbing it in, or am I
> hallucinating and fb8696d9 did not actually fix it?

I'm behind.  I'll pull and take a look at that commit.

    Luben
