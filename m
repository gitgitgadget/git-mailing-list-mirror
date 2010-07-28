From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH] SubmittingPatches: Cite the 50 char subject limit
Date: Wed, 28 Jul 2010 12:49:51 -0700
Message-ID: <7861092D-582B-4918-AF3D-BF595B195673@gmail.com>
References: <1280326285-10203-1-git-send-email-avarab@gmail.com> <7vzkxb4j1v.fsf@alter.siamese.dyndns.org> <AANLkTimieHJaw1UmKtQvS4=2i8TrmR5A5zFO13NaNBo=@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 21:50:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeCdd-0007qb-KH
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 21:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab0G1Tt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 15:49:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34108 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab0G1Ttz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 15:49:55 -0400
Received: by pvc7 with SMTP id 7so1056473pvc.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 12:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=ljC/IfNDquY+qW4gMQINxHWFnX611dw9ZwT+6k07B84=;
        b=LGO7RX7j7qWTObxJ3OrE2JIk8BziBwudbIzSbBjXqKctR3Tac/tP1/6vqi9qTZ13uX
         w5gNytiUq7O5DbMwCmtZUdNboVhpFVwhkl9sggEWsXrxdW6rxUxFurkyRRitDBucfyWp
         VKg7maL0U0Rx+7iiCgEi+JUgahtWwQ/PyXnmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=QVFHY9jYvl4fHZH19CdjvG+ZbRKq7eQ1g9mW1dXqmI8zcddujSpsbioSXQn2yVtxCD
         FEurLxUf+E2EmByHJch/uXoH5O9fq0D8oO9+++qXcw+t9AyOm+kgE36Oko9+RJ4CUcY4
         8SwlQpPhIQlnveSlyRnsiCDrJKXjOsjxf5Pjk=
Received: by 10.114.60.6 with SMTP id i6mr16102807waa.149.1280346595346;
        Wed, 28 Jul 2010 12:49:55 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id x9sm11732456waj.15.2010.07.28.12.49.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 12:49:54 -0700 (PDT)
In-Reply-To: <AANLkTimieHJaw1UmKtQvS4=2i8TrmR5A5zFO13NaNBo=@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152115>

On Jul 28, 2010, at 12:25 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Wed, Jul 28, 2010 at 17:23, Junio C Hamano <gitster@pobox.com> =20
> wrote:
>
>> Hmph, we probably would want to do s/50 character/&s/ in the two =20
>> manual
>> pages.
>
> I'm not sure if "with a single short (less than 50 character) line" i=
s
> is grammatically correct with "characters", since "characters line"
> wouldn't make sense.
>
> On the other hand that sentence violates the rule that when you put
> something in parens your sentence should still make sense with
> s/[()]//g, "a single short less than 50 character line" is pushing it=
=2E

If the number of characters is less than 50, then there are fewer than =
=20
50 characters.

This is a short line of fewer than 50 characters.

Cheers,
Josh
