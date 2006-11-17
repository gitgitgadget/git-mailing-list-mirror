X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 17:49:46 +0100
Message-ID: <87y7qahvbp.fsf@wine.dyndns.org>
References: <87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<20061116011411.GB10512@thunk.org>
	<7vd57of2cv.fsf@assigned-by-dhcp.cox.net>
	<8764dflj5o.fsf@wine.dyndns.org> <ejkdhv$vog$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 16:51:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ejkdhv$vog$2@sea.gmane.org> (Jakub Narebski's message of "Fri\, 17 Nov 2006 14\:32\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31709>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl6ur-0006Dz-28 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 17:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755699AbWKQQtv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 11:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755703AbWKQQtv
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 11:49:51 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:50856 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S1755699AbWKQQtu
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 11:49:50 -0500
Received: from adsl-89-217-154-39.adslplus.ch ([89.217.154.39]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1Gl6uT-0003xd-D7; Fri, 17
 Nov 2006 10:49:49 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id CA26710A151; Fri,
 17 Nov 2006 17:49:46 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Alexandre Julliard wrote:
>
>> Junio C Hamano <junkio@cox.net> writes:
>> 
>>> I would rather say "use 'git branch' to make sure if you are
>>> ready to merge".  Who teaches not to use "git pull"?
>> 
>> We do that for Wine. The problem is that we recommend using git-rebase
>> to make it easier for occasional developers to keep a clean history,
>> and rebase and pull interfere badly.
>
> What about proposed (and I think not accepted) merge strategy
> "rebase" (formerly called "subordinate" or something like that)?

That sounds very interesting. Has it ever been implemented, or only
discussed?

-- 
Alexandre Julliard
