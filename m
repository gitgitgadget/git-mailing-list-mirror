From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Commit template
Date: Sun, 8 May 2005 16:06:31 -0400 (EDT)
Message-ID: <2159.10.10.10.24.1115582791.squirrel@linux1>
References: <1965.10.10.10.24.1115579256.squirrel@linux1> 
    <1115579764.8949.15.camel@pegasus> 
    <2003.10.10.10.24.1115580031.squirrel@linux1> 
    <1115580630.8949.27.camel@pegasus> 
    <2095.10.10.10.24.1115582244.squirrel@linux1>
    <1115582601.8949.31.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@ucw.cz>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 22:09:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUs58-0000YW-B8
	for gcvg-git@gmane.org; Sun, 08 May 2005 22:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbVEHUKh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 16:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVEHUJ2
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 16:09:28 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:46729 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262936AbVEHUGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 16:06:33 -0400
Received: from linux1 ([69.156.111.46]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050508200632.JHSV1834.simmts6-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 16:06:32 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j48K6V8G028572;
	Sun, 8 May 2005 16:06:31 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 16:06:31 -0400 (EDT)
In-Reply-To: <1115582601.8949.31.camel@pegasus>
To: "Marcel Holtmann" <marcel@holtmann.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 8, 2005 4:03 pm, Marcel Holtmann said:

> my argument is; not to mess up with the CG: lines created by cg-commit.
> If you wanna insert a warning then you can of course add additional CG:
> lines to the commit template.

Marcel,

Well, i'd argue that anyone making their own commit should be responsible
for making it look however they like.  Maybe they want to only use only 60
character wide lines and are tired of seeing the notice about CG: being
ignored.  Gives the power user a tad more flexibility.   But I really
don't care much either way.

Sean


