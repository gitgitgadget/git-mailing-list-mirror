From: Stefan Beller <sbeller@google.com>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Tue, 7 Apr 2015 08:53:47 -0700
Message-ID: <CAGZ79kYLXk8bX2inGANzB_2rkj_FWN_q=b6AVh_jHssk+PHOdA@mail.gmail.com>
References: <20150224220923.GA23344@peff.net>
	<CAEcj5uV7XpXZTEyDrubXfWoN5uYn5BJbGaMbrWrmXbmgiCOHqg@mail.gmail.com>
	<CAP8UFD2rtxL29TqkxFXyGwW4g96TgFFLDJhhyYuAi850p64OjQ@mail.gmail.com>
	<CAGZ79kat=W2mod_c8u2ojUG08faw8KU5N5BDeBLvJ4iOUv_=bQ@mail.gmail.com>
	<CACBZZX5mZgHxicZGTGsgAxBCZuRymrariAeHK0vf5+Qs1EzA2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 17:54:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfVpA-0005k0-QA
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 17:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbbDGPxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 11:53:52 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35625 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbbDGPxs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 11:53:48 -0400
Received: by ierf6 with SMTP id f6so50547933ier.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hvE0rz/t2LI//eFIw9Sa4p8lYcbHze/YHpTFyg9y1FU=;
        b=Y/0p0VDYgcEifzAGVXMFX0PyTGjW11VnD78R9+bFoqWRTh4W7jKV9JhpOWNiGPyHWt
         Vw6UQTt5pn7r40LD8kj7J5kE3k1w8H8YSToMaGHj07QgK5rQ2uKVQnpHHuZVRo8Biup4
         hUPuK5hooF+L51myIgBTjdEiW91Wd6JtlmyaX1x6UEKIlTjUsxPDllucYsuIX6WoQZhR
         +Gz2pnlHbcG5m4HHqmfZtL8HuyvOmgJAo6Isvwq8ntfHqZfJoxQKIUjgmyxbBmqm+jE0
         hKtW+U7VVJ2k6EfeIy3VECSPi6uvPDrhDW6T60GUVkZh6Pl/N92GXzsu/PY6C+SMzG2J
         XqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hvE0rz/t2LI//eFIw9Sa4p8lYcbHze/YHpTFyg9y1FU=;
        b=ecnFn/ALcvlcYqFeykLaL3THNvK4Px0fnZifOoKgAWjgxiS0yovvaargVFiNna1Ljh
         u4XLX0mECzC+RomtrpDWUX3aPDliuSa3XnnpGruP903kE14OL1R8J/4b24IDo0IjW1Tz
         n3Dd4t/kCVkWaQjmIMaRRwojU9LYbX+nhRrnIHBBFgh7496/UvqJf8JPilJni4Sztpgc
         +Ue3L6bLdjNrfzhPpGlSb6FVVylC+TPB/ShC7+F+f+tBA71i9vsWC0QQXR9MReK8lyhO
         v7tQpPpc/YlCEb7JC/Buf/jOkmSOi1JGaijJKrx1PEtixs4R4dTBYZsA3V2ajKuomMJ0
         v80g==
X-Gm-Message-State: ALoCoQkzRZOp/cMGFF8fDVKsPh1ax4gcvGY8EXK691OOUwwf8ezBJm2dZeYCybOYC+hBsUtRrnBK
X-Received: by 10.50.254.4 with SMTP id ae4mr4692283igd.10.1428422027418; Tue,
 07 Apr 2015 08:53:47 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Tue, 7 Apr 2015 08:53:47 -0700 (PDT)
In-Reply-To: <CACBZZX5mZgHxicZGTGsgAxBCZuRymrariAeHK0vf5+Qs1EzA2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266925>

On Tue, Apr 7, 2015 at 6:55 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Apr 6, 2015 at 10:28 PM, Stefan Beller <sbeller@google.com> w=
rote:
>> I am interested in discussing the git pack protocol v2.
>> (I have been thinking about that for a while now,
>> though not sharing a lot on the mailing list, so feedback is
>> somewhat limited. :( )
>
> I'm keen to talk about the new protocol and other scaling issues I
> raised in the recent "Git Scaling: What factors most affect Git
> performance for a large repo?" thread. Although from my testing the
> main problems in performance are the local pack-refs file &
> reachability checks, mostly not the protocol itself.

Yes, the new protocol might not be the most pressing part for scaling u=
p
the repository, but I feel like it's the most challenging and fun part =
for me
when talking about scaling issues. ;)
e.g. if you fetch git.git (and you're up to date!), the git protocol
already eats
130kB of bandwidth, so in case you're on your mobile expensive data pla=
n
you'll hate the inefficiency, it was measured with
    git ls-remote git://github.com/gitster/git |wc -c
    132048
or as a gerrit developer:
    git ls-remote https://gerrit.googlesource.com/gerrit |wc -c
     2108657
2MB, That's crazy!

>
> At the risk of using this list + the venue for soliciting I also want
> to mention that my employer is willing to pay someone on a contract
> basis to work on Git scalability issues, given the right person etc.
> etc. So if someone's at the conference is interested in that I'd be
> keen to talk to you.

I'm fine with soliciting here on the list for a good cause.
(I was touring Paris yesterday and was near the Eiffel tower and within=
 15
minutes, there were 4 tries of unsolicited advertising/begging/
[tourist->money conversion scheme])
