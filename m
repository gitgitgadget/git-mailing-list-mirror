From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] Documentation: convert tutorials to man pages
Date: Sun, 25 May 2008 06:57:57 +0200
Message-ID: <200805250657.57568.chriscool@tuxfamily.org>
References: <20080524205644.f056db96.chriscool@tuxfamily.org> <200805250113.m4P1DSCg028065@mi1.bluebottle.com> <7vlk1zjh4x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?=
	 =?utf-8?q?_?= <nanako3@bluebottle.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 06:54:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K08FT-0001cA-Ug
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 06:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbYEYExc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 00:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbYEYExc
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 00:53:32 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:46279 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbYEYExb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 May 2008 00:53:31 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2594B1AB2B1;
	Sun, 25 May 2008 06:53:30 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1D08A1AB2AB;
	Sun, 25 May 2008 06:53:28 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vlk1zjh4x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82849>

Le dimanche 25 mai 2008, Junio C Hamano a =C3=A9crit :
> =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nan=
ako3@bluebottle.com> writes:
> > Christian Couder <chriscool@tuxfamily.org> writes:
> >
> > However, I think this is much improved, compared to the one around =
the
> > beginning of the month.  Especially that documents like the user ma=
nual
> > that do not fit well in "manual page" format are excluded.
> >
> > But if I read intro(1) and intro(7) correctly, nothing other than t=
he
> > user commands should go to section 1.  Here is my attempt, as a
> > replacement patch, to clean it up.
> >
> > What do you think?
>
> Christian, I think the amended patch makes more sense (I haven't comp=
ared
> the two very carefully, though).

Nanako's amended patch looks good to me too.

Tested-by: Christian Couder <chriscool@tuxfamily.org>

So please apply.

Thanks to Nanako and you,
Christian.=20
