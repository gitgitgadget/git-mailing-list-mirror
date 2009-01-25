From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Sun, 25 Jan 2009 23:55:24 +0100
Message-ID: <190FD80D-0F10-4C76-9029-1434F362EFDB@wincent.com>
References: <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org> <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com> <831vuvfh7t.fsf@kalahari.s2.org> <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com> <83wscndv57.fsf@kalahari.s2.org> <94a0d4530901240021u65adeff8pb6995ef707bc1f68@mail.gmail.com> <alpine.DEB.1.00.0901241438370.13232@racer> <94a0d4530901240604o5ae0d321h17dc6aabeefe9d53@mail.gmail.com> <7vvds3dszy.fsf@gitster.siamese.dyndns.org> <94a0d4530901251312q4201d51btd806fe860a12afd6@mail.gmail.com> <20090125214435.GA20173@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 25 23:57:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDud-0002AN-MK
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbZAYWzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2009 17:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbZAYWzm
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:55:42 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:40909 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbZAYWzm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jan 2009 17:55:42 -0500
Received: from cuzco.lan (156.pool85-53-20.dynamic.orange.es [85.53.20.156])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n0PMtPUU005619
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 25 Jan 2009 17:55:28 -0500
In-Reply-To: <20090125214435.GA20173@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107118>

El 25/1/2009, a las 22:44, Jeff King escribi=F3:

> On Sun, Jan 25, 2009 at 11:12:57PM +0200, Felipe Contreras wrote:
>
>> However, my last proposal was to have both the git config --global
>> *and* the $HOME/.gitconfig description. Is there any argument agains=
t
>> that?
>
> This is like the fifth time you have asked, and for some reason, =20
> nobody
> seems to have said yes or no. So I will go ahead and say: yes, I thin=
k
> that is a fine idea.
>
> I think there should also be some explanatory text that indicates the=
y
> are totally interchangeable for the rest of the document. Something
> like: "When we show configuration in the rest of this document, we =20
> will
> use format X [I think probably "git config $VAR $VALUE"]. But you can
> use whichever method you are most comfortable with."

I already suggested something similar about 4 days ago:

http://article.gmane.org/gmane.comp.version-control.git/106673/

Cheers,
Wincent
