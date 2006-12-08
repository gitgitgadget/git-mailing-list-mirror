X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/5] rerere: add the diff command
Date: Fri, 08 Dec 2006 13:07:26 +0100
Organization: At home
Message-ID: <elbkdl$og4$2@sea.gmane.org>
References: <20061205092126.GE27236@soma> <1165574977365-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 12:07:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33692>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GseVm-0003fJ-PD for gcvg-git@gmane.org; Fri, 08 Dec
 2006 13:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425463AbWLHMGJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 07:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938059AbWLHMGD
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 07:06:03 -0500
Received: from main.gmane.org ([80.91.229.2]:44969 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425446AbWLHMFl
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 07:05:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GseTq-0008MJ-75 for git@vger.kernel.org; Fri, 08 Dec 2006 13:05:30 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 13:05:30 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 13:05:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Eric Wong wrote:

> Sometimes I like to see what I'm recording resolutions for and
> what's changed during a resolution.
>=20
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
> =A0git-rerere.perl | =A0 =A07 +++++++
> =A01 files changed, 7 insertions(+), 0 deletions(-)

Documentation, please?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

