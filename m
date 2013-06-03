From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #01; Sun, 2)
Date: Mon, 3 Jun 2013 08:10:28 -0400
Message-ID: <CAM9Z-nmk1qfQZLCH1g2DVaZXm+WY03oTr19ZRZ8L9rb1apSz6Q@mail.gmail.com>
References: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	=?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 14:10:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjTas-0006iA-6T
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 14:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab3FCMKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 08:10:30 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:57032 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab3FCMK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 08:10:29 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so10115716iea.17
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x8QOt+snkpHr8Pbv1IPGNp4m9zsXA4qnPXJXyKirKn4=;
        b=EFrZxyDCpiKyN7mwLhjqLc8Bby8f1cweHe8kdT3Qq31WSAwkcwnZq0KUY6n1sFo0x9
         T6i4Zt3FYtN+4pz9KuvhDRMCpsVmjB9MGzcZUBPW36AYNsR8/8pm/OkcRMxQ1xVZav8S
         ZVNZIhX7CVHDIL9LL77EIjmFQ9r1aL1NT8Wtk2SlIOg8Lt2gsRPDJCC+oyBgouTSJWRU
         iO7d30yFyGVfpIEx+DchoVUUP5cNTNjc+3a0Pg1zGXduag+wx2XSbnF6jAs5dlESS4b4
         4nx0JO4uE8QkmuTm7rc9cKd7ChFT9/WKOY2uLJznHT9twEuJ9x15eSZEsretQ7j+CGF0
         nelg==
X-Received: by 10.42.27.208 with SMTP id k16mr10238020icc.43.1370261428626;
 Mon, 03 Jun 2013 05:10:28 -0700 (PDT)
Received: by 10.42.173.10 with HTTP; Mon, 3 Jun 2013 05:10:28 -0700 (PDT)
In-Reply-To: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226216>

On Sun, Jun 2, 2013 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
...
> --------------------------------------------------
> [Stalled]
...
> * jk/gitweb-utf8 (2013-04-08) 4 commits
>  - gitweb: Fix broken blob action parameters on blob/commitdiff pages
>  - gitweb: Don't append ';js=(0|1)' to external links
>  - gitweb: Make feed title valid utf8
>  - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch
>
>  Various fixes to gitweb.
>
>  Waiting for a reroll after a review.
>  Will discard unless we hear from anybody who is interested in
>  tying its loose ends.

I'd like to have a closer look at these. It may be a week however as
there's some serious in-house chaos going on right now. (Finally
starting to settle after about 2 months...)

--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
