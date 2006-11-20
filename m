X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Document git-runstatus
Date: Mon, 20 Nov 2006 09:11:48 +0100
Organization: At home
Message-ID: <ejrntd$kj$1@sea.gmane.org>
References: <455F1595.9020009@lsrfire.ath.cx> <20061118092644.a9f15669.seanlkml@sympatico.ca> <20061118143511.GM7201@pasky.or.cz> <455F210B.8000107@lsrfire.ath.cx> <BAYC1-PASMTP06C814AB518D7544770C01AEEF0@CEZ.ICE> <455F4F06.3090902@gmail.com> <BAYC1-PASMTP06DE3E6CFF9E49C2BF16C7AEEF0@CEZ.ICE> <455F60EA.2080009@gmail.com> <20061118150431.81076072.seanlkml@sympatico.ca> <20061119181307.GY7201@pasky.or.cz> <20061120071529.GF3315@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 20 Nov 2006 08:10:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31885>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm4El-0007D9-A0 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 09:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933829AbWKTIKk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 03:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933994AbWKTIKk
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 03:10:40 -0500
Received: from main.gmane.org ([80.91.229.2]:39058 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933829AbWKTIKj (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 03:10:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gm4EZ-0007AF-6W for git@vger.kernel.org; Mon, 20 Nov 2006 09:10:31 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 09:10:31 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 20 Nov 2006
 09:10:31 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Joshua N Pritikin wrote:

> On Sun, Nov 19, 2006 at 07:13:08PM +0100, Petr Baudis wrote:
>> BTW, I've finally found a fine example of situation parallel to Git:
>> TeX!  There are the core TeX commands (plumbing) and plain TeX (basic
>> porcelain) on top of that as well as a bunch of other macro sets (other
>> porcelains). Now I need to dig out The TeXbook from wherever I've put it
>> to see how did Knuth deal with it, documentation-wise.
> 
> Gahh! Please don't use TeX as an example. As far as I know, TeX doesn't 
> offer lexical scope. 

It offers grouping.

> Hence, action-at-a-distance is commonplace which  
> makes program execution extremely difficult for mere mortals to 
> predict. I am constantly amazed at popularity of TeX, in spite of its 
> grave deficiencies. Perhaps there isn't a good alternative yet.

TeX (even plain TeX) is like assembler of programming languages. One does
usually use one of the TeX macros sets, like LaTeX, ConTeXt or texinfo.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

