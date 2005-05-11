From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 19:45:30 -0400 (EDT)
Message-ID: <3004.10.10.10.24.1115855130.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx>  <428291CD.7010701@zytor.com>
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:38:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW0mB-0002ML-CY
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVEKXpf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 19:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVEKXpf
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 19:45:35 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:42371 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261325AbVEKXpb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 19:45:31 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050511234530.SKKE19200.simmts12-srv.bellnexxia.net@linux1>;
          Wed, 11 May 2005 19:45:30 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4BNjSeD004472;
	Wed, 11 May 2005 19:45:30 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 11 May 2005 19:45:30 -0400 (EDT)
In-Reply-To: <428297DB.8030905@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 7:40 pm, H. Peter Anvin said:

> I can tell you what would happen in at least my case: you'll see each
> "repository" with about 23 different IDs.
>

Amongst other issues and complexity this will introduce.   This is really
a solution in search of a problem anyway.

Sean


