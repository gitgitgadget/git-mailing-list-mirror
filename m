From: Kevin <ikke@ikke.info>
Subject: Re: Testing JavaScript code in gitweb.
Date: Tue, 22 May 2012 07:58:15 +0200
Message-ID: <CAO54GHBgCczesZ6=9GtPZUWuWdmG_1eqCF3ak0Ff5Wgukd2TaA@mail.gmail.com>
References: <CAH-tXsDif9YOrkEcj7AdRfn6gvLx4mj4+SKCB4GzyW6QJpx=9A@mail.gmail.com>
 <4FB8BE7C.8050306@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jaseem abid <jaseemabid@gmail.com>,
	git mailing list <git@vger.kernel.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue May 22 07:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWi7G-0001UV-E2
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 07:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab2EVF6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 01:58:38 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:59813 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab2EVF6h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 01:58:37 -0400
Received: by wibhj8 with SMTP id hj8so3060291wib.1
        for <git@vger.kernel.org>; Mon, 21 May 2012 22:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UnSOh1NzASygouEV5HdM3udwj1QaYs38O8Crn52LLNA=;
        b=ssS4Ly6+vRthZeitOdjCWAGVjzg18utE9CtusRIOfwET0B3oLBRswDVyZoDEcUnEbK
         5K755/9w13/XSvv3EYtR96zCrsT+fJlSN38hrFncQumXnSZmmTRbn3wwGluuDMx2aqyT
         naSYeeFiEfU1+laCIa4P9ottrqERFsbUuokVsKeDXpcxE/Ug+sj5vXyfPV3/iSxm0IgA
         A9lZbX81xEE1xQBROc1h0j70kp7obbfMM5uhboNKZmJeW2k13+M3TLKXmQzdoRldSNLL
         sLutIqXItm+67XrB22x57bHWi1Zsq1lF2xaq/jHhuu2A2IWmRBVqujAnqHNE1RMvA6+K
         DX0g==
Received: by 10.180.98.39 with SMTP id ef7mr31536240wib.21.1337666316037; Mon,
 21 May 2012 22:58:36 -0700 (PDT)
Received: by 10.227.35.195 with HTTP; Mon, 21 May 2012 22:58:15 -0700 (PDT)
In-Reply-To: <4FB8BE7C.8050306@pileofstuff.org>
X-Google-Sender-Auth: 3IJ4rfbCXsHoajUg0tc1TkEJEkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198180>

On Sun, May 20, 2012 at 11:50 AM, Andrew Sayers
<andrew-git@pileofstuff.org> wrote:
>
>
> I think it would be clearer if I said "TDD is worth developing an
> opinion about". =C2=A0Unit tests are very valuable, but the way you g=
o about
> writing them is fairly personal - some people find TDD just right, so=
me
> like BDD, some want to chase the next technique, and some of us just
> muddle through. =C2=A0If BDD works for you, great! =C2=A0If you try i=
t and don't
> like it, think about the problems you had and what would be a more
> productive approach for you.
>

The differences between TDD and BDD aren't that big. BDD is almost the
same as TDD, but with a stronger language description.
