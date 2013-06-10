From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Mon, 10 Jun 2013 10:42:08 -0700
Message-ID: <7vzjuxj21b.fsf@alter.siamese.dyndns.org>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B5D9A1.1080900@ensimag.fr> <vpqhah6hxjm.fsf@anie.imag.fr>
	<robbat2-20130610T162316-152176477Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:42:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um66j-0000NF-D4
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab3FJRmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 13:42:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751Ab3FJRmM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 13:42:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5DD726463;
	Mon, 10 Jun 2013 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DUb0eFiwUsrw
	PHwH4ZnU1S2Iv5I=; b=WivI0JvbQhql+EIceIvLllRz66q5lRSxCkF5CS6yqA07
	DcFZm+g0ZKbQxX6lGHlbIzYdVrG1jcZfSVnLrnagD10RmxjfxmOPZ5EarXEvvPZ3
	+RFz/2mrtkysy6QbBhvVWX3egHCTe9GefpVCwStNWdvIabdknMN1Bt4oZhVtAsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fQFFun
	Ta3YftsNdvIQS07aGl764i/SedH+NnG3wgHqIOFDomEvmMvsNr4qGoe56kLII3L4
	2meIwq6IFkUMuKP+yRDpsEXfWtopRVQxaqRCxNF2vOdZ6yY/NFcWilgoMgZG39fy
	2dleZF7BAOvOgw9+yPuCBnZoEPz4r78HFw4jo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA47F26462;
	Mon, 10 Jun 2013 17:42:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4975A2645B;
	Mon, 10 Jun 2013 17:42:10 +0000 (UTC)
In-Reply-To: <robbat2-20130610T162316-152176477Z@orbis-terrarum.net> (Robin
	H. Johnson's message of "Mon, 10 Jun 2013 16:25:05 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13C03744-D1F5-11E2-AFEC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227333>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> On Mon, Jun 10, 2013 at 04:04:29PM +0200,  Matthieu Moy wrote:
>> C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:
>>=20
>> > Le 10/06/2013 15:28, Ramkumar Ramachandra a =C3=A9crit :
>> >> 0. You do not take offense, no matter what.  If someone attacks y=
ou
>> >> irrationally, you do not respond.  This is a public mailing list,=
 and
>> >> we are all rational people: the attacker has already humiliated
>> >> herself in public, and everyone can see that.
>> >
>> > "Herself"?
>> > Typo I guess :)
>>=20
>> Not necessarily. It's quite common in english to use "she" when the
>> gender is not known.
> Could you please use "themself" instead?

I think "himself or herself" is the politically correct form ;-)

But more seriously.

The intent behind the document might be a noble one, but I am afraid
that the text is too broad and vague and does not address the real
issue to be of practical use.

Taking one bullet point from the top for example:

    0. You do not take offense, no matter what.  If someone attacks
    you irrationally, you do not respond.  This is a public mailing
    list, and we are all rational people: the attacker has already
    humiliated herself in public, and everyone can see that.

What does saying "we are all rational people" help when "the
attacker" poses a risk to destroy the community?  What does "we are
all rational people" even mean in this sentence?

It does not address the real cause of flamewars---why do rational
people feel the need to respond when an irrational comment is made,
e.g. when a reasonable review comments were responded not with
either "Yeah, you are right, thanks." or "Not really, because you
missed this case, I think..."  but with nitpicks with immaterial
details or repetition without justification that takes account that
the reviewer is in disagreement and there must be some reason behind
it, i.e. a poisonous behaviour?

I suspect it mostly has to do with the desire to make sure that
bystanders do not get an impression that the one who speaks last
gives the conclusion to the discussion, so stating "The attacker
being the one who speaks last in the discussion does not mean the
conclusion is his." explicitly might be one way to make it more
practically useful by alleviating the urge to respond, instead of
saying "no matter what".

I dunno.
