From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: VCS popularity
Date: Wed, 1 Apr 2015 00:14:52 +0200
Message-ID: <CAA787rm1qfaLb=ZAvZ19h+_EBv-a3S7xV=0B6kMfjYpKsAbNcg@mail.gmail.com>
References: <CAA787rkKYQ=TJezeLy0f=aGs2GR8ypuxmr2qA2py+hGsC+juVA@mail.gmail.com>
	<alpine.DEB.2.02.1503311502240.26359@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:15:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4R1-00009x-KH
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbbCaWOz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2015 18:14:55 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:34749 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbCaWOy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2015 18:14:54 -0400
Received: by lagg8 with SMTP id g8so23463209lag.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=WupTGUlhWmpfi5tPmsP8mFCIjJpNxG9nMA23+xyETiI=;
        b=vG0/lTXaQZuXv9aTXa3vq7Jrg2Ed3YmL80tJXKzZ1Dki+GvahMF1hkBp5ogkCESuR0
         LQj4vgrpobW3sBCMrL+b7ht9a27S/LLaBPbCgs70n1fXSkZ9duBvmDyKL35taYsw9y7/
         pLaiN74N4VQJC8VLU5A9YZgO5DnF707LL+mpn+Kub3HsOXeB90AJPJ6DaMfwWkiulUOh
         GxIl1tW+yyPWHQOhyVDLIAhWN2EIk5kOEEOdlu9738Udxm/MZD82zyrnolOb7fLPxTKa
         7HIclqS9pGbzi1Ja3gRVwDX0JRsnBcIWFLV/Yae8TN08go0gqcR6ngoEyzwchKUw2Y94
         LuFA==
X-Received: by 10.152.207.74 with SMTP id lu10mr13718311lac.108.1427840092861;
 Tue, 31 Mar 2015 15:14:52 -0700 (PDT)
Received: by 10.112.156.231 with HTTP; Tue, 31 Mar 2015 15:14:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1503311502240.26359@nftneq.ynat.uz>
X-Google-Sender-Auth: Xy_9Tmk0CI56tdGR3krpxAZVaDs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266564>

On 1 April 2015 at 00:03, David Lang <david@lang.hm> wrote:
> On Tue, 31 Mar 2015, =C3=98yvind A. Holm wrote:
> > openhub.net (formerly ohloh.net) has an interesting comparison of
> > the number of public repositories on the net, based on searches of
> > popular hosting services. This comparison is available at
> > <https://www.openhub.net/repositories/compare> and shows an
> > estimated market share between Bazaar, CVS, Git, Mercurial and
> > Subversion.
> >
> > I've been monitoring this since 2014-08-05 to see how things were
> > developing, and it's a good indication of the popularity of the
> > various version control systems.
>
> number of repositories is an interesting datapoint, but activity in
> the repos would be far more interesting. There are a lot of repos of
> various types out there that haven't been touched for years.

I do agree on that. Many repositories won't be deleted if they are
converted to other VC systems to avoid breaking links and so on. What I
found pretty interesting is the relative growth between the various
systems. That's why I created the graphs that show creation of new
repositories since August 2014 instead, for example

https://github.com/sunny256/openhub-repositories/blob/master/graph/rela=
tive-zoom.svg

- =C3=98yvind
