From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Mon, 26 Jul 2010 13:34:57 -0400
Message-ID: <AANLkTimAkfgsMLUY5Lhi=-Rd=v5ZkT4_SBd8wxHhG-LR@mail.gmail.com>
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
	<AANLkTilhKR5wuJPPIF1SiRcTJ0fmz1oqp_NfuSSuKMOn@mail.gmail.com>
	<AANLkTil2ZHsV-PH46wfeqqvB27akRw3egDWRtJbIPLXb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 19:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdRa1-0006IN-QW
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 19:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032Ab0GZRfB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 13:35:01 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62715 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0GZRfA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 13:35:00 -0400
Received: by qyk8 with SMTP id 8so2073393qyk.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ucg2gHn0vhjphe1AUP1EqLbZCbV5ouYGxhnMV3QuBQ4=;
        b=YdFmmxF8VlC+/BYOeT5Un/568HyMY5FVFv1LzvNVbzIUgfPD1YgV+JTwU0d1272saL
         3vCUPMGa9bwHXkFpnK9C+sigtnDGqjlLKAMwStz0GqaRmnUO31k6/2RwUK1caUEFqLZh
         3UKho0vutaP+zCrLrCuMYAhCg/y6dKhq+I6Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XHqkCQ/u0rE5GuLs4l8vaSRnAtz2p+sFKTxABhVhLIKNb4NMjkNRaZjNuIBnb5fPYk
         l4CRZaOAq6XVYZnMaK5ZhQeJ44nlQQ2MEINRMpj3vbrjVKKQa7Ezx/DkZeptjROiYoCU
         TZgcIUT7z4h+QKuqnncS4BYKF/AiPFSnXp+bA=
Received: by 10.224.122.11 with SMTP id j11mr6398029qar.247.1280165697588; 
	Mon, 26 Jul 2010 10:34:57 -0700 (PDT)
Received: by 10.229.226.195 with HTTP; Mon, 26 Jul 2010 10:34:57 -0700 (PDT)
In-Reply-To: <AANLkTil2ZHsV-PH46wfeqqvB27akRw3egDWRtJbIPLXb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151860>

On Thu, Jul 22, 2010 at 5:33 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Thu, Jul 22, 2010 at 4:17 PM, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> But it's also clear that we have a lot of tribal knowledge about the
>> lackings of git submodule / git subtree. It would be *really* useful
>> if people like Avery and Jens which have obviously thought hard abou=
t
>> the submodule/subtree issues would draft up some (calmly written) do=
cs
>> about how the two differ (with comparison tables etc.).
>>
>> That'd be a very helpful resource for Git users in deciding which on=
e
>> to use.
>
> I think I'm too biased to write that, but if someone else wants to
> take the lead, I could certainly contribute.
>
> Have fun,
>
> Avery


I personally tried to understand submodules, but my attempts to find
easy way to use them have failed miserably;) probably i have to spend
even more time in order to understand if i can benefit from them or
not. So, i think this kind of comparison would be very beneficial for
"mere mortals"

I would like to share an idea how it can be organized:

We could create a file in doc section of git.git or in Avery's repo
named git_submodule_vs_git_subtree or just use a separate topic of the
list.

The file would look like this:

git-submodule |           feature                  | git-subtree
______________________________________________________________________
     +        | ability to tag submodule without   |     -
   (comments) | tagging the whole tree             |  (comments)
______________________________________________________________________


Avery and Jens could add features they think are beneficial for one
project or another and answer to each other this way. They could mark
just presence or abscence of the feature by +/- like above or specify
key approaches how to do different things.
=46or example, how to configure new submodule (main sequence of command=
s
to create, add ), how to do that with sub-tree...

I think this simple feature matrix will answer a lot of questions.

just my 2 cents...

Thanks,
Eugene
