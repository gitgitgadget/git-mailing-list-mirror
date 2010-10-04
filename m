From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv6 00/16] Add missing &&'s in the testsuite
Date: Mon, 4 Oct 2010 03:11:13 +0000
Message-ID: <AANLkTi=+N=jm1b3vpiwxR0tFwPGbsaJyEq39q3oAyAn_@mail.gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 05:11:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2bSS-0001lO-9b
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 05:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab0JDDLP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 23:11:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57792 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab0JDDLO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 23:11:14 -0400
Received: by iwn5 with SMTP id 5so6355483iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 20:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mLswcHdwcS85UnW1PH4JmSOPGUbUCX6LyT/iXu/a9p0=;
        b=BgDG+r8RmP0RqxTRRzComNBWcC4qqLv+oejh1habSAKCjIzsujtaIezAFWSQijKE74
         WEhvtUy8B/rWpshWiWy3i+Pq5z/oUAgOCJMK+zg5SxS9Vy9Kf5WCumF/lLgXdB3+S0Kp
         qpIDDCDnqN19tG3pswAy4474zqOkoA4rTdYqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DNelo2dc3U40lkK0mvKnaa+Tdy8i9Mpu5Fuw4eWldJAgNYI0lCuKiLq9VQZr8hKims
         xJaY4J7S0xtqGsI+SlrN7Oxom15AqcGRsJDu84RsrpmyghsOXBsNl1lNtTYZH7M982IJ
         W2lUSIT04+EYgtMQ9AA6ex9LXDzaUaqjdsSaI=
Received: by 10.231.170.13 with SMTP id b13mr9442037ibz.62.1286161873810; Sun,
 03 Oct 2010 20:11:13 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 20:11:13 -0700 (PDT)
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157963>

On Sun, Oct 3, 2010 at 19:59, Elijah Newren <newren@gmail.com> wrote:

> =C2=A0 =C2=A0* In patch 1, I made two of the changes suggested by Jon=
athan, but
> =C2=A0 =C2=A0 =C2=A0this was =C3=86var's patch so he may want to comm=
ent on those. =C2=A0Also,
> =C2=A0 =C2=A0 =C2=A0Jonathan had a few extra questions in the last ro=
und that
> =C2=A0 =C2=A0 =C2=A0perhaps =C3=86var may want to comment on.

Since Jonathan says all but 7 & 15 are OK (and I looked at those) I
assume I don't need to hunt down some other discussion and comment on
that. I.e. unless someone replies here.
