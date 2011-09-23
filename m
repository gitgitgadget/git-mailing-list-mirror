From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: permission to re-license archive-zip.c and zlib.c as LGPL
Date: Fri, 23 Sep 2011 18:34:50 +0200
Message-ID: <4E7CB52A.2090600@lsrfire.ath.cx>
References: <CA+sFfMdzMCJut385jCJ88Z8sUw3E2Bs2A1SiECORQsFJjsb=Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	dpotapov@gmail.com, vagabon.xyz@gmail.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 18:35:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R78iP-0007Ik-8G
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 18:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553Ab1IWQe7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 12:34:59 -0400
Received: from india601.server4you.de ([85.25.151.105]:54528 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab1IWQe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 12:34:58 -0400
Received: from [192.168.2.104] (p4FFD97BD.dip.t-dialin.net [79.253.151.189])
	by india601.server4you.de (Postfix) with ESMTPSA id 0440230C0D9;
	Fri, 23 Sep 2011 18:34:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <CA+sFfMdzMCJut385jCJ88Z8sUw3E2Bs2A1SiECORQsFJjsb=Qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181975>

Am 23.09.2011 05:51, schrieb Brandon Casey:
> To those who have contributed to archive-zip.c and zlib.c,
>=20
> I'd like to make a library for writing zip files.  I really don't see
> another library out there that does it as easily as archive-zip.  So,
> with your consent, I'd like to re-license the code in archive-zip.c
> and zlib.c as LGPL so that I can create an archive-zip library.  The
> reason for LGPL, of course, is so that it can be linked with non-GPL
> code.
>=20
> Please offer your consent to re-license your contributions under LGPL
> by replying to this email.

=46ine with me; BSD or MIT style licenses would be OK as well.

Actually I'm a bit surprised that libarchive didn't grow ZIP write
support by now.

Ren=C3=A9
