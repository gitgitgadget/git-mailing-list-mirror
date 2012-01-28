From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2012, #06; Fri, 27)
Date: Sat, 28 Jan 2012 19:23:29 +0200
Message-ID: <CAMP44s0FBm3_P--wykHRXROSQLFgmDeVwr2cyEgk33QBfYbdSA@mail.gmail.com>
References: <7vipjwzvc2.fsf@alter.siamese.dyndns.org>
	<7v7h0czur2.fsf@alter.siamese.dyndns.org>
	<7vfwf0xu8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 18:40:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrCFu-0000o9-JH
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 18:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349Ab2A1Ra2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jan 2012 12:30:28 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:54867 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751788Ab2A1Ra1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 12:30:27 -0500
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jan 2012 12:30:27 EST
Received: by lbom4 with SMTP id m4so154272lbo.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 09:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=W+Jbl9VktA7jeR8mstWMy9EYisJB8suVd42FDRHo68I=;
        b=wXNDOaj6e+jeduEOc7Rjexlh00Xx/25e54P0BGFhr3TtfKlGkmhVZYjYrocNADnF2i
         VkB+OXN3hzBrn683XJzz3FCY4oz7nMBV/jIU07cIN6xHPgho47GinzAXJ9Xrj37XbK3c
         h5uRrJGZjweneZyLFtx7YJi3zQOa2on/g33ls=
Received: by 10.112.82.226 with SMTP id l2mr2957786lby.102.1327771409641; Sat,
 28 Jan 2012 09:23:29 -0800 (PST)
Received: by 10.112.10.169 with HTTP; Sat, 28 Jan 2012 09:23:29 -0800 (PST)
In-Reply-To: <7vfwf0xu8a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189258>

On Sat, Jan 28, 2012 at 7:37 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> * mm/zsh-completion-regression-fix (2012-01-17) 1 commit
>> =C2=A0 (merged to 'next' on 2012-01-23 at 7bc2e0a)
>> =C2=A0+ bash-completion: don't add quoted space for ZSH (fix regress=
ion)
>>
>> Will merge early in the next cycle and deal with any fallout in 'mas=
ter'.
>
> This topic has been superseded by Felipe's f15026b (git-completion:
> workaround zsh COMPREPLY bug, 2012-01-25) to use "typeset -h IFS", so=
 I
> should drop this.
>
> Am I mistaken?

That's correct.

--=20
=46elipe Contreras
