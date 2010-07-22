From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Thu, 22 Jul 2010 16:06:02 -0400
Message-ID: <AANLkTinI6uOQyJcJvbNLhNde8yURyQMSua438TZQKyXv@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<20100722195653.GC4439@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 22:06:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc22K-0004ca-7d
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 22:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab0GVUG1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 16:06:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55298 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0GVUG0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 16:06:26 -0400
Received: by wyf19 with SMTP id 19so947052wyf.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/C7KcrbcMKPm3B1lIlmw48wWGiS0wsZkUTDQXGL0EsI=;
        b=nEY+v93fdZnWK8Tvlslcy0+31HtIhzoMLl5GW152aLnmB0xrENqj5hHGuLSp4SHVT/
         Hl69wRkCW3XR3cspDqNL7NH8oXCm5o1WkkjFglA+ukVVB9B8fUb6dFyN8ZnmcfgGquxI
         ClBODoZzBLGMvey4wbxQL1N9xCQwf0qfw7qZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VeU9MmKU9QXESqEBm5bdpsmrnOhY4movO4uEt5eMGaTseCystNjEVJCLYIJgwAfGks
         93+zjRlvqhGH4UME3+jrz/J9pQ0BIcaYnN29GI8Njz5+R3yIwt3t2avkLBOvYU9KXJIN
         JkChWkyauWTfUkZv7Ed3fVeggb10D7syGEAkk=
Received: by 10.227.154.196 with SMTP id p4mr2389063wbw.195.1279829184035; 
	Thu, 22 Jul 2010 13:06:24 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Thu, 22 Jul 2010 13:06:02 -0700 (PDT)
In-Reply-To: <20100722195653.GC4439@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151477>

On Thu, Jul 22, 2010 at 3:56 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Avery Pennarun wrote:
>> Unfortunately everything built *on top of* Linus's file format
>> contribution has turned out to be a disaster.
>
> Aside: this kind of statement might make it unlikely for exactly
> those who would benefit most from your opinions to read them.
>
> Well, that is my guess, anyway. =A0I know that I have not found the t=
ime
> to read your email (though I would like to) because I suspect based o=
n
> such sweeping statements that it would take a while to separate the
> useful part from the rest.

Unfortunately you will find that the rest of my email more or less
just expands in detail on those sweeping statements.

Sorry.

Avery
