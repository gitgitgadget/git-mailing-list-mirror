From: Sean <seanlkml@sympatico.ca>
Subject: Re: What's in git.git (part #2)
Date: Thu, 1 Jun 2006 07:26:37 -0400
Message-ID: <BAYC1-PASMTP03700A0D31613228040FADAE900@CEZ.ICE>
References: <7v64jli66m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 01 13:33:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FllQK-00077e-PS
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 13:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWFALdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 07:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWFALdE
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 07:33:04 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:31648 "EHLO
	BAYC1-PASMTP03.CEZ.ICE") by vger.kernel.org with ESMTP
	id S965199AbWFALdD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 07:33:03 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 1 Jun 2006 04:33:02 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 4E531644C28;
	Thu,  1 Jun 2006 07:33:01 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060601072637.9920c8c5.seanlkml@sympatico.ca>
In-Reply-To: <7v64jli66m.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 01 Jun 2006 11:33:03.0060 (UTC) FILETIME=[24B8E940:01C6856F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 01 Jun 2006 02:19:45 -0700
Junio C Hamano <junkio@cox.net> wrote:

>  - p4 importer (Sean Estabrooks) -- are people interested?

Junio,

There just won't be anywhere near the call for this as there is
for the cvs and svn importers.  Even so, a few people have expressed
interest and it has been used by the Sourcemage folks with some success.
Would you consider carrying this in contrib just so it has a home?

Sean
