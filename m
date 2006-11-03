X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-format-patch little gripe
Date: Sat, 04 Nov 2006 00:37:23 +0100
Organization: At home
Message-ID: <eigjql$ql$2@sea.gmane.org>
References: <7vwt6cbwzq.fsf@assigned-by-dhcp.cox.net> <20061103195253.9244.qmail@web31814.mail.mud.yahoo.com> <7v3b905fqi.fsf@assigned-by-dhcp.cox.net> <87velwupk6.wl%cworth@cworth.org> <20061103231647.GB6970@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 3 Nov 2006 23:40:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30899>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg8dx-0005Ih-FJ for gcvg-git@gmane.org; Sat, 04 Nov
 2006 00:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932500AbWKCXkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 18:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWKCXkJ
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 18:40:09 -0500
Received: from main.gmane.org ([80.91.229.2]:55942 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932500AbWKCXkH (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 18:40:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gg8dm-0005Gr-5C for git@vger.kernel.org; Sat, 04 Nov 2006 00:40:02 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 04 Nov 2006 00:40:02 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 04 Nov 2006
 00:40:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jeff King wrote:

> On Fri, Nov 03, 2006 at 02:35:05PM -0800, Carl Worth wrote:
> 
>> I mean, git show is fine for displaying something to just read it, but
>> if the results are to be fed back into git at some point, then
>> git-show is pretty useless, (throws away commit message, author,
>> timestamp, etc.).
> 
> Try
>   git-show --pretty=email
> or even
>   git-show --pretty=email --stat -p

YAUO, Yet Another Undocumented Option. ::sigh::

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

