From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: [RFC] Do we still need the git command?
Date: Fri, 23 Sep 2005 06:39:02 -0600
Message-ID: <E1EImpS-0000k7-Ew@highlab.com>
References: <72499e3b050923042466011c4f@mail.gmail.com> <46a038f905092304384d79d715@mail.gmail.com>
Cc: Robert Watson <robert.oo.watson@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 14:40:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EImqM-0001ks-QD
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 14:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVIWMiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 08:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVIWMiv
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 08:38:51 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:19372 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750948AbVIWMiu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 08:38:50 -0400
Received: from highlab.com ([67.165.222.77])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20050923123849014000s6u4e>; Fri, 23 Sep 2005 12:38:49 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1EImpS-0000k7-Ew; Fri, 23 Sep 2005 06:39:02 -0600
To: Martin Langhoff <martin.langhoff@gmail.com>
In-reply-to: <46a038f905092304384d79d715@mail.gmail.com> 
Comments: In-reply-to Martin Langhoff <martin.langhoff@gmail.com>
   message dated "Fri, 23 Sep 2005 23:38:31 +1200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9188>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > Pros:
> > (4) Do not conflict with GNU Interactive Tools.  Make the life of
> > Debian people easier.
> 
> +1! Anything to avoid yet another flamewar in debian-devel ;-) and it
> also shows some good manners towards a (mostly forgotten) but good
> project. The whole name conflict prompted me to install the GNU
> Interactive Tools and run it for a couple of days. Nifty little
> "midnight-commander" style utility.

I've been talking with the Debian maintainer of GNU Interactive Tools
about this.  He says he's agreed with his upstream maintainer to change
the name of their git.  I dont know if he means they'll change their
name in the upstream package or just in the Debian package.  I offered
to do the work for them and do an NMU, but then I havent heard from them
for about 2 weeks, so I'm not sure what their status is.

"Ha ha, we sure bullied them into doing it our way."


-- 
Sebastian Kuzminsky
