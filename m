From: Sylvestre Ledru <sylvestre.ledru@scilab.org>
Subject: Re: Corruption in the repository
Date: Tue, 14 Dec 2010 10:59:40 +0100
Message-ID: <1292320780.25237.28797.camel@korcula.inria.fr>
References: <1292255990.25237.27642.camel@korcula.inria.fr>
	 <AANLkTimD6+CHofhbKvBPjHpcNUNusHOCHSQe+-J1ZA4F@mail.gmail.com>
	 <1292258845.25237.27680.camel@korcula.inria.fr>
	 <AANLkTimgLhQMUGmC=W5wpcAvb07faw4HOzPgWXpFA4u1@mail.gmail.com>
	 <1292263868.25237.27772.camel@korcula.inria.fr>
	 <AANLkTikP3CTNX_S=fAWTBVbt0OwQMLr+mq8f72OFd0j6@mail.gmail.com>
	 <20101214094601.GA21755@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Simon Gareste <simon.gareste@scilab.org>,
	Bruno JOFRET <bruno.jofret@scilab.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 10:59:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSRff-0002sj-B4
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 10:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758500Ab0LNJ7m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 04:59:42 -0500
Received: from santostefano.inria.fr ([193.51.192.151]:54301 "HELO
	santostefano.inria.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751331Ab0LNJ7m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 04:59:42 -0500
Received: (qmail 19703 invoked by uid 1001); 14 Dec 2010 10:59:40 +0100
Received: from korcula.inria.fr by santostefano (envelope-from <sylvestre.ledru@scilab.org>, uid 92) with qmail-scanner-2.02st 
 (clamdscan: 0.90.1/7197. spamassassin: 3.1.7-deb. perlscan: 2.02st.  
 Clear:RC:1(193.51.192.130):. 
 Processed in 0.016428 secs); 14 Dec 2010 09:59:40 -0000
Received: from korcula.inria.fr (HELO ?193.51.192.130?) (193.51.192.130)
  by santostefano.inria.fr with SMTP; 14 Dec 2010 10:59:40 +0100
In-Reply-To: <20101214094601.GA21755@burratino>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163642>

Le mardi 14 d=C3=A9cembre 2010 =C3=A0 03:46 -0600, Jonathan Nieder a =C3=
=A9crit :
> Christian Couder wrote:
>=20
> > When I try "git grep corrupted" on the git and gerrit sources I don=
't
> > find anything relevant.
>=20
> The error message was changed by b6c4cec (read_sha1_file(): report
> correct name of packfile with a corrupt object, 2010-10-28) and
> especially v1.7.3-rc0~73^2 (sha1_file: Show the the type and path to
> corrupt objects, 2010-06-10).
>=20
> Random guess: maybe a corrupt but redundant packed object was removed
> in the course of investigation? =20
We haven't tried to delete files. We have been careful (at least, try
to)

> Sylvestre, are you still able to get errors from the repository? =20
Sure

> If you still have a copy of the original
> corrupt version of the repository, I would be interested (to learn
> something about how it got damaged in the first place).
Me too.=20
I send you the URL in private (it is 344M).

Sylvestre
