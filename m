From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Re: Google Summer of Code 2011
Date: Thu, 10 Mar 2011 00:16:04 +0100
Message-ID: <20110309231604.GA3903@paksenarrion.iveqy.com>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110307194047.GA9588@book.hvoigt.net>
 <20110307205023.GB11764@paksenarrion.iveqy.com>
 <20110309215255.GA11845@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 00:08:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxSUY-0002lK-Hi
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 00:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab1CIXI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 18:08:26 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33111 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1CIXIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 18:08:24 -0500
Received: by fxm17 with SMTP id 17so1040309fxm.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 15:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8oM/3JT8o8/eQNhOlA9wSqiKt9zy008IiDaqT/R9zFM=;
        b=Xr1OsgC0r06ldjeNAbRR/CmgLDTpf6qOR/mcBpmDpRuuCIcKqj/wMFJc+ixqnl3ID8
         vwWUsNzL2MPn8dZeJzKP2bWU4IKcS+yeeEZ3pHoy96lC5wfPLFB524T8p04FnZOzb/ZY
         eKXHGLoEyCBQNa4ejiIXLWf7uWS1TnPnx4MSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AEIifsOtS9YeUH3kJ2MdaLEJP7jBZtAnYgH4GZOhs37XHVSXzPC/t2wdv9YFkwxKrK
         NuwugAR4+vTYOsFdTE0QoDCvaGufn+macBzIT4x+j89leLDWyIDzzT17XSxvvfOX3zt4
         VW2NKO6na+wjQ9LpQjYPHtTbSwvnAXWi54rnk=
Received: by 10.223.112.131 with SMTP id w3mr535681fap.43.1299711950755;
        Wed, 09 Mar 2011 15:05:50 -0800 (PST)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id f16sm1211012faa.38.2011.03.09.15.05.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 15:05:50 -0800 (PST)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1PxSbs-00015g-QX; Thu, 10 Mar 2011 00:16:04 +0100
Content-Disposition: inline
In-Reply-To: <20110309215255.GA11845@book.hvoigt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168774>

On Wed, Mar 09, 2011 at 10:52:56PM +0100, Heiko Voigt wrote:
> Hi,
>=20
> On Mon, Mar 07, 2011 at 09:50:23PM +0100, Fredrik Gustafsson wrote:
> > On Mon, Mar 07, 2011 at 08:40:47PM +0100, Heiko Voigt wrote:
> > > I can offer to mentor a project either about submodule improvemen=
ts or
> > > on gui stuff (git-gui or gitk). Since I am still not a native spe=
aker of
> > > the full git code base co-mentoring would be an option for other
> > > projects.
> >=20
> > That's sounds very interesting.
> >=20
> > I'm using git with submodules a lot (daily in 5-10 different smalle=
r
> > projects with 1-5 developers in each) and suffers from lacking subm=
odule
> > support, specially in the gui-tools.=20
> >=20
> > Being a student this is a part of git I would be very interested in
> > helping to improve.
>=20
> Sounds promising. When I was talking about gui or submodules I did no=
t
> think about gui *and* submodules. Do you have some concrete areas you
> would like to improve in mind?

Many of the ideas I had was already mentioned in=20
https://github.com/jlehmann/git-submod-enhancements/wiki/

The ones I feel is most important for me is:
* gitk: Add popup menu for submodules to see the detailed history of
changes
* Check before a push in the superproject that all submodules HEADs are
pushed
* Showing that a submodule has a HEAD not on any branch in =E2=80=9Cgit=
 status=E2=80=9D
* Move the submodules git directories into the superproject=E2=80=99s .=
git so that
submodules can be created and deleted

With this said, I'm not familiar with the git codebase yet and does not
have any concrete solutions. For example, I don't understand why a
submodule doesn't get a default branch.

--=20
Med v=C3=A4nliga h=C3=A4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
