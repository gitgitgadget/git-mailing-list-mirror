From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v8] git on Mac OS and precomposed unicode
Date: Sun, 08 Jul 2012 15:16:16 +0200
Message-ID: <m2hatis89r.fsf@igel.home>
References: <201207081502.10424.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 15:16:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnrLf-000892-Gg
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 15:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab2GHNQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jul 2012 09:16:21 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:55839 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2GHNQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 09:16:20 -0400
Received: from frontend4.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WVVZc6NfCz3hhVM;
	Sun,  8 Jul 2012 15:17:12 +0200 (CEST)
Received: from igel.home (ppp-88-217-112-177.dynamic.mnet-online.de [88.217.112.177])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WVVYZ0wfdzbbgZ;
	Sun,  8 Jul 2012 15:16:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id CE639CA2A3; Sun,  8 Jul 2012 15:16:17 +0200 (CEST)
X-Yow: My CODE of ETHICS is vacationing at famed SCHROON LAKE
 in upstate New York!!
In-Reply-To: <201207081502.10424.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Sun, 8 Jul 2012 15:02:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201177>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Unlike on
> HFS+, Mac OS X files on a VFAT drive (e.g. an USB drive), in
                ^stores?                                  ^s/,//
> precomposed unicode, but readdir() still returns file names in
> decomposed unicode.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
