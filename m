From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 14:05:44 +0200
Message-ID: <m2d3ubojfr.fsf@igel.home>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
	<AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com>
	<4C4BFAA3.3050700@digium.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com>
	<AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F99A@CORPUSMX100A.corp.emc.com>
	<AANLkTilhoF670uZ1WbosZP9TNbXect2A3gELRJL0ZZIn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: lynn.lin@emc.com, kpfleming@digium.com, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 14:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oczxp-0005o7-30
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 14:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab0GYMFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 08:05:48 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46558 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701Ab0GYMFr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 08:05:47 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id E01771C1562D;
	Sun, 25 Jul 2010 14:05:45 +0200 (CEST)
Received: from igel.home (ppp-88-217-114-73.dynamic.mnet-online.de [88.217.114.73])
	by mail.mnet-online.de (Postfix) with ESMTP id AB4341C00097;
	Sun, 25 Jul 2010 14:05:45 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 3804BCA297; Sun, 25 Jul 2010 14:05:45 +0200 (CEST)
X-Yow: My polyvinyl cowboy wallet was made in Hong Kong by Montgomery Clift!
In-Reply-To: <AANLkTilhoF670uZ1WbosZP9TNbXect2A3gELRJL0ZZIn@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 25 Jul
 2010 11:55:39
	+0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151730>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Makefile targets aren't triggered by the include directive.

Umm, yes they are, see (make) Remaking Makefiles.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
