X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Creating new repos
Date: Sat, 28 Oct 2006 16:19:05 +0200
Organization: At home
Message-ID: <ehvor7$20j$1@sea.gmane.org>
References: <pasky@suse.cz> <200610271708.k9RH8thM022812@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 28 Oct 2006 14:19:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30378>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdp1l-00022v-Ff for gcvg-git@gmane.org; Sat, 28 Oct
 2006 16:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752222AbWJ1OTJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006 10:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbWJ1OTJ
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 10:19:09 -0400
Received: from main.gmane.org ([80.91.229.2]:55212 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752222AbWJ1OTI (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 10:19:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gdp12-0001qz-D2 for git@vger.kernel.org; Sat, 28 Oct 2006 16:18:28 +0200
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 16:18:28 +0200
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 28 Oct 2006
 16:18:28 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Horst H. von Brand wrote:
> Petr Baudis <pasky@suse.cz> wrote:
>> Dear diary, on Fri, Oct 27, 2006 at 02:29:10PM CEST, I got a letter
>> where "Horst H. von Brand" <vonbrand@inf.utfsm.cl> said that...

>>> =A0 git://git-server/user/Test.git
>>> =A0 ssh+git://git-server/var/scm/user/Test.git
>>>=20
>>> Is this intentional?
>>=20
>> git+ssh has nothing to do with git-daemon, it's executing other git
>> commands remotely.
>=20
> OK. But from an UI POW it is confusing.

You can use ssh:// instead of ssh+git:// if you like. ssh+git:// is to =
note
that you should use git for that...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

