From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Sharing merge conflict resolution between multiple developers
Date: Mon, 11 Aug 2014 20:57:53 +0200
Message-ID: <CAP8UFD27qHqHx4ZPw=Fyn0R9NWqhuiespDHnDi=z=1nKb=wKtg@mail.gmail.com>
References: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
	<CAP8UFD0_zfB_D-9EVZ4K=Zdq_G+9C-QhX7WED53zExV+Nv8Arg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:58:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGun9-0000mp-44
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 20:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbaHKS5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2014 14:57:55 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36067 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbaHKS5y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2014 14:57:54 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn18so4776987igb.3
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=e7mpL7ZL+WziuXRccaePy+ubL2OdLxJppp2L+0oXGCk=;
        b=xGAKGfdf+UdoJ6x46L6CIwm7WX/4lKbemufMGqpw07lUQUQZVNcThvux8phY9AXHL9
         UyMFJoETaeokTn4/exT7Y1PQbZzVZPdJ16cC0BmaubZ1SW8NYtYefDXxe0VSu31opnWC
         2nv/Eo5d2OBoAc/jZttWuYzQQHqwLRK9wYs0Yw1gozaV2HNkxVlEdaDuTpUcWYBG2bLt
         dHPSxUE+HT+AexEJcO4+2uTv3f6TNok1Bx8P/rJ4NS7ic5KkzTesiBNKgRSFcOs3c9xF
         C4Fv141o5pEhSrfb26SVeJKK4xOxoqp34/CF2y+bKyB/Er8hi7n0jX2AFWk3W+KqOyHJ
         G0SQ==
X-Received: by 10.50.4.9 with SMTP id g9mr31896714igg.42.1407783474034; Mon,
 11 Aug 2014 11:57:54 -0700 (PDT)
Received: by 10.50.55.74 with HTTP; Mon, 11 Aug 2014 11:57:53 -0700 (PDT)
In-Reply-To: <CAP8UFD0_zfB_D-9EVZ4K=Zdq_G+9C-QhX7WED53zExV+Nv8Arg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255131>

Le 11 ao=C3=BBt 2014 07:50, "Christian Couder" <christian.couder@gmail.=
com> a =C3=A9crit :
>
> This should be possible using "git imerge" which is separate tool.

Sorry I sent the above using the gmail app on my mobile phone and
unfortunately I can't make it send plain text emails.
(Emails which are not plain text are rejected by vger.kernel.org.)

Best,
Christian.
