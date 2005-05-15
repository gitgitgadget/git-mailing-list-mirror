From: Brad Roberts <braddr@puremagic.com>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Sun, 15 May 2005 13:10:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0505151309030.2136-100000@bellevue.puremagic.com>
References: <20050515194803.GI13024@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 15 22:10:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXPRR-0000G2-0F
	for gcvg-git@gmane.org; Sun, 15 May 2005 22:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVEOUKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 16:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEOUKd
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 16:10:33 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:42423 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261215AbVEOUK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 16:10:26 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.4/8.13.4/Debian-1) with ESMTP id j4FKA3u9014644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 15 May 2005 13:10:04 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.4/8.13.4/Submit) with ESMTP id j4FKA3Ip014640;
	Sun, 15 May 2005 13:10:03 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050515194803.GI13024@pasky.ji.cz>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Date: Sun, 15 May 2005 21:48:03 +0200
> From: Petr Baudis <pasky@ucw.cz>
> To: Junio C Hamano <junkio@cox.net>
> Cc: Brad Roberts <braddr@puremagic.com>,
>      Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
>      git@vger.kernel.org
> Subject: Re: Darcs-git: a few notes for Git hackers
>
> Dear diary, on Sun, May 15, 2005 at 09:25:06PM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> told me that...
> > >>>>> "BR" == Brad Roberts <braddr@puremagic.com> writes:
> >
> > >> I've merged some of the minor stuff for now.
> >
> > BR> Cool, though there appears to have been some objections. :)
> >
> > I do not have any problem with what the _patch_ does at all.  I
> > had more trouble in the process of how the patch appeared in
> > git-pb tree, and I still do.
> >
> > Please consider the revert request retracted.  Request to
> > forewarn people in the mailing list still stands.
>
> Well, it isn't like this was some huge large-scale change; the diff is
> quite small. Do you want me to announce _any_ identifier renames in
> advance on the mailing list? Or where should be the threshold? These
> were three renames of not-so-frequently used identifiers.

Additionally, all of these changes were posted originally on 4/22, this
was just a bring-forward of them as requested.

Later,
Brad

