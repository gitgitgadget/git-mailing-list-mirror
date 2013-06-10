From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 09/28] git-remote-mediawiki: Change the behaviour of a split
Date: Mon, 10 Jun 2013 10:29:47 +0200
Message-ID: <vpqppvuqsg4.fsf@anie.imag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-10-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 10:29:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlxUB-0002da-8F
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 10:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530Ab3FJI3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 04:29:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48489 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384Ab3FJI3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 04:29:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5A8TlYp005139
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 10:29:47 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UlxU4-00083h-5B; Mon, 10 Jun 2013 10:29:48 +0200
In-Reply-To: <1370816573-3808-10-git-send-email-celestin.matte@ensimag.fr>
	(=?iso-8859-1?Q?=22C=E9lestin?= Matte"'s message of "Mon, 10 Jun 2013
 00:22:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 10:29:47 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227260>

C=E9lestin Matte <celestin.matte@ensimag.fr> writes:

> A "split ' '" is turned into a "split / /", which changes its behavio=
ur: the
> old method matched a run of whtespaces (/\s*/)

It case there's a v4: whtespaces -> whitespaces.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
