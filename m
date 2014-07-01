From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] wt-status: simplify building of summary limit argument
Date: Tue, 01 Jul 2014 10:44:40 +0200
Message-ID: <vpq61jhfoxz.fsf@anie.imag.fr>
References: <53B07B44.9000406@web.de> <53B07D50.9050805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 01 10:45:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1th5-0006Zm-Ke
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 10:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757794AbaGAIpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2014 04:45:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58067 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757450AbaGAIpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 04:45:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s618ieNu002363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 Jul 2014 10:44:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s618ifk2012406;
	Tue, 1 Jul 2014 10:44:41 +0200
In-Reply-To: <53B07D50.9050805@web.de> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of "Sun, 29
	Jun 2014 22:55:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Jul 2014 10:44:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s618ieNu002363
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404809083.7753@UhSfMCEBneUrJq6/wmCwHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252713>

Ren=E9 Scharfe <l.s.r@web.de> writes:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  wt-status.c | 4 +---

Both patches sound straightforward and good to me.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
