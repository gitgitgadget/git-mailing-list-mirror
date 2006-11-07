X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Planned new release of git [was: Re: If merging that is really fast forwarding creates new commit]
Date: Tue, 07 Nov 2006 23:02:38 +0100
Organization: At home
Message-ID: <eiqvoh$ebd$1@sea.gmane.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org> <45503553.3020605@gmail.com> <Pine.LNX.4.64.0611070729370.3667@g5.osdl.org> <7vhcxb2b15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 7 Nov 2006 22:02:54 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31093>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhZ1e-00052s-0Q for gcvg-git@gmane.org; Tue, 07 Nov
 2006 23:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752532AbWKGWCb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 17:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbWKGWCb
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 17:02:31 -0500
Received: from main.gmane.org ([80.91.229.2]:46037 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752532AbWKGWCa (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 17:02:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GhZ1K-0004zT-Uz for git@vger.kernel.org; Tue, 07 Nov 2006 23:02:14 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 23:02:14 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 07 Nov 2006
 23:02:14 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> We haven't seen a new release from 'master' for about a month.
> I think the dust has settled already after two big topics
> (packed-refs, delta-offset-base) were merged into 'master' since
> v1.4.3, and it is now time to decide which topics that have been
> cooking in 'next' are the ones I want in v1.4.4.  Perhaps by the
> end of the week, I'll cut a v1.4.4-rc1 to start the pre-release
> stabilization process.  No new features nor enhancements on
> 'master' after that until v1.4.4 final.
 
Do I understand correctly that the work on not exploding downloaded
pack on fetch, but making it non-thin, and related work on archival
packs (not to be considered for repacking) is not considered ready
(and tested)?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

