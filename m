From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH 00/10] Docs: git tag
Date: Mon, 28 Mar 2011 21:06:08 -0500
Message-ID: <AANLkTi=wEp40mx=g=MhUYSjJN=cF+H+GEvbFyaV_yrot@mail.gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com> <7v8vvzyvdi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 04:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4OKS-0005Su-Kg
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 04:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab1C2CGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 22:06:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50985 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab1C2CGi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 22:06:38 -0400
Received: by iwn34 with SMTP id 34so4318892iwn.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 19:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=uhPxSgjKHGXlHhs3T96zwiZ3TUh/656ugVpnolm76QU=;
        b=e4plIIZnaTUyCYZ8xwhDZBVVy2sIPCBUiovmnq0f4gk6OIIzldAxHHF8DzAe9ILkH9
         dexO87HdOSJQjyXfuBoC7L4P6JtXNehdRYGhncRHc7P7l8e0n09QznvCIplkF5b04H3l
         tBzwhml5lg0xin7CMe2LHF9gxRw1PR8Ug08Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T5sM9PBeZ+Jld8Ffvx851B3MSUwISwNGU6DAqfOfA0HL1WSqsxvcJ7VN2yh6guARkV
         5i7xxxVLBYIIPK4+hO/nQK8C32MfoCXz7JY3V4hyjMc3uOuG9fEtWukGCoQTwO86RHc0
         zNsjmXr7nX0E5FfJ3KXobIhoQFGCpmLKmkqIU=
Received: by 10.43.65.71 with SMTP id xl7mr7002111icb.480.1301364398224; Mon,
 28 Mar 2011 19:06:38 -0700 (PDT)
Received: by 10.42.166.200 with HTTP; Mon, 28 Mar 2011 19:06:08 -0700 (PDT)
In-Reply-To: <7v8vvzyvdi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170216>

On Mon, Mar 28, 2011 at 13:04, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> Small patches fixing up the `git tag' docs.
>>
>> Michael Witten (10):
>> =C2=A0 Docs: git tag: Add `the'
>> =C2=A0 Docs: git tag: peoples back -> people's backs
>> =C2=A0 Docs: git tag: Revise a paragraph.
>> =C2=A0 Docs: git tag: other's -> the other person's
>> =C2=A0 Docs: git tag: Streamline a sentence.
>> =C2=A0 Docs: git tag: Add missing 'the'
>> =C2=A0 Docs: git tag: Use 'who' again
>> =C2=A0 Docs: git tag: Remove superfluous 'with'
>> =C2=A0 Docs: git tag: Use semicolon
>> =C2=A0 Docs: git tag: Rewrite discussion of GIT_COMMITTER_DATE
>
> Thanks; all looked sensible changes, except for 7/10 which I somehow =
find
> the original is more readable than the new text, partly because the
> sentences are shorter but more importantly because the two sentences =
make
> two separate assertions (the first is about what "one-shot" pull mean=
s,
> the second is about why automatic tag following is not desired in tha=
t
> situation).

=46air enough.
