X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 11:05:26 +0100
Organization: At home
Message-ID: <ejeomr$vrj$2@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz> <87d57pu4qa.wl%cworth@cworth.org> <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net> <20061115040852.GL7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 15 Nov 2006 10:05:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31428>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkHdT-0005tr-8k for gcvg-git@gmane.org; Wed, 15 Nov
 2006 11:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966733AbWKOKEs convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 05:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966734AbWKOKEs
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 05:04:48 -0500
Received: from main.gmane.org ([80.91.229.2]:41871 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966733AbWKOKEr (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 05:04:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkHd4-0005nj-E2 for git@vger.kernel.org; Wed, 15 Nov 2006 11:04:27 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 11:04:26 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 15 Nov 2006
 11:04:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:

> =A0 (i) Clearly divided porcelain/plumbing interface, so that you can
> really isolate the two UI-wise; endless confusion reigns there now. I=
s
> git-update-index porcelain or plumbing? _You_ call git-merge a proper
> porcelain? From my perspective, git-update-ref is as plumbing as it
> gets, but it's classified as porcelain. Etc, etc. This would be by fa=
r
> the most important advantage.

The problem is that one man's plumbing is another man porcelain.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

