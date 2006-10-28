X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Generating docu in 1.4.3.3.g01929
Date: Sat, 28 Oct 2006 02:07:39 -0400
Message-ID: <BAYC1-PASMTP060BC6AED24731185AD6E5AE050@CEZ.ICE>
References: <20061027154433.da9b29d7.seanlkml@sympatico.ca>
	<200610272312.k9RNCo2Q002623@laptop13.inf.utfsm.cl>
	<BAYC1-PASMTP04E0376BEE45F9A676DB03AE050@CEZ.ICE>
	<7vr6wt9enk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 28 Oct 2006 06:07:52 +0000 (UTC)
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061028020739.e667f67f.seanlkml@sympatico.ca>
In-Reply-To: <7vr6wt9enk.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Oct 2006 06:10:56.0203 (UTC) FILETIME=[D49151B0:01C6FA57]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdhMB-0002Uo-1O for gcvg-git@gmane.org; Sat, 28 Oct
 2006 08:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751852AbWJ1GHm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 02:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWJ1GHm
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 02:07:42 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:49542 "EHLO
 BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1751852AbWJ1GHl (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006
 02:07:41 -0400
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Fri, 27 Oct 2006 23:10:55 -0700
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GdgPz-0007LE-8G; Sat, 28 Oct 2006 01:07:39 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 27 Oct 2006 22:45:51 -0700
Junio C Hamano <junkio@cox.net> wrote:

> Eh, do you mean bisecting asciidoc?  I am not seeing the problem
> with these on a freshly installed FC6:
> 

Yeah.. don't see the problem here either.  But assuming there
is some strange interaction with Horst's environment, bisecting
would narrow it down.  Even though I don't really think bisecting
will turn up a problem in Git, it might identify the problem in
the environment.. 

