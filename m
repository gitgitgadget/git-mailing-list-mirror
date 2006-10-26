X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Thu, 26 Oct 2006 11:19:49 +0200
Organization: At home
Message-ID: <ehpuid$ch2$2@sea.gmane.org>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 09:19:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 23
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30161>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1Op-0000DC-WE for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752140AbWJZJT1 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 05:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWJZJT1
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:19:27 -0400
Received: from main.gmane.org ([80.91.229.2]:40620 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752137AbWJZJT0 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:19:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd1OW-0000B1-OT for git@vger.kernel.org; Thu, 26 Oct 2006 11:19:24 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 11:19:24 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 11:19:24 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> =A0 I did not hear any comments on the left-right stuff; perhaps
> =A0 it is not needed, or it is not useful as its current shape (it
> =A0 could be enhanced to say which starting commits each of the
> =A0 commit is reachable from, by borrowing much of show-branch
> =A0 code).

It looks reasonable, and useful.

> =A0 I looked at Pasky's "project forks" gitweb code, and while I
> =A0 liked it a lot (having a demonstration site repo.or.cz really
> =A0 helps), I read on #git log that Pasky himself was having
> =A0 doubt, so it is parked in "pu", not in "next".

Perhaps that's for the best.

By the way, Pasky, where one can find your changes to gitweb?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

