From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 00/23] RFC: Introducing git-test, git-atomic, git-base and git-work
Date: Mon, 25 Apr 2011 01:47:28 +1000
Message-ID: <BANLkTi=K_Mb-+-5DOE3o6m7pQsQcH0qz-g@mail.gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
	<20110423091300.GC9206@m62s10.vlinux.de>
	<BANLkTinhjMtNc257NnOCZe6askr2i=4g6Q@mail.gmail.com>
	<BANLkTi=UDYT1hjpFT0LcgL6XvAGtTXMBLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 24 17:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE1XI-0007od-Fi
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 17:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757588Ab1DXPrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2011 11:47:31 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62733 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576Ab1DXPra convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2011 11:47:30 -0400
Received: by ewy4 with SMTP id 4so533502ewy.19
        for <git@vger.kernel.org>; Sun, 24 Apr 2011 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PvFvWnOM5i6I2Wv5iz9bS0Ym+FKI+2wRu4PIPTT8/P4=;
        b=b3k+kLqAHUElP6pbXYYJVtT4aLCEhgSGt3xclv4Xu+8ENVsZmyydC2o2gRmMjkReU4
         Nu0wje3g457RX9/qlEiG1VuiweKHA/gnKe9My3VrgSF005NzVkhkz7y1MIMMwUfb5k+0
         ieRl37i5pVAR3qfYm0uJSB4nU+tzK5eLluygc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XK3M9t7SyqbkMQ6RnqAtyD1qR2ZMKCEx4hO+bs1i+KA7mE440Lh8xfphi/DTHCTfPo
         LKaWrBUHQ4NB0dPa7NtHkK/UunmS4LyrT9FcUNogjp/Au2eeUhVSsuFmeBR+DcWD42bw
         xKJGxRNX4Nqz7kgkKOchx8JOgBJMJI3B9uKwI=
Received: by 10.14.50.15 with SMTP id y15mr1071776eeb.149.1303660048216; Sun,
 24 Apr 2011 08:47:28 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Sun, 24 Apr 2011 08:47:28 -0700 (PDT)
In-Reply-To: <BANLkTi=UDYT1hjpFT0LcgL6XvAGtTXMBLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171994>

Also, anyone interested in browsing the HTML documentation for these
commands can read:

   https://s3.amazonaws.com/jonseymour/git-work.html
   https://s3.amazonaws.com/jonseymour/git-base.html
   https://s3.amazonaws.com/jonseymour/git-atomic.html
   https://s3.amazonaws.com/jonseymour/git-test.html

jon.

On Sun, Apr 24, 2011 at 4:37 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> BTW anyone interested in trying git work can fetch the tag containing
> this series from my github fork
>
> Web link here:
>
> https://github.com/jonseymour/git/tree/work-20110423
>
> git://github.com/jonseymour/git, tag =C2=A0work-20110423
>
> jon.
>
