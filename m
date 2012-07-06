From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [RFC] l10n: de.po: translate 29 new messages
Date: Fri, 6 Jul 2012 21:18:29 +0200
Message-ID: <20120706191829.GA20919@m62s10.vlinux.de>
References: <1341335086-6767-1-git-send-email-ralf.thielow@gmail.com>
 <2021839.rMjHRWft8I@cs-pc>
 <CAN0XMO+R3+JiuHSZ0O46py2WbXVh8D2Z+f7t_xofsN6ZrFwnQQ@mail.gmail.com>
 <m28vf0aqb8.fsf@igel.home>
 <CAN0XMOJF8+iJqyiqvBxEHOVGMB17rPnO9Pnu29LY1fMDBopKGw@mail.gmail.com>
 <4FF72C70.1010202@drmicha.warpmail.net>
 <CAN0XMO+wz-2EGcX+KoLQLYDsG7Kz1T7YujxdJTUo1Yvqx=A4tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Stimming <stimming@tuhh.de>, trast@student.ethz.ch,
	jk@jk.gs, worldhello.net@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 21:18:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnE35-0007vt-F6
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 21:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938Ab2GFTSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 15:18:34 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:57893 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755814Ab2GFTSd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 15:18:33 -0400
Received: (qmail invoked by alias); 06 Jul 2012 19:18:31 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp069) with SMTP; 06 Jul 2012 21:18:31 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/YZM4F0lLYlF9kij7k3V9yWERHpNE5RG9/xI/i6x
	yTHBbgo/xIKl6n
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id A24D6EC010; Fri,  6 Jul 2012 21:18:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAN0XMO+wz-2EGcX+KoLQLYDsG7Kz1T7YujxdJTUo1Yvqx=A4tg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201139>

On Fri, Jul 06, 2012 at 08:58:21PM +0200, Ralf Thielow wrote:
> On Fri, Jul 6, 2012 at 8:20 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> > Ralf Thielow venit, vidit, dixit 05.07.2012 20:16:
> >>>>> Is "rebase" = "Neuaufbau"? My last thought on this wording was "rebase" =
> >>>>> "Umpflanzen".
> >>>
> >>> "Basisumbau"?
> >>>
> >>
> >> I have added both suggestions to the glossary that they don't get lost when
> >> we discuss about non-optimal and/or missing parts within the glossary.
> >
> > Not the base is being reconstructed, but what's on top of it. So,
> > "Basiswechsel" would be more appropriate.
> >
> 
> I agree with you. There is no question what it means, but what are
> the best german words for it.
> 
> > But: "Umpflanzen" is really a great term which stays within the context
> > of trees, roots and branches. Strictly speaking, "Umpflanzen" refers to
> > something you do at the root level. The corresponding action for
> > branches would be "Umpfropfen". I think that also conveys the effort
> > that is sometimes necessary ;)
> 
> "Neuaufbau": it contains the concept of rebase
> "Umpflanzen": it contains the concept of rebase
> "Umpfropfen": Actually, this word isn't familiar to me. It's a bit
> unusual, isn't it?
> (but it might contains the concept of rebase)
> 
> The whole point is that the user needs to know what it actually meant
> in git-context.
> If a user read "sie pflanzen gerade um" or "sie pfropfen gerade um", I
> don't think that
> this is the best solution. I haven't said that "sie bauen gerade neu
> auf" is the optimal one,
> for me it's better, though.
> 
> We really need to discuss (and thats indeed also an issue on other
> translation teams), which
> git (or SCM) related words we shouldn't translate at all.

I have to agree with this last sentence. Most of the git gui terms are really
not understandable to me (and even the team I introduced it too). The only way to 
actually "guess" what it means is by knowing the position of the buttons and then
getting the actual command from the position. 

AFAIK it makes no senes to translate terms like "commit" to "Abzeichen" like it is used
in git gui. I don't know *anybody* here in my IT business environment who uses this word
or even would guess what it means.  Everyone is used to the Denglisch Version "committen" 
or "einchecken".

But in case you insist of translating this word (which I wouldn't!!!),
may I toss in another suggestion: "Umsetzen"

-Peter
