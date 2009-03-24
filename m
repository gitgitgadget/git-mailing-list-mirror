From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 05:00:14 -0400
Message-ID: <20090324090014.GA2075@coredump.intra.peff.net>
References: <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com> <20090323064242.GB1119@coredump.intra.peff.net> <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com> <49C7A8AF.9080500@drmicha.warpmail.net> <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com> <7vwsaf4qqx.fsf@gitster.siamese.dyndns.org> <94a0d4530903240052x2c6b882aub7de6d46e9949ddb@mail.gmail.com> <20090324081846.GB660@coredump.intra.peff.net> <94a0d4530903240157v2b9aa91dh4c731b77de9d7b58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:01:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2W7-000613-4p
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886AbZCXJAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 05:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754919AbZCXJAY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 05:00:24 -0400
Received: from peff.net ([208.65.91.99]:45858 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493AbZCXJAX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 05:00:23 -0400
Received: (qmail 28257 invoked by uid 107); 24 Mar 2009 09:00:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 05:00:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 05:00:14 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530903240157v2b9aa91dh4c731b77de9d7b58@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114431>

On Tue, Mar 24, 2009 at 10:57:43AM +0200, Felipe Contreras wrote:

> > Really? They look very different. Here's a screenshot of the user-m=
anual
> > with patches 2 and 3 from your series applied, next to Wikipedia. Y=
our
> > text is smaller, and the line-spacing makes it look more scrunched:
> >
> > =C2=A0http://peff.net/wikipedia-git-textsize.png
>=20
> Hmm, strange, can you tell me what is the configured font/font-size y=
ou have?

=46reeSans, 14pt (and I default to sans-serif for proportional text).

> Regarding the line-space I already changed that as you suggested:
> file:///data/public/src/git/Documentation/user-manual.html

I had a little trouble fetching that URL. ;)

But yes, I saw that you did.

-Peff
