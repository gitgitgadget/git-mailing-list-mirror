From: sean <seanlkml@sympatico.ca>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 15:10:30 -0400
Message-ID: <BAYC1-PASMTP051B8E0C784B7630DEBE35AEC00@CEZ.ICE>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 21:14:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUTkG-00051i-Nb
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 21:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWDNTON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 15:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWDNTON
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 15:14:13 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:14049 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751422AbWDNTOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 15:14:12 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 14 Apr 2006 12:14:11 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 2D5F5644C28;
	Fri, 14 Apr 2006 15:14:10 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060414151030.11c64730.seanlkml@sympatico.ca>
In-Reply-To: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 14 Apr 2006 19:14:12.0122 (UTC) FILETIME=[9CF0B7A0:01C65FF7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Apr 2006 02:31:36 -0700
Junio C Hamano <junkio@cox.net> wrote:

> * Message-ID: <Pine.LNX.4.64.0604111725590.14565@g5.osdl.org>
>   Colored diff? (Linus Torvalds)
> 
>   I am not opposed to it, but I'd like to do that internally if
>   we go this route.  Needs to wait "option parsing".  Also
>   Message-ID: <3536.10.10.10.24.1114117965.squirrel@linux1> is
>   slightly related to this.

Moving it internal sounds like a good idea.  Would you be open to
including the GIT_DIFF_PAGER option now anyway?   It has utility
beyond just color diffs.

Sean
