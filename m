X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 10:35:59 +0100
Organization: At home
Message-ID: <ekm8ig$usu$1@sea.gmane.org>
References: <45357CC3.4040507@utoronto.ca> <456E8147.9070304@gmx.net> <fcaeb9bf0611300101s51a53b75lc7e771b067ba6e33@mail.gmail.com> <200611300930.33537.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 30 Nov 2006 09:35:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 12
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32713>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpiJb-0008H3-Oq for gcvg-git@gmane.org; Thu, 30 Nov
 2006 10:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932875AbWK3Jeo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 04:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932934AbWK3Jeo
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 04:34:44 -0500
Received: from main.gmane.org ([80.91.229.2]:2778 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932875AbWK3Jen (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 04:34:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpiJE-0008A7-FQ for git@vger.kernel.org; Thu, 30 Nov 2006 10:34:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 10:34:24 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 10:34:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alan Chandler wrote:

> And if you are not sure which you have done then presumably you do what you do 
> now, or git commit -a or git commit -i as you need.

By the way, short option -i is not --index but --include (i.e. commit
both changes in index and files mentioned on command line). Perhaps -I?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

