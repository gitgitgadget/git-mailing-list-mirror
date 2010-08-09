From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: [PATCH/RFC] tests: WIP Infrastructure for Git smoke
	testing
Date: Mon, 9 Aug 2010 21:56:08 +0200
Message-ID: <20100809195608.GA16478@book.hvoigt.net>
References: <1280438455-16255-1-git-send-email-avarab@gmail.com> <201007300011.50330.trast@student.ethz.ch> <20100808134238.GA9659@book.hvoigt.net> <AANLkTimdFz38gfq1oW0VQ9giaavFnqRUH8DDEeoFN=BT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 21:56:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiYSH-0000Wy-NY
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab0HIT4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 15:56:12 -0400
Received: from darksea.de ([83.133.111.250]:42229 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755320Ab0HIT4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 15:56:11 -0400
Received: (qmail 3819 invoked from network); 9 Aug 2010 21:56:08 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 9 Aug 2010 21:56:08 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTimdFz38gfq1oW0VQ9giaavFnqRUH8DDEeoFN=BT@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153009>

On Sun, Aug 08, 2010 at 02:54:21PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> On Sun, Aug 8, 2010 at 13:42, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > On Fri, Jul 30, 2010 at 12:11:50AM +0200, Thomas Rast wrote:
> >> =C4=86var Arnfj=C3=B6r=C4=91 Bjarmason wrote:
> >> > =C2=A0 - Is this worthwhile. Are there developers / packagers / =
other
> >> > =C2=A0 =C2=A0 interested parties here who'd be interested in act=
ually running
> >> > =C2=A0 =C2=A0 smoke testers? It should be really easy to set one=
 up.
> >>
> >> I'm all for it!
> >
> > Me too! I should be able to setup a cronjob for tests under a Windo=
ws XP
> > machine. Does that count as an obscure platform ? ;)
>=20
> I think it does :)
>=20
> I just sent another version of the series to the list. It'd be very
> useful if you could try sending a smoke report from Windows XP.

I tried to do it yesterday but unfortunately some of the tests seem to
hang on Windows so I could not complete the report. I will try to
generate a skip list and run the smoke_report again later.

cheers Heiko
