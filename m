From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .mailmap: =?utf-8?Q?Ren=C3=A9?= Scharfe has a new email
 address
Date: Wed, 17 Jul 2013 17:56:07 -0700
Message-ID: <7vy5944rfc.fsf@alter.siamese.dyndns.org>
References: <51E6F671.2040005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 18 02:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzcW0-0001xv-JK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 02:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839Ab3GRA4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jul 2013 20:56:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521Ab3GRA4L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jul 2013 20:56:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32FA727C66;
	Thu, 18 Jul 2013 00:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Nufny0eC52aj
	gfy6Gn9AoeA1Z6s=; b=Ar8SXuNmbGCVWcfEx8L41xy3dxY4rX6s24XWiBwU/ass
	QPY84O/sIVJlcSBuBKedjUHmdgwIclxNlbDkzcGGJJ3aPA0/Oa/88mUhslIlNNoe
	aoPAhc7He6cIqpTQCr1+/UCXif80w5fLei6tnvmH7jM3CFZPaN5S7CSHwXRw4eI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Wn4ABa
	GUugX2oNnO2vFdmYL1QtSUTEgVx0uV26Xqc6H08/hzk+XCCsCN6BtTTNdmVVl9TZ
	EYab5o5HM5wufucN9Qa5URCtzHQbk9tYDjBJGI8F/I1TJv7sgaHI8/JPKGP9qf+F
	CcxDhQ3x7f3vzNcJQc9GI+UNEMiXE5jr9RzXE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26DAC27C65;
	Thu, 18 Jul 2013 00:56:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEE3A27C5F;
	Thu, 18 Jul 2013 00:56:09 +0000 (UTC)
In-Reply-To: <51E6F671.2040005@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Wed, 17
	Jul 2013 21:54:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6196222-EF44-11E2-8E38-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230673>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> I failed to log on to the dyn.com website in time and lost my old fre=
e
> DNS entry. :-/

Thanks.

Now the real issue is how we verify this patch is from the real Ren=C3=A9
whose longtime contribution we all appreciate ;-).

>
>  .mailmap | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 345cce6..5c16adf 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -78,7 +78,7 @@ Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
>  Philippe Bruhat <book@cpan.org>
>  Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
>  Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
> -Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
> +Ren=C3=A9 Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
>  Robert Fitzsimons <robfitz@273k.net>
>  Robert Zeh <robert.a.zeh@gmail.com>
>  Sam Vilain <sam@vilain.net>
