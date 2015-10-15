From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Thu, 15 Oct 2015 10:07:08 +0200
Message-ID: <vpq37xc4ksz.fsf@grenoble-inp.fr>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
	<vpqwpurx2j1.fsf@grenoble-inp.fr>
	<1B50DC8E-45CC-4D9A-80A1-6391D762A81C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, johannes.schindelin@gmx.de,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Pete Wyckoff <pw@padd.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <avila.jn@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 10:07:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmdZQ-0000P9-Un
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 10:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbbJOIHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Oct 2015 04:07:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46646 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbbJOIHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 04:07:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9F877Ia003067
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 15 Oct 2015 10:07:07 +0200
Received: from anie (ensi-vpn-233.imag.fr [129.88.57.233])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9F878CA010215;
	Thu, 15 Oct 2015 10:07:08 +0200
In-Reply-To: <1B50DC8E-45CC-4D9A-80A1-6391D762A81C@gmail.com> (Lars
	Schneider's message of "Thu, 15 Oct 2015 00:52:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 15 Oct 2015 10:07:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9F877Ia003067
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445501229.86733@/d24l4efb452gWHnExLm+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279652>

Lars Schneider <larsxschneider@gmail.com> writes:

> I would like to get rid of the "sudo" calls, too. Unfortunately I
> wasn't able to achieve this so far because these packages are not
> white listed on Travis CI (see Jean-No=EBl answer in this thread).

I think this would deserve a mention in the commit message, but I won't
insist on that.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
