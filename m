From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 19:53:53 +0200
Message-ID: <20130609175353.GC2091@goldbirke>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
 <20130609171810.GA10858@goldbirke>
 <CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
 <20130609173342.GB2091@goldbirke>
 <CAMP44s2YdG_pE7gnKfUJJP0SaO5pKu+kxPB=T74p14fuqXU9OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:54:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljop-0004fo-Or
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825Ab3FIRyO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:54:14 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:49221 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab3FIRyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:54:09 -0400
Received: from localhost6.localdomain6 (f051160074.adsl.alicedsl.de [78.51.160.74])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MYcDK-1UqflT1hS6-00VSg1; Sun, 09 Jun 2013 19:53:53 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s2YdG_pE7gnKfUJJP0SaO5pKu+kxPB=T74p14fuqXU9OQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:bQuFxI2jvKvKReJcax4+Q18zzxmCCv4PfzIO/ZMo7QF
 pAhu5T2G+l6WZhKg8zx8zmR/rW/EWU70ZbP611L8z1XX1gmUBb
 DMeydSWKMT8/FOcqzhs/D3qARLXdXNyMGQu5ANo1WqUtO4fteD
 wjgZeFA/tpDDTQtQ1HOy7VTDlPwPli9PyEFLdKKTGPZ9TU0LPh
 YTbZtK//HPCJp3Q0H80Zh6Kgu7AA6lLZwiT06u5xa5NBi3T1l0
 moEMivV4JVkqKTVrgNUqVLiPS8BtrdaheyisLeP8ed4YEGabpm
 cj07oLabjGyr9mya5iZn3TKD6xQUzfTaau355PYXUQpQE9S5oP
 qsdt96ll3U2POuL+f2OI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227055>

On Sun, Jun 09, 2013 at 12:47:16PM -0500, Felipe Contreras wrote:
> On Sun, Jun 9, 2013 at 12:33 PM, SZEDER G=E1bor <szeder@ira.uka.de> w=
rote:
> > On Sun, Jun 09, 2013 at 12:23:01PM -0500, Felipe Contreras wrote:
> >> On Sun, Jun 9, 2013 at 12:18 PM, SZEDER G=E1bor <szeder@ira.uka.de=
> wrote:
> >> > On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wrote=
:
> >> >> We should free objects before leaving.
> >> >>
> >> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> >
> >> > A shortlog-friendlier subject could be: "sequencer: free objects
> >> > before leaving".
> >>
> >> I already defended my rationale for this succinct commit message:
> >>
> >> http://thread.gmane.org/gmane.comp.version-control.git/225609/focu=
s=3D225610
> >
> > Your arguments were unconvincing.
>=20
> That's your opinion.

And Duy's.  And John's, too, apparently.

> The commit message I write and send is my decision.

It's always a pleasure to work with you.

Guess I should've known better.


Bye,
G=E1bor
