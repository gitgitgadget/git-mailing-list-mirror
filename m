From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 2/2] tests: add tests for the bash prompt functions
	in the completion script
Date: Tue, 17 Apr 2012 02:33:31 +0200
Message-ID: <20120417003331.GC2299@goldbirke>
References: <20120416160124.GL5813@burratino>
	<1334614176-2963-1-git-send-email-szeder@ira.uka.de>
	<1334614176-2963-2-git-send-email-szeder@ira.uka.de>
	<20120416235026.GA12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 02:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJwMe-0007cz-JI
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 02:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab2DQAdo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 20:33:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52655 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab2DQAdn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 20:33:43 -0400
Received: from localhost6.localdomain6 (p5B130635.dip0.t-ipconnect.de [91.19.6.53])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MAysS-1SRbsE47D2-00ARsN; Tue, 17 Apr 2012 02:33:31 +0200
Content-Disposition: inline
In-Reply-To: <20120416235026.GA12613@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:USGIdJg15SBoqHNzTrlmt7u101rJji7LPon3YneYske
 e4T0cjJa7knKs2XWQ0TitkttrwKKyppw3Gyq7gIfUIeCtCA/0a
 c0PQfoLBRJPM5NyajT4hW9FMRQB9HiqIkUvmoETzTavogYf+94
 hyCVtKxTnhZ+tpM0xlUxWfip2QZyV7dTN/gM9G7WJWCzcZDKW9
 YwRbtF1RA6D3f69bi6mWOskgSPXVxvi+flI0sZmLnExFyNlcVV
 HopR0w/9npf6G8QR68kRtRGLOryuNREMCt12ZhvYD69ITOr1RF
 lQrBKC4EdPWKM4UU0X3YDKPv38J9ovNV7+SAyKppm3uf+enilx
 74FQue9yTK/rH1DuhDyk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195728>

On Mon, Apr 16, 2012 at 06:50:26PM -0500, Jonathan Nieder wrote:
> SZEDER G=E1bor wrote:
>=20
> >  create mode 100644 t/t9903-bash-prompt.sh
>=20
> Should be 100755, no?

Yes, of course.  Forgot to re-format-patch after amend.
