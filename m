X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 11:12:17 -0800
Message-ID: <456DDB91.8080608@midwinter.com>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org> <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org> <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org> <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net> <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611291234350.9647@xanadu.home> <ekkir2$6fq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 19:12:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <ekkir2$6fq$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32659>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpUqt-0007Co-IL for gcvg-git@gmane.org; Wed, 29 Nov
 2006 20:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967572AbWK2TMN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 14:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967578AbWK2TMM
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 14:12:12 -0500
Received: from tater.midwinter.com ([216.32.86.90]:12234 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S967572AbWK2TMM (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 14:12:12 -0500
Received: (qmail 14841 invoked from network); 29 Nov 2006 19:12:10 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 29 Nov 2006 19:12:10
 -0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> If "git commit -a" by default heresy ;-) was accepted, I'd rather it be via
> configuration option.
>   

So the newbie-friendly behavior should require learning how to edit a 
configuration file, and the expert-friendly behavior should be the one 
you get on your first out-of-the-box exposure to git?

