From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Tue, 09 Aug 2011 18:30:17 +0100
Message-ID: <4E416EA9.1010401@ramsay1.demon.co.uk>
References: <1312560614-20772-1-git-send-email-pascal@obry.net> <1312560614-20772-3-git-send-email-pascal@obry.net> <CABPQNSYSzsY-CQdi6iJQftsY1ufMpxkax=eQLgopVxMC6LoxfA@mail.gmail.com> <4E3C29D9.5060305@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Tue Aug 09 20:31:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqr5k-0003Be-PY
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 20:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614Ab1HISbm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 14:31:42 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:39586 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752459Ab1HISbm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2011 14:31:42 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1Qqr5Y-0007UB-YY; Tue, 09 Aug 2011 18:31:41 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4E3C29D9.5060305@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179041>

Pascal Obry wrote:
> Le 05/08/2011 19:29, Erik Faye-Lund a =E9crit :
>> Cygwin is a unix-layer on top of Windows, designed to play by the
>> POSIX-rules. So why would you want to support Windows-style paths on
>> Cygwin?
>=20
> Because cygwin toolset does support \.

Hmm, if you don't mind escaping it in bash all the time!

>=20
>> If you want a Git that handles Windows paths, use Git for Windows...
>=20
> Note that Windows is a special case as even the Win32 API does suppor=
t \=20
> and /, so every tool on Windows seems to handle nicely this. Why not=20
> Git, be it Cygwin/Git. If it does not break anything else.

Hmm, I wouldn't be too sure of that, either ...

ATB,
Ramsay Jones
