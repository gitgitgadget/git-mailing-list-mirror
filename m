From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Add cg-printenv command.
Date: Sun, 8 May 2005 23:40:25 -0400 (EDT)
Message-ID: <2970.10.10.10.24.1115610025.squirrel@linux1>
References: <200505081911.10371.elenstev@mesatop.com>
    <1115601540.8949.104.camel@pegasus>
    <7vpsw115v0.fsf@assigned-by-dhcp.cox.net>
    <200505082125.28521.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Marcel Holtmann" <marcel@holtmann.org>,
	"Petr Baudis" <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 05:33:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUz1b-0001O9-Kv
	for gcvg-git@gmane.org; Mon, 09 May 2005 05:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbVEIDkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 23:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263034AbVEIDkg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 23:40:36 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:60558 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263033AbVEIDka (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 23:40:30 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050509034025.CQJY1623.simmts8-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 23:40:25 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j493eMor031983;
	Sun, 8 May 2005 23:40:23 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 23:40:25 -0400 (EDT)
In-Reply-To: <200505082125.28521.elenstev@mesatop.com>
To: "Steven Cole" <elenstev@mesatop.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 8, 2005 11:25 pm, Steven Cole said:

> I had intended it only as a quick check by an end-user before doing
> a commit that the values had been set as desired.

Hey Steven,

Rather than creating a separate command, perhaps the values could
automatically be added to the initial commit message in a few "CG:" lines?

Sean


