From: Wolfgang Denk <wd@denx.de>
Subject: Re: cg-clone not fetching all tags?
Date: Sun, 30 Apr 2006 00:11:12 +0200
Message-ID: <20060429221112.4380F35288F@atlas.denx.de>
References: <20060429170542.GJ27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 30 00:11:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZxes-0007ln-93
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 00:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWD2WLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 18:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWD2WLO
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 18:11:14 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39591 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1750770AbWD2WLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 18:11:13 -0400
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id C5C4D71C6E;
	Sun, 30 Apr 2006 00:11:12 +0200 (CEST)
X-Auth-Info: Y6uI/BGkAJPR5EusE+c86d/CoUHonqUJ+LqabGkTsBw=
X-Auth-Info: Y6uI/BGkAJPR5EusE+c86d/CoUHonqUJ+LqabGkTsBw=
Received: from mail.denx.de (p54966E7A.dip.t-dialin.net [84.150.110.122])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id B23D491A88;
	Sun, 30 Apr 2006 00:11:12 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 5646B6D0112;
	Sun, 30 Apr 2006 00:11:12 +0200 (CEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 4380F35288F;
	Sun, 30 Apr 2006 00:11:12 +0200 (MEST)
To: Petr Baudis <pasky@suse.cz>
In-reply-to: Your message of "Sat, 29 Apr 2006 19:05:42 +0200."
             <20060429170542.GJ27689@pasky.or.cz> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19323>

Dear Petr,

in message <20060429170542.GJ27689@pasky.or.cz> you wrote:
> 
>   you need to run git-update-server-info every time you add or update a
> tag (or best every time you push). See the NOTES section of

I do this. Also, this does not seem to explain why  I  can  only  see
recent tags, but not old ones?

> cg-admin-setuprepo documentation for details on how to set it up to be
> called automagically at every push.

Actually I don't use push, but "cg-update" on the receiving  end.  Is
this a problem? 


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There's an old proverb that says just about whatever you want it to.
