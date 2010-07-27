From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Tue, 27 Jul 2010 14:28:41 -0400
Message-ID: <20100727182841.GA25124@worldvisions.ca>
References: <4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> <m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> <4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> <AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com> <AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com> <4C4DB9AC.9000306@xiplink.com> <AANLkTimQywtn-0Fcr-ceLeHGeSBNROt+T=K+TowF_u5h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>, skillzero@gmail.com,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 20:28:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdotC-0000hS-Kk
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 20:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329Ab0G0S22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 14:28:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60650 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab0G0S2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 14:28:25 -0400
Received: by iwn7 with SMTP id 7so3921677iwn.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ql0018Iui+rvfISmLMza25fFHIJQ5PcEKRN3XzGEyeA=;
        b=Daa2DvwKk2PjgTK8dT423JEhXFPEgNEjhCjlm9VUCdJKi0JQs05uZOdWtDtdhIFKNc
         u8BmSl3bYQOKOdc3iiTBprR+6Vlqsv+MrzK6NCUGcfhIm7i24yBd7hmlFmElA+HfpDFj
         d53C7rrxidCV3U9H+LQSHrTMck2T++j68KxYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=k8sPFdr0HhtstjQs82tE6c6okBW6+kME3/r/EHJGiRzBuN5KZkoWvN37kyJjNCBiKH
         BjGDSJfFbLLHAeurzYL6Rmg+07iAzyBTK4mIthbWMyv2uz8VcLbaudSoKQtBVB+IzoHK
         s7vOlCooAyqiaBI1QaomckmjLL579tErt1b8Q=
Received: by 10.231.149.3 with SMTP id r3mr10575704ibv.109.1280255304403;
        Tue, 27 Jul 2010 11:28:24 -0700 (PDT)
Received: from afterlife.apenwarr.local ([66.51.252.152])
        by mx.google.com with ESMTPS id g31sm5025475ibh.10.2010.07.27.11.28.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 11:28:22 -0700 (PDT)
Received: from apenwarr by afterlife.apenwarr.local with local (Exim 4.69)
	(envelope-from <apenwarr@afterlife.apenwarr.local>)
	id 1OdotN-0006XR-Of; Tue, 27 Jul 2010 14:28:41 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimQywtn-0Fcr-ceLeHGeSBNROt+T=K+TowF_u5h@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151966>

On Mon, Jul 26, 2010 at 09:41:42AM -0700, Linus Torvalds wrote:

> On Mon, Jul 26, 2010 at 9:37 AM, Marc Branchaud <marcnarc@xiplink.com=
> wrote:
> >
> > I think I should mention one aspect of what we're doing, which is t=
hat a lot
> > of our submodules are based on external code, and that we occasiona=
lly need
> > to modify or customize some of that code. =A0So it's quite nice for=
 us to
> > maintain private git mirrors of the external repos, with our own pr=
ivate
> > branches that contain our modifications. =A0Although we want to get=
 much of our
> > changes incorporated into the upstream code bases, upstream release=
 cycles
> > are rarely in sync with ours.
>=20
> THIS.
>=20
> This is why I always thought that submodules absolutely have to be
> commits, not trees. It's why the git submodule data structures are
> done the way they are. Anything that makes the submodule just a tree
> is fundamentally broken, I think.

I agree completely.  The major failing of git-subtree is that it uses
tree->tree links instead of tree->commit links.

This was necessary only because git fundamentally *mistreats* tree->com=
mit
links: it refuses to push or fetch through them automatically.  That is=
,
when I fetch a superproject that has a tree->commit link in it, git won=
't
fetch the subproject's history starting at the targeted commit, even if=
 the
remote repo *has* that history.  And if I make a patch to the subprojec=
t,
pushing the superproject won't push that patch.

Have fun,

Avery
