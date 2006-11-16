X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 01:51:05 +0000 (UTC)
Message-ID: <ejgg69$bm7$3@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<20061115201227.GM7201@pasky.or.cz>
	<Pine.LNX.4.64.0611151524000.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Thu, 16 Nov 2006 01:52:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88-110-175-230.dynamic.dsl.as9105.com
User-Agent: pan 0.117 (We'll fly and we'll fall and we'll burn)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31540>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkWQ4-0000In-7G for gcvg-git@gmane.org; Thu, 16 Nov
 2006 02:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031064AbWKPBv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 20:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031061AbWKPBv5
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 20:51:57 -0500
Received: from main.gmane.org ([80.91.229.2]:41671 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031064AbWKPBv4 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 20:51:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkWPb-0000AE-Ri for git@vger.kernel.org; Thu, 16 Nov 2006 02:51:33 +0100
Received: from 88-110-175-230.dynamic.dsl.as9105.com ([88.110.175.230]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 02:51:31 +0100
Received: from wildfire by 88-110-175-230.dynamic.dsl.as9105.com with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16
 Nov 2006 02:51:31 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006 15:26:44 -0500, Nicolas Pitre wrote:

> On Wed, 15 Nov 2006, Petr Baudis wrote:
> 
>> On Wed, Nov 15, 2006 at 03:10:16AM CET, Junio C Hamano wrote:
>> > You have to admit both pull and fetch have been contaminated
>> > with loaded meanings from different backgrounds. I was talking
>> > about killing the source of confusion in the longer term by
>> > removing fetch/pull/push, so we are still on the same page.
>> 
>> How was/is fetch contaminated?
> 
> I think "fetch" is sane.  Its only problem is a missing symetrical 
> counterpart verb, like "get" and "put".

"throw" ?

But I think "I'll just 'throw' this set of patches at you" is a lot
harshers sounding than "I'll just 'push' this set of patches at you".

Anand
