X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 2 Nov 2006 12:03:31 +0100
Message-ID: <20061102110331.GJ20017@pasky.or.cz>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org> <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 11:03:44 +0000 (UTC)
Cc: hanwen@xs4all.nl, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4549CA6B.4090909@shadowen.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30717>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaMF-0002Q6-7N for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752833AbWKBLDd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbWKBLDd
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:03:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:61114 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752833AbWKBLDd (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:03:33 -0500
Received: (qmail 5783 invoked by uid 2001); 2 Nov 2006 12:03:31 +0100
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Dear diary, on Thu, Nov 02, 2006 at 11:37:31AM CET, I got a letter
where Andy Whitcroft <apw@shadowen.org> said that...
> The g prefix on the sha1 _fragment_ it to indicate that it is in fact
> a truncated sha1, not a complete one.

I think it's rather to indicate that it is a sha1 at all.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
