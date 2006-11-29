X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 20:30:54 +0100
Organization: At home
Message-ID: <ekkn1u$mi9$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org> <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org> <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org> <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net> <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611291234350.9647@xanadu.home> <ekkir2$6fq$1@sea.gmane.org> <456DDB91.8080608@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 29 Nov 2006 19:30:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32660>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpV8Z-0002cE-UA for gcvg-git@gmane.org; Wed, 29 Nov
 2006 20:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967592AbWK2TaL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 14:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967591AbWK2TaL
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 14:30:11 -0500
Received: from main.gmane.org ([80.91.229.2]:30094 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S967592AbWK2TaI (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 14:30:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpV7h-0002O7-QI for git@vger.kernel.org; Wed, 29 Nov 2006 20:29:37 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 20:29:37 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 29 Nov 2006
 20:29:37 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Steven Grimm wrote:

> Jakub Narebski wrote:
>>
>> If "git commit -a" by default heresy ;-) was accepted, I'd rather it be via
>> configuration option.
> 
> So the newbie-friendly behavior should require learning how to edit a 
> configuration file, and the expert-friendly behavior should be the one 
> you get on your first out-of-the-box exposure to git?

Well, newbie friendly could be the default, while hacker friendly
(expert friendly) would require learning how to configure git
(there is actually no need to hand-edit configuration file, by the way).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

