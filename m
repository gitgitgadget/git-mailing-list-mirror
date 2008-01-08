From: Remi Vanicat <vanicat@debian.org>
Subject: Re: git and unicode
Date: Tue, 08 Jan 2008 16:09:35 +0100
Message-ID: <87fxx8uzf4.dlv@vanicat.homelinux.org>
References: <C3A86A49.10AEF%jefferis@gmail.com>
	<47835A02.80404@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gonzalo =?utf-8?Q?Garramu=C3=B1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Tue Jan 08 16:17:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCGCl-0002bD-Kt
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 16:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbYAHPRB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2008 10:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbYAHPRA
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 10:17:00 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:39701
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754529AbYAHPRA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Jan 2008 10:17:00 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2008 10:16:59 EST
Received: from neuf-infra-smtp-out-sp604002av.neufgp.fr ([84.96.92.126])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id aezo1Y0082jakD80701g00; Tue, 08 Jan 2008 16:09:47 +0100
Received: from vanicat.homelinux.org ([80.118.117.216])
	by neuf-infra-smtp-out-sp604002av.neufgp.fr with neuf telecom
	id af9c1Y0094gCrHc0200000; Tue, 08 Jan 2008 16:09:47 +0100
Received: from moi by vanicat.homelinux.org with local (Exim 4.68)
	(envelope-from <remi.vanicat@laposte.net>)
	id 1JCG59-0007C4-S2; Tue, 08 Jan 2008 16:09:35 +0100
In-Reply-To: <47835A02.80404@advancedsl.com.ar> ("Gonzalo =?utf-8?Q?Garram?=
 =?utf-8?Q?u=C3=B1o=22's?= message of "Tue\, 08 Jan 2008 08\:09\:54 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: remi.vanicat@laposte.net
X-SA-Exim-Scanned: No (on vanicat.homelinux.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69884>

Gonzalo Garramu=C3=B1o <ggarra@advancedsl.com.ar> writes:

> Forking a little from the recent CR/LF thread, I was wondering how
> does git deal with unicode files?
>
> Most scripting languages (ruby, python, etc) are now allowing their
> source code to be written in unicode (UTF-8, usually).  Will git
> incorrectly categorize those source files as "binary"?
>
>
> --=20
> Gonzalo Garramu=C3=B1o
> ggarra@advancedsl.com.ar
>
> AMD4400 - ASUS48N-E
> GeForce7300GT
> Xubuntu Gutsy

--=20
R=C3=A9mi Vanicat
