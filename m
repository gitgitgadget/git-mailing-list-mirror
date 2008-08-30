From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Sat, 30 Aug 2008 09:24:26 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808300916510.28765@gandalf.stny.rr.com>
References: <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz>
 <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
 <20080828212346.GA27867@coredump.intra.peff.net> <06844986-44BF-4B82-A45F-0781B3513409@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Perry Wagle <wagle@cs.indiana.edu>,
	Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 15:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZQSu-0006b5-2C
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 15:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbYH3NYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 09:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYH3NYa
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 09:24:30 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:64121 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbYH3NYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 09:24:30 -0400
Received: from gandalf ([74.74.65.243]) by hrndva-omta06.mail.rr.com
          with ESMTP
          id <20080830132428.URGJ16835.hrndva-omta06.mail.rr.com@gandalf>;
          Sat, 30 Aug 2008 13:24:28 +0000
X-X-Sender: rostedt@gandalf.stny.rr.com
In-Reply-To: <06844986-44BF-4B82-A45F-0781B3513409@wincent.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94377>


On Fri, 29 Aug 2008, Wincent Colaiuta wrote:

> El 28/8/2008, a las 23:23, Jeff King escribi?:
> 
> > I don't think Junio is declaring success. In fact, I think he has sent
> > several messages saying (paraphrasing of course):
> > 
> > - this was obviously not done in the best manner possible, because of
> >   the number of people complaining
> 
> One thing we mustn't lose sight of is that the number of people complaining is
> that it is utterly insignificant compared to the seething hordes that have
> complained about the number of git- commands in /usr/bin over the years. We're
> talking about a dozen or so compared to hundreds. And the change is likely to
> save us from hundreds more in the future.

I have to admit, the first time I saw the git-<tab> result, my first 
reaction was WTF!  But given time, I became use to it, and actually 
_preferred_ the dash version.

So I belonged to both camps. I complained about all the dash options, and 
I also complained about the dash options going away ;-)

Grant you, my complaints were not loud, I just utter some grumbles to git 
developers that I knew.

Lets not look at the number of complaints, but the level each complaint 
is. My first reaction to the git-<tab><tab> was more of a shock than 
anything else. So my complaint was very short lived, like someone cutting 
me off on the highway.

But after getting use to the dash version, and having that go away, makes 
me need to retrain myself to do things another way. This feels more like 
losing a pet, and complaining about that. This is a much more painful 
change than having to live with hordes of git commands.

-- Steve
