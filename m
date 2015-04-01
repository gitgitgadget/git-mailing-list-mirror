From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: VCS popularity
Date: Wed, 1 Apr 2015 15:07:49 +0200
Message-ID: <20150401130749.GB12910@paksenarrion.iveqy.com>
References: <CAA787rkKYQ=TJezeLy0f=aGs2GR8ypuxmr2qA2py+hGsC+juVA@mail.gmail.com>
 <alpine.DEB.2.02.1503311502240.26359@nftneq.ynat.uz>
 <CAA787rm1qfaLb=ZAvZ19h+_EBv-a3S7xV=0B6kMfjYpKsAbNcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Lang <david@lang.hm>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?B?2Hl2aW5kIEEu?= Holm <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Wed Apr 01 15:08:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdINB-0008JR-ND
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 15:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbbDANHx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2015 09:07:53 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:33421 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbbDANHw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 09:07:52 -0400
Received: by lajy8 with SMTP id y8so35998050laj.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Sj3N4+XTLxaRGoIS8mVxQwVWrl16VDVKVtimlq1Ag4E=;
        b=q8hxnaR4yYoNvex/KPMNUScC3zewKd5SqXgsGQaoXlE71CQ8tYz3KJ+NhS4X+KgHSA
         2ky2c0Nfg6WaynL1zc1fhm/vTjssMn18lePk+o0QdkOTQf6JadVma4IB6UsesXeWtLEZ
         hrhCGCvMT8arhXp4DBe2mIfHqUTRukbBZlkVxiKrpGueGt1tNZMOwtvIh3BcMopYvJ6c
         N6722ouBPlP8J1YFpURnsgCQ19W9ez5tG2vhpXHQ3YCEcfY5y8F64/gV9kG4haEWuglX
         EpV3TKeS5OC12bKPho1k0c1RUGsRb3DhGX05jPU2UwTvbNterggnFRDD5Csp+ZdQU676
         EOrQ==
X-Received: by 10.152.6.136 with SMTP id b8mr35063692laa.93.1427893671210;
        Wed, 01 Apr 2015 06:07:51 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id pq1sm403780lbb.41.2015.04.01.06.07.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 06:07:50 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1YdIN3-00089M-FB; Wed, 01 Apr 2015 15:07:49 +0200
Content-Disposition: inline
In-Reply-To: <CAA787rm1qfaLb=ZAvZ19h+_EBv-a3S7xV=0B6kMfjYpKsAbNcg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266605>

On Wed, Apr 01, 2015 at 12:14:52AM +0200, =D8yvind A. Holm wrote:
> On 1 April 2015 at 00:03, David Lang <david@lang.hm> wrote:
> > On Tue, 31 Mar 2015, =D8yvind A. Holm wrote:
> > > openhub.net (formerly ohloh.net) has an interesting comparison of
> > > the number of public repositories on the net, based on searches o=
f
> > > popular hosting services. This comparison is available at
> > > <https://www.openhub.net/repositories/compare> and shows an
> > > estimated market share between Bazaar, CVS, Git, Mercurial and
> > > Subversion.
> > >
> > > I've been monitoring this since 2014-08-05 to see how things were
> > > developing, and it's a good indication of the popularity of the
> > > various version control systems.
> >
> > number of repositories is an interesting datapoint, but activity in
> > the repos would be far more interesting. There are a lot of repos o=
f
> > various types out there that haven't been touched for years.
>=20
> I do agree on that. Many repositories won't be deleted if they are
> converted to other VC systems to avoid breaking links and so on. What=
 I
> found pretty interesting is the relative growth between the various
> systems. That's why I created the graphs that show creation of new
> repositories since August 2014 instead, for example
>=20
> https://github.com/sunny256/openhub-repositories/blob/master/graph/re=
lative-zoom.svg

Github is serving every git repo as a svn repo too (or at least did). I=
n
a talk they claimed to be the worlds biggest subversion host (if I
recall correctly).

However most people hosting on github doesn't do it to use svn but git.
Anyway, this mean that for every github git repo there's one svn repo.
Is github big enough to make the plots above invalid?

--=20
=46redrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
