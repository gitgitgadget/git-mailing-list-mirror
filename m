From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Johannes misbehavior in the wiki, and a request for admin rights 
	(was: wiki "abuse")
Date: Tue, 10 Aug 2010 20:54:45 +0300
Message-ID: <AANLkTin9Pnugt4NS_gwHoUsKvFur7CvowdR9Aqkuu6h7@mail.gmail.com>
References: <AANLkTinYqFMZe=ahgyaW-cYJXuBanvCU1A6AYVcVcrPB@mail.gmail.com>
	<4C613DFC.40006@drmicha.warpmail.net>
	<20100810123349.GA3921@kytes>
	<AANLkTi=4fhCMPGvO_zd_hmwXSG3wckJA8vTYwWFMEstx@mail.gmail.com>
	<AANLkTini7xKkncXxjv=p32PupR4W2FP3Rqm2atnsV1Q_@mail.gmail.com>
	<AANLkTinktAhPz_zp6Hf7yanxbn4FougPZwQj9msAXUvk@mail.gmail.com>
	<20100810161940.GF3921@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Hawley <warthog9@kernel.org>, git <git@vger.kernel.org>,
	Daniele Segato <daniele.bilug@gmail.com>,
	Valeo de Vries <valeo@valeo.co.cc>,
	"Amir E. Aharoni" <amir.aharoni@mail.huji.ac.il>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 19:54:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oit2L-0001zC-7Z
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 19:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408Ab0HJRyt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 13:54:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49728 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab0HJRyr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 13:54:47 -0400
Received: by bwz3 with SMTP id 3so2081199bwz.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tkXvKXsPzKyN1DOO0vuX2rqYm0hKP+weLU7WQ7yESs0=;
        b=HKohX7a6QZ3XyJsKlBbKEU0o2hLMnNxMw6PIw7Yhuo1GbEmzTHNGe8C8iW9rI+x5+p
         auAhhbpkN+hx5zsYbCzijw0fmYryxjdHtrfnfN8V/dBUhH0B0TbGujDTVnP9rUNP2hnJ
         bnHFRNYAp+VeY26VoW2FoXWuxkif/78jq/Sew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oswpojnTYA1m26yfptPFnvXuqtyMKqqKCgXnxVlKe/YsFfdczI44h67qPDREhmbVAf
         FzVGsKBmcf2UH3QEgTdYG4QslsP1emgJrjQLJNwJcmV/vIQTNI+L0bUFBeKbrYw2CS3o
         aQ8Lwr1GulRk8EOjjZuS6uHNyYeEnYihZ0Mc4=
Received: by 10.204.55.211 with SMTP id v19mr2828054bkg.153.1281462886014; 
	Tue, 10 Aug 2010 10:54:46 -0700 (PDT)
Received: by 10.204.122.143 with HTTP; Tue, 10 Aug 2010 10:54:45 -0700 (PDT)
In-Reply-To: <20100810161940.GF3921@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153134>

On Tue, Aug 10, 2010 at 7:19 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe writes:
>> I don't think it's a single incident:
>> Dscho blocked Amire80 (infinite, account creation blocked) (Spamming
>> links to external sites)
>
> Okay. I hope you get the point- we didn't have Johannes being pulled
> up like this before, atleast after I joined the community.

That doesn't mean there aren't other cases like this. The affected
users might have decided to give up, instead of contacting the mailing
list (possibly understandable considering the heat Amir received).

>> How exactly? How do we as a community ensure that Johannes is not
>> going to ban people unfairly? I haven't seen any acceptance of bad
>> behavior, nor have I seen any hint as to what he will do the next ti=
me
>> something like this happens.
>
> The current issue is solved. Johannes apologized, Amir apologized and
> I apologized on behalf of the community. Everyone is happy. The first
> step towards correcting a problem is recognizing it- we have succeede=
d
> in doing that and resolving it amicably.

Yes, the original problem has been resolved, but it's not clear what
will happen the next time. There have been many constructive
suggestions, and I haven't seen Johannes comment on any of them.

I've just created a page for people to comment:
https://git.wiki.kernel.org/index.php/WikiIdeas#Stop_immediate_blocking

> Sverre Rabbelier writes:
>> On Tue, Aug 10, 2010 at 09:16, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > How having more than one admin is distasteful?
>>
>> No, the way you are treating this is.
>
> It's okay to have another admin- I don't think anyone opposes the
> idea. Just that I think it's a little inappropriate to have a proposa=
l
> for it in an email with the current admin blamed in the subject
> line. If the need for another administrator is felt, we can start a
> new thread with some suitable candidates and decide amicably keeping
> Johannes in the loop. The purpose of the administrator should not be
> to "attack", but rather work with Johannes, helping him cope with the
> work load. I'm sure Johannes would be happy to have someone else
> working with him as well :)

I think it's not healthy for the second maintainer to always pat in
the back the first maintainer; constructive criticism is needed.

Even Johannes has accepted that he misbehaved, so I don't think I did
anything wrong on pointing the truth.

> Avery Pennarun writes:
>> Right now, whether or not Johannes has done the right thing has been
>> called into question and is resulting in such an angry thread *only*
>> because it's impossible to verify what has actually been done. =C2=A0=
When
>> people can verify what happened - which in this case just means
>> looking at the deleted pages - then trust is possible and easy.
>
> :)

I'm not going to go into details as why I think no warning was issued,
just that we need this:
https://git.wiki.kernel.org/index.php/WikiIdeas#Allow_users_to_see_dele=
ted_pages

>> Most social problems come from the social environment, not individua=
l
>> people's actions. =C2=A0In this case, the social environment (wiki
>> settings) have been configured explicitly to cast doubt on Johannes.
>> It was an accident waiting to happen, and it finally happened.
>
>> The proposal to add a second admin to the wiki - or at least make
>> deleted pages visible to one other person - is not about Johannes.
>> It's about creating a healthy social environment that allows people =
to
>> relieve their suspicion before they let it get out of control.
>
>> So far, all the counterarguments have been of the form, "But Johanne=
s
>> is a good guy, so we don't need to check on him." =C2=A0That's an in=
valid
>> argument, because the real proposal (modulo the stupid subject line =
of
>> this thread) is not about Johannes at all. =C2=A0Checking on him isn=
't
>> about preventing him from being an idiot, it's about preventing
>> everyone else from being an idiot. =C2=A0Which I think we can all ag=
ree at
>> this point, would have been nice.
>
> Very nicely put- I have to agree. We have to stop blaming Johannes an=
d
> start blaming ourselves and work towards a solution together; example=
:
> have one more admin.

Definitely:
https://git.wiki.kernel.org/index.php/WikiIdeas#More_admins

--=20
=46elipe Contreras
