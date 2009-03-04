From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] git-clone.txt: document that pushing from a shallow
	clone may work
Date: Wed, 4 Mar 2009 11:19:39 +0100
Message-ID: <20090304101939.GA7142@chistera.yi.org>
References: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com> <1236080017-13987-1-git-send-email-dato@net.com.org.es> <49AD1B22.6050201@viscovery.net> <20090303120856.GB15003@chistera.yi.org> <76718490903031127v7fcec124je7292c4c465208b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com, Mikael Magnusson <mikachu@gmail.com>,
	Joey Hess <joey@kitenet.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:21:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeoDu-00014B-6f
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbZCDKTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 05:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbZCDKTn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:19:43 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4686
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbZCDKTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 05:19:42 -0500
Received: from justin (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 87E76801C072;
	Wed,  4 Mar 2009 11:19:39 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LeoCR-0001s3-1n; Wed, 04 Mar 2009 11:19:39 +0100
Content-Disposition: inline
In-Reply-To: <76718490903031127v7fcec124je7292c4c465208b8@mail.gmail.com>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112197>

* Jay Soffian [Tue, 03 Mar 2009 14:27:29 -0500]:

> On Tue, Mar 3, 2009 at 7:08 AM, Adeodato Sim=C3=B3 <dato@net.com.org.=
es> wrote:
> > Well, I don't know if the set of cases where it'll work can be defi=
ned
> > in detail to a point where it is useful. If it is, then sure, let's=
 do
> > it.

> > My point is that if it will work in some cases, then the documentat=
ion
> > should *acknowledge that fact*, because else people will assume the
> > documentation is wrong, and believe it is intended to work, which i=
s not
> > the case.

> Wy not just say "pushing into a shallow repository is not supported"
> instead of "pushing into a shallow repository won't work."

I don't think such a wording is enough (adjusted, of course, to be abou=
t
pushing from, not to, which is the case at hand).

But I'll try to stay silent, and see if Junio has an opinion on the
matter.

Thanks,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
- Oh my God, you're pimping me out for a new roof?
- And windows!
                -- Andrew and Bree Van De Kamp
