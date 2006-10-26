X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] make =?ISO-8859-2?Q?index=2Dp=E2ck?= able to complete thin packs
Date: Thu, 26 Oct 2006 11:56:05 +0200
Organization: At home
Message-ID: <ehq0md$i44$2@sea.gmane.org>
References: <Pine.LNX.4.64.0610252323100.12418@xanadu.home> <7vr6wvr1ca.fsf@assigned-by-dhcp.cox.net> <ehppbg$phq$1@sea.gmane.org> <20061026091925.GD13780@diana.vm.bytemark.co.uk> <7vpscfo1z1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 09:56:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30173>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1xn-00070T-62 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423079AbWJZJzs convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 05:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423078AbWJZJzs
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:55:48 -0400
Received: from main.gmane.org ([80.91.229.2]:55735 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423079AbWJZJzq (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:55:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd1xV-0006yY-MC for git@vger.kernel.org; Thu, 26 Oct 2006 11:55:33 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 11:55:33 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 11:55:33 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>=20
>> On 2006-10-26 09:50:48 +0200, Jakub Narebski wrote:
>>
>>> That said, git-am should understand QP with coding in mail headers.
>>
>> I really hope it does, since I just patched StGIT to generate such
>> headers. (Out of pure vanity -- I don't want my name mangled!)
>=20
> Sorry for an earlier hiccup.

That said, I don't think that Nicolas Pitre wanted to have "index-p=E2c=
k"
in subject instead of "index-pack".
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

