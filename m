From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: Problem with cogito and Linux tree tags
Date: Thu, 02 Jun 2005 23:02:28 +0200
Message-ID: <429F73E4.1020502@gorzow.mm.pl>
References: <429F5FA5.2030306@gorzow.mm.pl> <429F6270.50009@gmail.com> <429F6591.8080005@gorzow.mm.pl> <429F69B6.4030806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 23:15:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddx0A-00018E-6h
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 23:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVFBVPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 17:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFBVOu
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 17:14:50 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:11176 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261231AbVFBVCU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 17:02:20 -0400
Received: (qmail 5468 invoked from network); 2 Jun 2005 21:02:15 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <holmsand@gmail.com>; 2 Jun 2005 21:02:15 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id 12665583D71;
	Thu,  2 Jun 2005 23:02:29 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: Dan Holmsand <holmsand@gmail.com>
In-Reply-To: <429F69B6.4030806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dan Holmsand wrote:

>
> $ git-cat-file tag 06f6d9e2f140466eeb41e494e14167f90210f89d
>
> which tells you that v2.6.12-rc5 is commit
> 2a24ab628aa7b190be32f63dfb6d96f3fb61580a
>
Ok.  This doesn't work too. That cogito version really works fine, but I
had that branch cloned from a local repository gotten from rsync and
probably that's the problem.
The tags weren't propagated, but they should be.

AstralStorm
