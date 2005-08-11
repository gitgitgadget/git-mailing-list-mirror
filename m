From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 22:15:58 +0200
Message-ID: <20050811201558.GA2874@mars.ravnborg.org>
References: <pan.2005.08.10.21.15.41.143251@smurf.noris.de> <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 22:14:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3JQ7-0002Il-D6
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 22:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVHKUMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVHKUMl
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 16:12:41 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:11313 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932328AbVHKUMl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 16:12:41 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id 50B9A262853;
	Thu, 11 Aug 2005 22:12:33 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id EEA8C6AC01D; Thu, 11 Aug 2005 22:15:58 +0200 (CEST)
To: Sebastian Kuzminsky <seb@highlab.com>
Content-Disposition: inline
In-Reply-To: <E1E3IOG-0005HO-AK@highlab.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 
> Anyway, enough of this.  I understand the name will not change and I'm
> ok with that.  I'll deal with it on our (Debian's) end.

The easy fix is to kill the small git script that is not
mandatory anyway (as far as my quick grep told me).

The cg script has a bit more value.

	Sam
