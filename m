From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Fri, 29 Jul 2005 09:37:39 +0200
Message-ID: <20050729073739.GC5680@kiste.smurf.noris.de>
References: <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <20050722205948.GE11916@pasky.ji.cz> <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <20050728155210.GA17952@pasky.ji.cz> <42E9020F.3080302@gmail.com> <pan.2005.07.28.19.25.39.562903@smurf.noris.de> <20050729072157.GD24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Fri Jul 29 09:41:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyPTq-0004zD-15
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 09:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVG2Hjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 03:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVG2Hju
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 03:39:50 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:9157 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262483AbVG2His convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 03:38:48 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DyPRA-0001gB-Od
	for git@vger.kernel.org; Fri, 29 Jul 2005 09:38:03 +0200
Received: (nullmailer pid 22489 invoked by uid 501);
	Fri, 29 Jul 2005 07:37:39 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050729072157.GD24895@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Petr Baudis:
> Dear diary, on Thu, Jul 28, 2005 at 09:25:45PM CEST, I got a letter
> where Matthias Urlichs <smurf@smurf.noris.de> told me that...
> > Hi, A Large Angry SCM wrote:
> > 
> > > So you're arguing for "last match wins" versus "first match wins". I, 
> > > personally, find the former more natural and easier to debug by hand.
> > 
> > You know, up until five minutes ago, I thought so too.
> 
> So is the Large Angry SCM agreeing with me or not? I wrote long reply to
> his mail, then reread what he wrote again, and decided that he is
> _agreeing_ with me and you that "last match wins" is better. :-)
> 
Bah, I misparsed his sentence (I read "former" as "first wins"), otherwise
my reply would have been worded slightly differently.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"All these black people are screwing up my democracy." - Ian Smith
