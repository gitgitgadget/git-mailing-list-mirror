From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Thu, 22 Jul 2010 20:17:08 +0000
Message-ID: <AANLkTilhKR5wuJPPIF1SiRcTJ0fmz1oqp_NfuSSuKMOn@mail.gmail.com>
References: <4C472B48.8050101@gmail.com>
	<AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
	<4C4778DE.9090905@web.de>
	<AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com>
	<m31vavn8la.fsf@localhost.localdomain>
	<AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
	<20100722195653.GC4439@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 22:17:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc2Cw-0002MV-Ag
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 22:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756272Ab0GVURN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 16:17:13 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55943 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756154Ab0GVURJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 16:17:09 -0400
Received: by gxk23 with SMTP id 23so4857976gxk.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/9yvu/8Xc6Q2hYqPmytf9xXAM46gG9SE2CMIwl16ttI=;
        b=RHR3Ylqjkfj2kgD93hE2XNF+Ao8lYKqcJBpdK4Pt7BC9qUOdZOvmKpLt6xlWjuo1s6
         c7RIzUNGeJYS7T+Di8myBwJEkaiKEf4LIjsy3QNJkFL4vre11+OEmROnhnMp5yG5QFlK
         XyVXKzkVaG9hgom9y7ZLMfq3ttCLIzARWo4OI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HJ9555NFRgOPH8WHXy6L6YoPRnlMl0WZ9avCFpxI1HlINjwgn5gzW5Yoj08Tr+A6HM
         o8Icw3U1wJ60ZTp9oKs0JM3B2/G54+CAV2nXodBMO9G6/uzaCWDkDUlTs/PU5hby7/uM
         Za5C7F41rwq7Ny3hb9KT2R3KkLmrjC5Ji1rHE=
Received: by 10.150.146.9 with SMTP id t9mr4672331ybd.10.1279829828162; Thu, 
	22 Jul 2010 13:17:08 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 22 Jul 2010 13:17:08 -0700 (PDT)
In-Reply-To: <20100722195653.GC4439@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151479>

On Thu, Jul 22, 2010 at 19:56, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Avery Pennarun wrote:
>
>> Unfortunately everything built *on top of* Linus's file format
>> contribution has turned out to be a disaster.
>
> Aside: this kind of statement might make it unlikely for exactly
> those who would benefit most from your opinions to read them.
>
> Well, that is my guess, anyway. =C2=A0I know that I have not found th=
e time
> to read your email (though I would like to) because I suspect based o=
n
> such sweeping statements that it would take a while to separate the
> useful part from the rest.
>
> Of course I am glad to see people thinking about these issues.
> My comment is only about how the results get presented.

Well, it's not like Linus is the image of calmness when attacking
something he perceives as crap design either >:)

Anyway, to answer Bryan's question. My comments in previous messages
shouldn't be interpreted as opposition to git-subtree being merged at
all. It's clearly very useful, especially for cases where
git-submodule is wanting. I'd be happy to review a patch that
integrated it into the Git tree.

But it's also clear that we have a lot of tribal knowledge about the
lackings of git submodule / git subtree. It would be *really* useful
if people like Avery and Jens which have obviously thought hard about
the submodule/subtree issues would draft up some (calmly written) docs
about how the two differ (with comparison tables etc.).

That'd be a very helpful resource for Git users in deciding which one
to use.
