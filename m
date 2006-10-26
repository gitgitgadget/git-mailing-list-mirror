X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] make =?ISO-8859-2?Q?index=2Dp=E2ck?= able to complete thin packs
Date: Thu, 26 Oct 2006 09:50:48 +0200
Organization: At home
Message-ID: <ehppbg$phq$1@sea.gmane.org>
References: <Pine.LNX.4.64.0610252323100.12418@xanadu.home> <7vr6wvr1ca.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 07:51:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30146>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd00r-0002Sj-By for gcvg-git@gmane.org; Thu, 26 Oct
 2006 09:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751932AbWJZHus convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 03:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWJZHus
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 03:50:48 -0400
Received: from main.gmane.org ([80.91.229.2]:60397 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1751932AbWJZHur (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 03:50:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd00Y-0002Nn-2W for git@vger.kernel.org; Thu, 26 Oct 2006 09:50:34 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 09:50:34 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 09:50:34 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

>=20
>     From: Nicolas Pitre <nico@cam.org>
>     Subject: =3D?UTF-8?Q?=3D5BPATCH_1=3D2F3=3D5D_make_index-p=3DC3=3D=
A2ck_able_to_comp?=3D
>      =3D?UTF-8?Q?lete_thin_packs?=3D
>=20
> Is this a new trick or something?

I see \hat{a} (or \^{a}) in "index-pack" (index-p=E2ck) in subject.
That said, git-am should understand QP with coding in mail headers.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

