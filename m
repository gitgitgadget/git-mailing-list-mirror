From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Sat, 22 May 2010 18:06:50 +0200
Message-ID: <201005221806.51213.jnareb@gmail.com>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com> <m34oi1s13e.fsf@localhost.localdomain> <1274543931.21346.171.camel@Luffy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 18:07:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFrE8-0008Ks-KF
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 18:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab0EVQG7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 May 2010 12:06:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44774 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab0EVQG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 12:06:58 -0400
Received: by bwz7 with SMTP id 7so372690bwz.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=j4mZj7de3aPH466LJ3jeIyelfz2dxvloZJ7d81cqt9Q=;
        b=wBGzJyhp1/YdY7XTVdSRXvNs/KyKRUfqE03z1VGzOaI8dnJ9Ojd9Mn8RHjdILz/TEJ
         62g+YNTbqgVL873KsjyFx6GAkMWZ32bmPM6zPhlBBDuKYSkNPHDRV0g08FQehsLB7ouN
         iJz2qbh1Jf1fc0VWDyw+rNa86YSX399ffJyLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QSAsoz2/NkJSmyoP+Qi8CAmpznCf3wgZ65HDojtlzRMctFSAX8wuxe+/m45w5zBgrL
         MKkA/jQKqP8QyeYX7Am37O4eSAsRS1OsAj5VLh+up1bcUF9rHulHu9AYNSDlNWdQFLYF
         sDfSInB+WF9uMw+hyuNuEBSBEjFZvaGp5bmSs=
Received: by 10.204.137.81 with SMTP id v17mr741501bkt.93.1274544416667;
        Sat, 22 May 2010 09:06:56 -0700 (PDT)
Received: from [192.168.1.15] (abwk129.neoplus.adsl.tpnet.pl [83.8.234.129])
        by mx.google.com with ESMTPS id a11sm9958012bkc.9.2010.05.22.09.06.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 09:06:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1274543931.21346.171.camel@Luffy>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147531>

Dnia sobota 22. maja 2010 17:58, Daniele Segato napisa=C5=82:
> Il giorno ven, 21/05/2010 alle 08.54 -0700, Jakub Narebski ha scritto=
:
> > Daniele Segato <daniele.bilug@gmail.com> writes:
> >=20
> > [...]
> > > I think that to introduce git in my company I should at least go =
throw
> > > this 5 points:
> >=20
> > > 1. prepare a project management web application easy to use and
> > >    mantain (like github or gitorious for instance) on one of our
> > >    intranet servers.
> >=20
> > Note that while Gitorious (in Ruby), InDefero (in PHP), and Girocco
> > (with gitweb, Perl + shell script, used by http://repo.or.cz) are o=
pen
> > source, GitHub is not.  There is GitHub:FI if you want [self] hoste=
d
> > GitHub-alike, but it is proprietary and it is not cheap.
> >=20
> > There is also Gerrit, a web based code review system, which runs in
> > any standard Java servlet container.
>=20
> Thanks for the list. [...] I never heard of some of the project you
> listed here, I'll give them a try.

https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools shoul=
d
be a good source of information about miscelanous git tools.

> Did someone worked with some of them and have a review or an opinion
> about them?

That I can't help you with.

--=20
Jakub Narebski
Poland
