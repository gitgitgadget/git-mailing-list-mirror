X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 14:32:03 +0100
Organization: At home
Message-ID: <ejkdhv$vog$2@sea.gmane.org>
References: <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <20061116011411.GB10512@thunk.org> <7vd57of2cv.fsf@assigned-by-dhcp.cox.net> <8764dflj5o.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 17 Nov 2006 13:31:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31697>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl3oC-0007pZ-DZ for gcvg-git@gmane.org; Fri, 17 Nov
 2006 14:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162320AbWKQNbE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 08:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162330AbWKQNbE
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 08:31:04 -0500
Received: from main.gmane.org ([80.91.229.2]:47801 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162320AbWKQNbD (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 08:31:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gl3nz-0007nj-EA for git@vger.kernel.org; Fri, 17 Nov 2006 14:30:56 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 14:30:55 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17 Nov 2006
 14:30:55 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alexandre Julliard wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
>> I would rather say "use 'git branch' to make sure if you are
>> ready to merge".  Who teaches not to use "git pull"?
> 
> We do that for Wine. The problem is that we recommend using git-rebase
> to make it easier for occasional developers to keep a clean history,
> and rebase and pull interfere badly.

What about proposed (and I think not accepted) merge strategy
"rebase" (formerly called "subordinate" or something like that)?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

