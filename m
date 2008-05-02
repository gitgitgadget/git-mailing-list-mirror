From: Wincent Colaiuta <win@wincent.com>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 18:13:38 +0200
Message-ID: <7D1C3FC4-9FC0-49E5-929C-CDEF5FAD3D02@wincent.com>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org> <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org> <807E185B-BEE5-4AAF-8DF4-EE597681D61C@wincent.com> <20080502123656.GA2680@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 18:15:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrxuW-0000cV-Mn
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 18:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758655AbYEBQOM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 12:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759028AbYEBQOK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 12:14:10 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:51029 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758351AbYEBQOK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 12:14:10 -0400
Received: from cuzco.lan (228.pool85-53-21.dynamic.orange.es [85.53.21.228])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m42GDcIm003519
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 2 May 2008 12:13:41 -0400
In-Reply-To: <20080502123656.GA2680@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81009>

El 2/5/2008, a las 14:36, Jeff King escribi=F3:
> On Fri, May 02, 2008 at 12:34:10PM +0200, Wincent Colaiuta wrote:
>
>> But evidently given that there has been so much backlash against the
>> patch the only way to keep everyone happy will be to make this
>> configurable.
>
> Agreed.
>
> But I wonder why there seems to be such a split between people who
> clearly have short git-status output, and those who have long git-=20
> status
> output.

I generally try to work on one thing at a time and keep the status =20
output short -- and I imagine that that's the way most people work -- =20
but there are certain things where long output is going to be =20
unavoidable, like renaming a directory with lots of files in it. And =20
when that happens, seeing only the bottom of the "git status" output =20
and not the top is not what I want 100% of the time.

Cheers,
Wincent
