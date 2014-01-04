From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] Improve user-manual html and pdf formatting
Date: Sat, 4 Jan 2014 22:12:00 +0000 (UTC)
Message-ID: <loom.20140104T230716-552@post.gmane.org>
References: <352636633.1492236.1388826471175.JavaMail.ngmail@webmail10.arcor-online.net> <20140104211834.GC12251@google.com> <loom.20140104T223713-502@post.gmane.org> <87lhyv5s79.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 04 23:12:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzZSI-0005w1-Oy
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 23:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbaADWM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jan 2014 17:12:27 -0500
Received: from plane.gmane.org ([80.91.229.3]:45086 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754416AbaADWM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jan 2014 17:12:26 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VzZSC-0005jW-CZ
	for git@vger.kernel.org; Sat, 04 Jan 2014 23:12:24 +0100
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jan 2014 23:12:24 +0100
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jan 2014 23:12:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239948>

Andreas Schwab <schwab <at> linux-m68k.org> writes:

> > That's a Unicode Byte Order Mark.
>=20
> No, its an ampersand, a hash, a number and a semicolon.  Definitely n=
ot
> a BOM.
>=20
> Andreas.
>=20

You're right, of course :) I was a bit hasty.

#65279; is a HTML entity (or at least something like looks like one) fo=
r the
character U+FEFF, which also serves as the Byte Order Mark. I assume th=
e
entity was added to the file by mistake.

=C3=98sse
