From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 21 Aug 2011 19:13:26 -0700
Message-ID: <CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
	<7vvctvdf5r.fsf@alter.siamese.dyndns.org>
	<CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
	<CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
	<CAE1pOi2r9DT3Y-GxivTZRaNVi=qLOy5=QpQ-_YysOkgqy3iGRQ@mail.gmail.com>
	<CAMOZ1BvpnP_729YOHrrPW3B8wa5c4cLyD_qAQ5rTuy0JqNiiXg@mail.gmail.com>
	<CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
	<CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com>
	<CAE1pOi0b2w8t53U7PSvVwVxZF9O0HTyfCR4vy+-baBjqCDeNJA@mail.gmail.com>
	<CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
	<CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
	<CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 04:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvK31-0001Oz-85
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 04:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620Ab1HVCN1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 22:13:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63005 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550Ab1HVCN1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 22:13:27 -0400
Received: by yxj19 with SMTP id 19so3226643yxj.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 19:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Nz4tBKbUP8m40Ek5KTN3OhrAuCocX5NiZDVC9iZJcXo=;
        b=uQ1Y4wsA+1FQY5z2M14jWZPzo+MN882xaVqohNa179U/dnpxv5sUJJZbqjYqCGzitU
         WCTnR+Aljn77/CVBiCdkDDqXvMRU5d4FsKhFo5lGEO8ThVHtkOTXGSjlx6+k8SN7Ul2o
         CuU6XWhEpYEA5nmC7wbqpSHImci4Qjys/idHg=
Received: by 10.236.145.130 with SMTP id p2mr10377250yhj.125.1313979206405;
 Sun, 21 Aug 2011 19:13:26 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Sun, 21 Aug 2011 19:13:26 -0700 (PDT)
In-Reply-To: <CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179833>

On 21 August 2011 19:05, Michael Witten <mfwitten@gmail.com> wrote:
> On Mon, Aug 22, 2011 at 00:47, Hilco Wijbenga <hilco.wijbenga@gmail.c=
om> wrote:
>> On 21 August 2011 17:07, Michael Witten <mfwitten@gmail.com> wrote:
>>> On Sun, Aug 21, 2011 at 23:35, Hilco Wijbenga <hilco.wijbenga@gmail=
=2Ecom> wrote:
>>>> On 21 August 2011 16:06, Michael Witten <mfwitten@gmail.com> wrote=
:
>>>>> On Sun, Aug 21, 2011 at 21:37, Hilco Wijbenga <hilco.wijbenga@gma=
il.com> wrote:
>>>>>> On 21 August 2011 13:53, Michael Witten <mfwitten@gmail.com> wro=
te:
>>>>>>> On Sun, Aug 21, 2011 at 13:42 -0700, Hilco Wijbenga
>>>>>>> <hilco.wijbenga@gmail.com> wrote:
>>>>>>>> Isn't a branch simply a way to track changes separately?
>>>>>>>
>>>>>>> Well, what does that mean, really? You can certainly use branch=
es to
>>>>>>> help you achieve that goal.
>>>>>>
>>>>>> It means my commits are chained together separate from, say, mas=
ter.
>>>>>
>>>>> Well, that's not what a git branch provides in general.
>>>>
>>>> Er, so what *does* a Git branch provide then?
>>>
>>> I think my other replies (including the link) repeat myself quite e=
nough.
>>>
>>> A branch is just a pointer. That's it.
>>>
>>> Quit saying `branch' to yourself. Start saying `pointer' or
>>> `reference' or `commit label' or even `special tag'.
>>
>> :-) Again, we are going in circles. I *know* a branch is just a
>> pointer. So what? To me, that's just the implementation. Why is that
>> relevant? What am I missing?
>
> You're missing (or, rather, ignoring) the fact that what is called a
> `branch' in git is exactly what is intended to be called a `branch' i=
n
> git; it is not merely an incomplete or weak implementation of
> something.
>
> You're probably also missing the fact that I'm simply arguing the
> point that the term `branch' was a TERRIBLE choice, and your remarks
> and confusion have confirmed that. Other than that, most of what I'm
> saying has very little relevance to what you're trying to do; I was
> following a philosophical tangent inspired by this thread.
>
>>>>>> I feel like we're talking in circles. I get (and even agree with=
) what
>>>>>> you're saying but I don't see how it changes the concept of a br=
anch.
>>>>>>
>>>>>> In any case, what I'm more interested in is knowing whether we c=
an
>>>>>> (optionally) add state (i.e. untracked/ignored files and unstage=
d
>>>>>> changes) to a branch.
>>>>>
>>>>> No, because a branch doesn't IN ANY WAY provide the structure for=
 that
>>>>> kind of thing.
>>>>
>>>> Obviously, we'd need to expand that structure.
>>>>
>>>> I tried (ab)using git stash to get what I want but it ignores
>>>> untracked/ignored files (not a big surprise, of course). It seems =
the
>>>> functionality is almost there. If I could just combine git checkou=
t
>>>> with git stash (and have it work with untracked/ignored files) in =
a
>>>> script or alias, I'd be a happy camper. I'll have to give it some =
more
>>>> thought.
>>>
>>> This cobbling together of git's components for this purpose is
>>> actually a fairly frequent story on this list. Either git does inde=
ed
>>> need something more substantial as a `branch', or people (meaning y=
ou)
>>> need to change the way they think (and I'm not sure which solution
>>> would be best, honestly).
>>
>> I don't think that changing the way I think would be very effective.=
 I
>> still have to get my work done. And I don't want build artifacts fro=
m
>> one "pointer" ;-) leak into the working directory of another "pointe=
r"
>> just because I changed "pointers". (I'm sorry, "pointer" just doesn'=
t
>> work for me.)
>
> It doesn't make any sense to say `artifacts from one "pointer"'. You
> are now, unfortunately, just using the term `pointer' like the term
> `branch'; you are refusing to let go of the concept that the word
> `branch' alone has seared into your brain.
>
> As has been my entire point: You have been corrupted by the wrong
> choice of words.
>
>> How is this normally resolved? What do the Linux kernel developers d=
o
>> when changing or creating a branch? Do they do some sort of "clean"
>> first?
>
> Perhaps `git clean' would be of use to you.
>
>> And I'm getting quite close with "git ls-files -io --exclude-standar=
d
>> --directory". :-) The cobbling-together-of-components approach looks
>> promising. ;-)
>
> Hence what I said earlier:
>
> =C2=A0Of course, you could use what git calls a 'branch' in order
> =C2=A0to implement what you imply is a 'branch', but git's concept
> =C2=A0of a branch and your concept of a branch are not at all the
> =C2=A0same concept (which is why the term 'branch' is so
> =C2=A0unfortunate).
>
> However, please note that your solution is not completing the
> implementation of branches in git, but rather using git's branches to
> implement something entirely different (and which you think should be
> called `branches'). The terminology is the key point in the confusion=
=2E
> I dare say, had git's branches been instead called `pointers' or the
> like, then you would have just gone about the business of implementin=
g
> your `branches' on top of them without thinking twice.
>
>>> If there is a change, then what is currently called a `branch' shou=
ld
>>> be renamed explicitly to `pointer' or a `reference' or something li=
ke
>>> that.
>>
>> Quite possibly but it seems to me that this is too low level. I thin=
k
>> there are already too many places where Git's implementation leaks
>> into its API. E.g., anything explicitly related to the index.
>
> Git's power is its simple conceptual basis, and what you are calling
> low-level is in fact just the ability to deal within the language of
> those simple concepts.
>
> Git's weakness is that the most public interface shoehorns that simpl=
e
> conceptual basis into not just a more automated system, but into a
> weaker model that works well most of the time, yet fails and even
> corrupts the mind of the user when it comes to more interesting
> scenarios.
>
> What you call a leaky abstraction is not the `low-level' conceptual
> basis peeking through innappropriately. Rather, it is the falling
> apart of the shoddy `higher-level' facade.
>
>>>>> Of course, you could use what git calls a 'branch' in
>>>>> order to implement what you imply is a 'branch', but git's concep=
t of
>>>>> a branch and your concept of a branch are not at all the same con=
cept
>>>>> (which is why the term 'branch' is so unfortunate).
>>>>
>>>> You've completely lost me. You may very well be right but all I se=
e is
>>>> that you're pointing out how branches are implemented in Git.
>>>
>>> That last sentence and your earlier sentence:
>>>
>>>> Obviously, we'd need to expand that structure.
>>>
>>> vindicate everything I've said about the choice of nomenclature. Th=
e
>>> term `branch' is a TERRIBLE choice.

Thanks for sticking it out. :-) That all makes sense. I think it's all
pretty clear now.
