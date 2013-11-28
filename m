From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 21:54:16 +0000 (UTC)
Message-ID: <loom.20131128T225302-989@post.gmane.org>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com> <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com> <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com> <CALUzUxrEvuKuN+v-hJLQd5KoV-fzxVYvg5pj7XoLBVap7mgA=Q@mail.gmail.com> <F569EBDF-D8B5-47D5-8C2F-DA3A0F6C207E@ancientrocklab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 22:54:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm9Xk-0003Tk-Dn
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 22:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab3K1Vyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 16:54:36 -0500
Received: from plane.gmane.org ([80.91.229.3]:33762 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3K1Vyg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 16:54:36 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Vm9Xf-0003PG-3V
	for git@vger.kernel.org; Thu, 28 Nov 2013 22:54:35 +0100
Received: from acwf157.neoplus.adsl.tpnet.pl ([83.11.137.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 22:54:35 +0100
Received: from jnareb by acwf157.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 22:54:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.11.137.157 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/30.0.1599.114 Chrome/30.0.1599.114 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238516>

zhifeng hu <zf <at> ancientrocklab.com> writes:

>=20
> Once using git clone =E2=80=94depth or git fetch =E2=80=94depth,
> While you want to move backward.
> you may face problem
>=20
>  git fetch --depth=3D105
> error: Could not read 483bbf41ca5beb7e38b3b01f21149c56a1154b7a
> error: Could not read aacb82de3ff8ae7b0a9e4cfec16c1807b6c315ef
> error: Could not read 5a1758710d06ce9ddef754a8ee79408277032d8b
> error: Could not read a7d5629fe0580bd3e154206388371f5b8fc832db
> error: Could not read 073291c476b4edb4d10bbada1e64b471ba153b6b

BTW. there was (is?) a bundler service at http://bundler.caurea.org/
but I don't know if it can create Linux-size bundle.

--=20
Jakub Nar=C4=99bski
