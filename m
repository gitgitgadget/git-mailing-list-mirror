From: Jan Koprowski <jan.koprowski@gmail.com>
Subject: Re: web-based client for Git, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 17:52:34 +0100
Message-ID: <c41cd75d1002120852m350f74f2ucae14c1f831277d4@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
	 <201002120502.43565.chriscool@tuxfamily.org>
	 <e72faaa81002120222p19db9c75u737e2615c14930b1@mail.gmail.com>
	 <e72faaa81002120226y5e4b1c28tbaf6a7dccb9634dc@mail.gmail.com>
	 <alpine.DEB.1.00.1002121149470.20986@pacific.mpi-cbg.de>
	 <20100212113538.GV9553@machine.or.cz>
	 <e72faaa81002120355t4c8596d0q66da4aeb4cce3a94@mail.gmail.com>
	 <20100212121844.GK4159@machine.or.cz>
	 <d411cc4a1002120714p49d26594ubf279d03295d24bc@mail.gmail.com>
	 <20100212164507.GM4159@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 17:52:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfyl2-00070X-5L
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 17:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260Ab0BLQwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 11:52:36 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:57266 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757240Ab0BLQwf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 11:52:35 -0500
Received: by bwz4 with SMTP id 4so2993599bwz.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 08:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jhJQ7ubLl7hVPE8KuYoAxZKC2EIoAXMTr1hELexa/ZA=;
        b=V1n7rK1sa9xiTNfquz4a/sKp3friujJ5TzNXFGyu8Q3r5Ywgh9CkhqVmyBkNGIFHzw
         Q4MimHgpAkIckGS1hlp9wORICmleSTxnpNABOQ+cedQ3H4qytpU0UJlzdCoNOheMw/nH
         zZQXcEGASBPAvUr10JUfLT5l7AMVNu8UByU3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TzoFhllwA5OHVpybDM9FQFOQzeRXfZ0aaSw1PvnI23f4F0CZnqaa/EpNcHN8Ncas/v
         opb3lI3wJyTn/QLcrPB0WtRndV7Z1Y+Rh9j32PG5RJDSomn553FuScOdnXN5hjpv8iA4
         2cn54vsz4tE7qsr3Bm03Q2Uy7eZuYQJFCZcxo=
Received: by 10.204.137.1 with SMTP id u1mr950751bkt.151.1265993554425; Fri, 
	12 Feb 2010 08:52:34 -0800 (PST)
In-Reply-To: <20100212164507.GM4159@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139726>

2010/2/12 Petr Baudis <pasky@suse.cz>:
> On Fri, Feb 12, 2010 at 07:14:58AM -0800, Scott Chacon wrote:
>> Hey,
>>
>> On Fri, Feb 12, 2010 at 4:18 AM, Petr Baudis <pasky@suse.cz> wrote:
>> > =C2=A0P.S.: I could volunteer to mentor such a project, if no more=
 active
>> > Git hacker shows interest. Perhaps Jakub Narebski might be interes=
ted?
>> >
>>
>> I would also be happy to help with this project - it sounds very
>> interesting and Python/web-dev stuff is something I can actually hel=
p
>> with.
>
> Ok, I don't actually know too much about web-dev in Python (actually
> fairly little ;-), so you would certainly be better choice!
>
> --
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Petr "Pasky" Baudis
> A great many people think they are thinking when they are merely
> rearranging their prejudices. -- William James
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

In my opinion library Werkzeug (http://werkzeug.pocoo.org/) may be a
good point of start searching simple and extremely lightweight base of
application.
This is good option when Django is too heavy.

--=20
><> Jan Koprowski [696775174] GSM
