X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 13:10:21 +0100
Message-ID: <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	 <87slhcz8zh.wl%cworth@cworth.org>
	 <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	 <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	 <20061026101038.GA13310@coredump.intra.peff.net>
	 <877iyne4dm.fsf@alplog.fr>
	 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
	 <456B7C6A.80104@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 12:10:55 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HLbihiYyvSTnkpz0Fh7RP43hAM0HksLI0Y6jAQE/0azMxabku8NhwO31r//1MriO1c4KFYgGJnHTBXDNc6VPovZhLERA037KoJz3zmCgGypHavzUmkxJg2rSU7UHXb8Cr9qQ14h3HVsnC2jbYE8OTq5the/9Lv6bL4FwzlvDRX0=
In-Reply-To: <456B7C6A.80104@webdrake.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32514>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp1nJ-0000UR-AQ for gcvg-git@gmane.org; Tue, 28 Nov
 2006 13:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757795AbWK1MKX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 07:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757928AbWK1MKX
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 07:10:23 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:54515 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1757795AbWK1MKW
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 07:10:22 -0500
Received: by py-out-1112.google.com with SMTP id a29so1282121pyi for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 04:10:21 -0800 (PST)
Received: by 10.35.18.18 with SMTP id v18mr1441645pyi.1164715821611; Tue, 28
 Nov 2006 04:10:21 -0800 (PST)
Received: by 10.35.116.4 with HTTP; Tue, 28 Nov 2006 04:10:21 -0800 (PST)
To: "Joseph Wakeling" <joseph.wakeling@webdrake.net>
Sender: git-owner@vger.kernel.org

> Next question ... one of the reasons I started seriously thinking about
> git was that in the VCS comparison discussion, it was noted that git is
> a lot more flexible than bzr in terms of how it can track data (e.g. the
> git pickaxe command, although I understand that's not in the released
> version [1.4.4.1] yet?).


If this is blame/annotate,  this exists in bzr as well...

: [bagfors@zyrgelkwyt]$ ; bzr help blame
usage: bzr annotate FILENAME
aliases: ann, blame, praise

Show the origin of each line in a file.


