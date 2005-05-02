From: Alexander Beyn <malex-git@fatelectrons.org>
Subject: Re: cg-log -r?
Date: Sun, 1 May 2005 17:16:18 -0700
Message-ID: <20050502001618.GA2035@fatelectrons.org>
References: <20050502000019.GA1644@fatelectrons.org> <20050502000447.GF974@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 02:10:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSOVu-0008RY-L0
	for gcvg-git@gmane.org; Mon, 02 May 2005 02:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVEBAQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 20:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVEBAQV
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 20:16:21 -0400
Received: from adsl-66-51-204-13.dslextreme.com ([66.51.204.13]:61413 "EHLO
	mail.fatelectrons.org") by vger.kernel.org with ESMTP
	id S261501AbVEBAQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 20:16:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.fatelectrons.org (Postfix) with ESMTP id 2FA2510FE2A0;
	Sun,  1 May 2005 17:16:19 -0700 (PDT)
Received: from mail.fatelectrons.org ([127.0.0.1])
 by localhost (hmm [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02045-01; Sun,  1 May 2005 17:16:18 -0700 (PDT)
Received: by mail.fatelectrons.org (Postfix, from userid 1000)
	id E8B9810FE291; Sun,  1 May 2005 17:16:18 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050502000447.GF974@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new at fatelectrons.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 02:04:47AM +0200, Petr Baudis wrote:
> Dear diary, on Mon, May 02, 2005 at 02:00:19AM CEST, I got a letter
> where Alexander Beyn <malex-git@fatelectrons.org> told me that...
> > I created it because I could never remember if cg-log or cg-diff requires 
> > the -r before the revs.
> 
> Actually, would you people hate me / Cogito / Richard Stallman if I
> added -r to cg-log and cg-mkpatch, for the sake of consistency?
> Extending cg-log to work on individual files would be then obvious.
> 

I'd welcome this change, but I still like the ubiquitous -h and --help
on all the commands

Alexander
