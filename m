From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote: fix typo
Date: Fri, 18 May 2012 20:03:52 -0400
Message-ID: <20120519000352.GB765@sigill.intra.peff.net>
References: <1337359561-17337-1-git-send-email-ralf.thielow@googlemail.com>
 <CAN0XMOJoW0jZSYYZv0rWqJTEbCRBjDogq3iJ96SeYnpU9_Ab5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:04:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVX9Y-0005sW-7l
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 02:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946392Ab2ESAD5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 20:03:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48866
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946177Ab2ESADz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 20:03:55 -0400
Received: (qmail 9798 invoked by uid 107); 19 May 2012 00:04:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 20:04:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 20:03:52 -0400
Content-Disposition: inline
In-Reply-To: <CAN0XMOJoW0jZSYYZv0rWqJTEbCRBjDogq3iJ96SeYnpU9_Ab5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197997>

On Fri, May 18, 2012 at 07:16:02PM +0200, Ralf Thielow wrote:

> On Fri, May 18, 2012 at 6:46 PM, Ralf Thielow
> <ralf.thielow@googlemail.com> wrote:
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 warning(_("Not updating non-default fetch respec\n"
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 warning(_("Not updating non-default fetch refspec\n"
>=20
> Oops, probably it's not a typo, sorry

No, I think it's a typo.

-Peff
