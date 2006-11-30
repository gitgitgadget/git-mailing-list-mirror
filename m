X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Raimund Bauer <ray007@gmx.net>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 07:59:19 +0100
Message-ID: <456E8147.9070304@gmx.net>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>	<456C7592.6020700@ableton.com>	<ekhtnt$rkk$1@sea.gmane.org>	<456C9DFF.1040407@onlinehome.de>	<456CA981.4010808@onlinehome.de>	<Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>	<456CB197.2030201@onlinehome.de>	<Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>	<Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611290922410.3513@woody.osdl.org>	<456DD76C.4010902@gmx.net>	<Pine.LNX.4.64.061129
 1235590.3513@woody.osdl.org> <87bqmpvlxf.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 06:59:40 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #20693823
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.8) Gecko/20061025 Thunderbird/1.5.0.8 Mnenhy/0.7.4.0
In-Reply-To: <87bqmpvlxf.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32705>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpftL-0005ya-7C for gcvg-git@gmane.org; Thu, 30 Nov
 2006 07:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758365AbWK3G71 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 01:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758397AbWK3G71
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 01:59:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:18372 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758394AbWK3G70 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 01:59:26 -0500
Received: (qmail invoked by alias); 30 Nov 2006 06:59:22 -0000
Received: from p54988C4F.dip0.t-ipconnect.de (EHLO [127.0.0.1])
 [84.152.140.79] by mail.gmx.net (mp035) with SMTP; 30 Nov 2006 07:59:22 +0100
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

* Carl Worth wrote, On 30.11.2006 01:05:
> Let's help people do exactly that by making the behavior of "git
> commit -a" be the default for "git commit".
>   
Maybe we could do that _only_ if the index matches HEAD, and otherwise 
keep current behavior?
So people who don't care about the index won't get tripped up, and when 
you do have a dirty index, you get told about it?
> -Carl
-- 

best regards

  Ray


