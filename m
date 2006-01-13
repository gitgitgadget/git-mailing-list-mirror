From: sean <seanlkml@sympatico.ca>
Subject: Re: Recursive remove
Date: Fri, 13 Jan 2006 12:56:04 -0500
Message-ID: <BAYC1-PASMTP08F3875A7636E18401E7B3AE260@CEZ.ICE>
References: <20060113132119.GB23655@ebar091.ebar.dtu.dk>
	<7virso9ggd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: s022018@student.dtu.dk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 19:01:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExTE0-0000v6-QG
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 19:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422754AbWAMSAa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 13:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422759AbWAMSAa
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 13:00:30 -0500
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:28513 "EHLO
	BAYC1-PASMTP08.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1422754AbWAMSA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 13:00:29 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP08.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 13 Jan 2006 10:02:06 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 94379644C23;
	Fri, 13 Jan 2006 13:00:27 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060113125604.4ec91466.seanlkml@sympatico.ca>
In-Reply-To: <7virso9ggd.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 Jan 2006 18:02:07.0031 (UTC) FILETIME=[7764F470:01C6186B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 13 Jan 2006 09:37:54 -0800
Junio C Hamano <junkio@cox.net> wrote:

> 
> 	$ rm -fr Some/Dir; git commit -a -m 'Remove'
> 
> perhaps?
> 

Sigh, its been a humbling morning all around; can't get easier than that.

Sean
