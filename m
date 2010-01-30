From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:15:05 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001292122050.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 <7veil8iqnj.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
 <alpine.DEB.1.00.1001300312450.3749@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 30 04:15:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb3no-0004fZ-Vf
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 04:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab0A3DPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 22:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756223Ab0A3DPH
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 22:15:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44805 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220Ab0A3DPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 22:15:06 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX10094LID59IS0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 22:15:06 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.1001300312450.3749@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138434>

On Sat, 30 Jan 2010, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 29 Jan 2010, Nicolas Pitre wrote:
> 
> > With all due respects, I don't share Dscho's sentiment about Git's 
> > alleged non user-friendliness.
> 
> Of course you don't.  You are a Git oldtimer.  Probably you do not even 
> have much exposure to complete programming newbies.

Welllll... That depends.

If you mean people who, despite a CS degree, are still unable to figure 
out if some loop exit condition should be > or >= except by testing the 
compiled code and see if a crash occurs, then yes I do feel the pain of 
being exposed to such people way too often for my taste.  And frankly I 
just don't care if those people can't grok the Git UI.

Git is meant to be a tool for people performing a minimum of development 
tasks.  If those people can't grasp the Git UI and concepts with little 
effort then they're either 1) uninterested or 2) incompetent.  For the 
uninterested people there are GUIs out there.  And don't get me started 
on the incompetent ones.

And for the rest of the world, such as my boss, there is gitweb.

> Well, guess what.  I have.  And guess what even more: they are the 
> majority, not you and me.

Did you ever got them to use P4?  I'm convinced that learning how to use 
P4 for a Git user is way more painful than a P4 user to learn Git.  
Similarly for Arch or many other alternatives.

HG looks easier?  Sure.  But it isn't exactly as flexible and powerful 
as Git is though.  You prefer a less powerful but simpler tool? OK just 
go with HG then -- I have no problem with that.  Even SVN might be just 
what you need.  But if you prefer the power of Git then there is a price 
to pay for it.  Making Git simpler would inevitably reduces its power.

I hope newbies won't stay newbies all their life.  If the majority of 
all the people are newbies then no need to wonder why there is so much 
crap being produced by the computing industry then.  Learning isn't only 
a nasty thing that they force you to do at school and which you get over 
with once you escape from there.

Incidentally we've been getting more positive feedback than negative 
ones about Git from newbies on this list lately.  That might be because 
our UI, although still not perfect, improved quite a bit, and most 
probably because the documentation surrounding Git has improved 
tremendously too.


Nicolas
