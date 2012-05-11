From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Git fetch/pull stopped working
Date: Sat, 12 May 2012 01:25:42 +0530
Message-ID: <CAH-tXsCi+zL5hKAHROA0hVfvOr07o4cknS8jy9qngapwB77QnQ@mail.gmail.com>
References: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
 <7vehqv36aw.fsf@alter.siamese.dyndns.org> <CADB4Qb35FfTL=XX04iR71+2Rg8p4s2roqAF8b_BdFNP9YN=sfA@mail.gmail.com>
 <7v8vh2v501.fsf@alter.siamese.dyndns.org> <20120508200842.GA14779@sigill.intra.peff.net>
 <CADB4Qb3sqy859k6QPuqU9u1cdxwz0LSQ7bdUXXFW_gQqaT+P3A@mail.gmail.com> <CADB4Qb2-VB0LTrP8_i75V9e2FDeSjNLc+Pc4m73UJ0AX9NfX=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
To: Egor Ryabkov <egor.ryabkov@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 21:56:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSvx0-0000Dj-5U
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 21:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760705Ab2EKT4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 15:56:25 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33876 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757324Ab2EKT4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 15:56:24 -0400
Received: by wibhr2 with SMTP id hr2so2026118wib.1
        for <git@vger.kernel.org>; Fri, 11 May 2012 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7AOZp1ZuEoq/hyq+CKXiyJejgIHzW7UE7m2qoPEj02Q=;
        b=bJ1aHRf049e97pjV5ODkxAe1LQd2GRAm4WU+euEdAgEbt9qGZWJ5b2eVlpqLOjPAtx
         528cGOZNgoglqnYjeTKLGsDhWtea3AtYlnsOxT5/Bc5bcm1KuKEkZp8JMCZJCwLR1v0y
         YxXHhrBIJxBpI8Ww17FRe+RRJ+H1lDGIYGjo7lBC2s0W5DjdGAwrArubNRrnmgIQ3gkM
         EIe8i0/T2a/zAdeyM69LrAjkHpY/+edzwwUnIIk4UmKOtSnpi6HY0PAOO4NXzpq0Sc0C
         cxWPIQqRZRcydG3f4R8tHwEKk4wdtgrTAipMlzGWQFBWHUjMrEo2ObTjtGqTq5ZXcInF
         WBjA==
Received: by 10.216.213.219 with SMTP id a69mr2456082wep.16.1336766182798;
 Fri, 11 May 2012 12:56:22 -0700 (PDT)
Received: by 10.227.39.96 with HTTP; Fri, 11 May 2012 12:55:42 -0700 (PDT)
In-Reply-To: <CADB4Qb2-VB0LTrP8_i75V9e2FDeSjNLc+Pc4m73UJ0AX9NfX=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197693>

On Sat, May 12, 2012 at 12:17 AM, Egor Ryabkov <egor.ryabkov@gmail.com> wrote:
> Problem solved.
>
> Turns out that was a miscommunication on out side: the guy who setup
> the keys on that box left, and his access to GH repo has been revoked.
>
> And GitHub returns "repo not found" rather than "you have no access
> rights for this repository".

I have seen a lot of github guys in this list. I hope they will fix
this soon. I had this issue a long time back and now I'm understanding
what exactly happened then :)


-- 
Jaseem Abid
http://jaseemabid.github.com
