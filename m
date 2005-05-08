From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: cg-log patches
Date: Sun, 8 May 2005 15:52:18 -0400 (EDT)
Message-ID: <2088.10.10.10.24.1115581938.squirrel@linux1>
References: <1742.10.10.10.24.1115573750.squirrel@linux1>
    <1115574136.9031.147.camel@pegasus>
    <1856.10.10.10.24.1115576809.squirrel@linux1>
    <1115578807.8949.12.camel@pegasus> <20050508191831.GD9495@pasky.ji.cz>
    <2014.10.10.10.24.1115580230.squirrel@linux1>
    <20050508192536.GE9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 21:47:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrjZ-0004cM-1e
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVEHTw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVEHTwt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:52:49 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:44498 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262815AbVEHTwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 15:52:19 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050508195218.ZRTL1623.simmts8-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 15:52:18 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j48JqHnp028295;
	Sun, 8 May 2005 15:52:17 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 15:52:18 -0400 (EDT)
In-Reply-To: <20050508192536.GE9495@pasky.ji.cz>
To: "Petr Baudis" <pasky@ucw.cz>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 8, 2005 3:25 pm, Petr Baudis said:

>>
>> cg-log -c -f -u petr
>>
>> or
>>
>> cg-log -uxpasky
>>
>> Sean
>
> That sounds great. Could you please post a patch against the current
> Cogito's cg-log?
>

Hey Petr,

Sorry it relies on other patches in a series.  If you're interested in
them they're available from:

http://git.homelinux.com/cogito

Actually, if you look you'll see I renamed the option -a and added help so
that it shows up on -h or --help.

Cheers,
Sean


