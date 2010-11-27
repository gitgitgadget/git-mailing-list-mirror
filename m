From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: http://tech.slashdot.org/comments.pl?sid=1885890&cid=34358134
Date: Sat, 27 Nov 2010 21:19:00 +0100
Message-ID: <AANLkTi=aCRGNtKxrPLH81H8_NvpBNOmJ-0MHgRms2a3T@mail.gmail.com>
References: <AANLkTinTsn4PP8VxJX=pUOYKtoybCxqB0+-p9kNRGMj8@mail.gmail.com>
	<AANLkTim0FeCE94R1zacOxGiEP8vZRSoDqNuNRUotnd9B@mail.gmail.com>
	<AANLkTima6meFsovFS-15X7CMTD53n=kkvueKrOeN4Yd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 21:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMREj-0003og-Me
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 21:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab0K0UTF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 15:19:05 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63357 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0K0UTC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 15:19:02 -0500
Received: by fxm15 with SMTP id 15so1480301fxm.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 12:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TpuActPQvuo3AiSR0OPVvUFyvsmqK36csCfiJ90bKWY=;
        b=f8n7qlf8aihzoYCs9HkB8mSkeCCi5d6EBLA3TcPhcBebwNdFOx0gVbCCUvNPFdka3o
         aviRsPgq6bdt2JjAZW0l+hVR/IaWQbXRUyITTTbd8dPhz4BuPu5HcelrGTwrBqiD8Um9
         hGGugbjdoQkTgW0bCktMfKNh8wefA/NoS9SK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LXzJfeYkZnj9h+joKkwbiZAsIyCbVdhh7rNLpispXHoyrnEHFXZAoAbOxMzazeWYxV
         Q8bdEDQ50yolzsRnmyyAoCSDp3aF8zn7hFCJCo3BturfY7PXI38N5UNXreLGvRXBky9n
         KwqXjXTHsgM2g6VtrpnDJBMCLhvBVgNdTep0g=
Received: by 10.223.86.129 with SMTP id s1mr3475001fal.144.1290889140421; Sat,
 27 Nov 2010 12:19:00 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Sat, 27 Nov 2010 12:19:00 -0800 (PST)
In-Reply-To: <AANLkTima6meFsovFS-15X7CMTD53n=kkvueKrOeN4Yd4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162327>

On Sat, Nov 27, 2010 at 20:06, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:
> On Sat, Nov 27, 2010 at 6:36 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Sat, Nov 27, 2010 at 18:33, Luke Kenneth Casson Leighton
>> <luke.leighton@gmail.com> wrote:
>>
>>> I believe it is important that git-over-p2p be given a higher
>>> priority than it is at present.
>>
>> We give "priority" to the stuff people submit patches for. There isn=
't
>> a git-over-p2p because nobody is working on it, would you like to wo=
rk
>> on it?
>
> =C2=A0i was / have been. =C2=A0unfortunately it's unfunded work, and,=
 thanks to
> receiving less money than i require for living and for feeding my
> family i now face a court hearing on 16th december (3 weeks time)
> which has the aim and ultimate goal of making us homeless. =C2=A0i
> therefore respectfull request that you please don't try to make me
> feel like i _should_ be working on this in order to "earn your
> respect" ( that goes for you too, johnathon ).

I don't mean to discourage you. But as Jonathan points out this list
is much better suited for submitting patches and discussing technical
details.

I'd be happy to review your patches, I'm very interested in getting
something like this myself. If you've been working on something I'd
love to see it.

And I hope you'll do all-right in your personal life.

>> I'm also not convinced that this is actually needed. It's trivial to
>> set up a p2p-like network by just emulating a darknet by manually
>> adding remotes & fetching/pushing.
>
> =C2=A0ah.. but that's the single-use case for a single shared reposit=
ory.
> git "as-is" the fetch/push over http is limited to a single
> repository. =C2=A0i'm thinking more in terms of a global network, wit=
h
> searches for checksummed objects "accidentally" potentially coming
> from wildly different repositories.

Right, but is there an actual use case for people who are developing
code to use something like git over p2p? Maybe I'm just being
unimaginative, but I can't see a case where people are working on the
same project and can't find a way to push/pull from each other using
the existing methods. Especially since it's easy to sign up for free
Git hosting and use something like Tor to pull/push from there. Or to
set up your own git HTTP server on a Tor *.onion server.

But of course using the Git data format for non-source-code would be
very interesting, and much better for something like git-p2p.

Anyway, sorry about the brief reply. I'm not really knowledgable about
this, and didn't fully grok/read your reply (going out).
