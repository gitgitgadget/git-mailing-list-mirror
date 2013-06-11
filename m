From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-remote-mediawiki: display message when launched directly
Date: Tue, 11 Jun 2013 15:44:32 +0200
Message-ID: <vpqsj0o3gov.fsf@anie.imag.fr>
References: <1370957928-19303-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 15:44:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmOsK-0008Ac-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 15:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab3FKNog convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 09:44:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58584 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab3FKNog (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 09:44:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5BDiVM5021221
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 15:44:31 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UmOsD-0002Tt-5H; Tue, 11 Jun 2013 15:44:33 +0200
In-Reply-To: <1370957928-19303-1-git-send-email-celestin.matte@ensimag.fr>
	(=?iso-8859-1?Q?=22C=E9lestin?= Matte"'s message of "Tue, 11 Jun 2013
 15:38:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 11 Jun 2013 15:44:31 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227442>

C=E9lestin Matte <celestin.matte@ensimag.fr> writes:

> Users may be confused when they run the perl script directly.
> A good way to detect this is to check the number of parameters used t=
o call the
> script, which is never different from 2 in a normal use.
> Display a proper error message to avoid any confusion.

Sounds good, thanks.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
