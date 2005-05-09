From: Brad Roberts <braddr@puremagic.com>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Mon, 9 May 2005 15:50:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0505091549210.2136-100000@bellevue.puremagic.com>
References: <20050509212842.GC15712@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	Git Mailing List <git@vger.kernel.org>,
	<darcs-devel@abridgegame.org>
X-From: git-owner@vger.kernel.org Tue May 10 00:44:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVGyc-0001mZ-QK
	for gcvg-git@gmane.org; Tue, 10 May 2005 00:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVEIWvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 18:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVEIWvA
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 18:51:00 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:48525 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261262AbVEIWux (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 18:50:53 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.4/8.13.4/Debian-1) with ESMTP id j49MoXMZ004073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 9 May 2005 15:50:33 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.4/8.13.4/Submit) with ESMTP id j49MoXwd004069;
	Mon, 9 May 2005 15:50:33 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050509212842.GC15712@pasky.ji.cz>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> >  - there's no way to have multiple simultaneous caches, short of
> >    hacking at the values of Git's global variables by hand.
>
> See the Brad Robert's patches of Apr 21. I've decided not to apply them
> since it appears a lot has changed since then and it would be some pain;
> but they may be a worthy starting point for a more up-to-date patch.
>
> --
> 				Petr "Pasky" Baudis

Since there's interest, I'll pull tip of your tree and re-do them.  I
haven't bothered todate since no one seemed interested.  Do you want them
piece meal like I did last time or just one big diff?

Later,
Brad

