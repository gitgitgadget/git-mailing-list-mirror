From: Christian Meder <chris@absolutegiganten.org>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Fri, 12 Aug 2005 01:09:53 +0200
Message-ID: <1123801793.17147.12.camel@localhost>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	 <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
	 <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
	 <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
	 <pan.2005.08.10.21.15.41.143251@smurf.noris.de>
	 <pan.2005.08.10.22.11.25.242201@smurf.noris.de>
	 <46a038f9050810155642bb5580@mail.gmail.com>
	 <20050810233953.GV28270@kiste.smurf.noris.de>
	 <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com>
	 <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org>
	 <E1E35vU-0004nP-JR@highlab.com>
	 <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org>
	 <E1E3IOG-0005HO-AK@highlab.com>
	 <Pine.LNX.4.58.0508111448090.3295@g5.osdl.org>
	 <E1E3LPr-0005fs-D5@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 01:11:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3MBy-00086T-LB
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 01:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVHKXK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 19:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVHKXK2
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 19:10:28 -0400
Received: from shadow.prohost.de ([216.71.84.228]:7595 "EHLO shadow.prohost.de")
	by vger.kernel.org with ESMTP id S932541AbVHKXK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 19:10:27 -0400
Received: from blue (p54A23224.dip0.t-ipconnect.de [84.162.50.36])
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j7BN9pF21103;
	Fri, 12 Aug 2005 01:09:51 +0200
To: Sebastian Kuzminsky <seb@highlab.com>
In-Reply-To: <E1E3LPr-0005fs-D5@highlab.com>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-08-11 at 16:20 -0600, Sebastian Kuzminsky wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> > Hands up people. Does anybody _use_ GNU interactive tools? None of this "I 
> > have a package" crap.
> 
> Obviously no one on the git list uses GNU Interactive Tools, or this
> problem would have been caught much sooner.
> 
> It's only when you release it into the wild that these kind of things
> get noticed.  If only it weren't for the fuc*ing users, man...

Hi,

I still have to meet somebody who actually ever used GNU Interactive
Tools.

I'd recommend to just conflict with GNU Interactive Tools and be done
with it.

1. It's an upstream decision by Linus
2. You are the maintainer of the package. Just take a stand and put the
bug reports in wontfix mode. 

Being a long time Debian maintainer I'd note that in Debian you've got
to take ownership to get things done.



			Christian 


-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)
