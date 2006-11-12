X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Shallow clone [Was Re: What's in git.git ]
Date: Sun, 12 Nov 2006 14:12:09 +0100
Message-ID: <20061112131209.GC7201@pasky.or.cz>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz> <45520872.3090506@gmail.com> <45521AE9.7050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 13:12:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45521AE9.7050902@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31259>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjF8J-0000O4-5F for gcvg-git@gmane.org; Sun, 12 Nov
 2006 14:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755095AbWKLNMM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 08:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755096AbWKLNMM
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 08:12:12 -0500
Received: from w241.dkm.cz ([62.24.88.241]:7339 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755094AbWKLNML (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 08:12:11 -0500
Received: (qmail 1587 invoked by uid 2001); 12 Nov 2006 14:12:09 +0100
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

On Wed, Nov 08, 2006 at 06:59:05PM CET, Aneesh Kumar K.V wrote:
> diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
> index 275d18b..03a6f77 100644
> --- a/Documentation/repository-layout.txt
> +++ b/Documentation/repository-layout.txt
> @@ -141,3 +141,9 @@ logs/refs/heads/`name`::
>  
>  logs/refs/tags/`name`::
>  	Records all changes made to the tag named `name`.
> +
> +shallow::

Hmm, shouldn't the shallow file rather belong to the info/ subdirectory?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
