X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 9/n] gitweb: Better support for non-CSS aware web browsers
Date: Wed, 1 Nov 2006 14:38:44 +0100
Message-ID: <20061101133844.GG20017@pasky.or.cz>
References: <200610301953.01875.jnareb@gmail.com> <200611011433.22279.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 13:39:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611011433.22279.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30637>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfGIr-0006Gi-M0 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 14:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752211AbWKANiq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 08:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbWKANiq
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 08:38:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:25824 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752211AbWKANiq (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 08:38:46 -0500
Received: (qmail 3525 invoked by uid 2001); 1 Nov 2006 14:38:44 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Dear diary, on Wed, Nov 01, 2006 at 02:33:21PM CET, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> For people who want to use non-CSS aware browsers, like w3m, elinks, links
> text browsers, for looking at "blob" and "commitdiff"/"blobdiff" views
> of gitweb.

JFYI, ELinks supports CSS. (Well, not completely, but it does handle
white-space: pre.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
