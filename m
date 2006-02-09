From: sean <seanlkml@sympatico.ca>
Subject: Re: What's in git.git
Date: Thu, 9 Feb 2006 03:09:05 -0500
Message-ID: <BAYC1-PASMTP1142DA49F5BC7B7B42B22FAE030@CEZ.ICE>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 09:42:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F77Ns-0007rb-6d
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 09:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWBIImS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 03:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWBIImS
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 03:42:18 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:39987 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S965173AbWBIImR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 03:42:17 -0500
X-Originating-IP: [65.94.251.146]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.251.146]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 9 Feb 2006 00:44:28 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id CDC48644C28;
	Thu,  9 Feb 2006 03:09:20 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060209030905.319f2e48.seanlkml@sympatico.ca>
In-Reply-To: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.11; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 Feb 2006 08:44:29.0218 (UTC) FILETIME=[0A231820:01C62D55]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 08 Feb 2006 22:47:54 -0800
Junio C Hamano <junkio@cox.net> wrote:


> One *major* change I am thinking about doing is to change my
> workflow a bit.  So far, the proposed updates branch "pu" was
> almost impossible to follow unless you are really a devoted git
> developer, because it is always rebased to the latest master and
> then topic branches are merged onto it.  While that keeps the
> number of unnecessary merge nodes between master and pu to the
> minimum, it actively discouraged for the branch to be followed
> by developers.

I've always followed it okay by just using "git branch -d pu" each time 
before pulling from you.   Your "next" branch does sound like an 
improvement though.

Sean
