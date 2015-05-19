From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Ensimag students contributing to git
Date: Tue, 19 May 2015 17:47:15 +0200
Message-ID: <CAP8UFD16vb_-rp7kiATd=XW5FK+P+qkME8hPMku571_PDCQywg@mail.gmail.com>
References: <722582475.919095.1431991277969.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<388720318.919104.1431991388837.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<CAP8UFD2hCScvEZxxFCc4XWLJuHM-SyqZ_x4sdmwXj8WVHrW4tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	galanalr@ensimag.grenoble-inp.fr, lespiner@ensimag.grenoble-inp.fr,
	pagesg@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 19 17:47:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yujjl-0008GH-Pc
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 17:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933302AbbESPrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2015 11:47:17 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37440 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbbESPrQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2015 11:47:16 -0400
Received: by wibt6 with SMTP id t6so27927192wib.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rJNnUyujR/ShfOwkXLHLlQbGdSTaQrGc1XPFbbGXsOc=;
        b=yw/USHBR4RyUve7ZzripFx9qFoGgKtwysrcNxPJT37IS7b4isjNQCkVIVIwsZcMKcD
         6gSt2ZKAZDJIow31va0lTufb+XvwIc595yJhNI+j+ZpmXWLkaaQo9UK4BONZUSBIfpsp
         nI4NqBKEH0CJz/XPMA5J8zM88Esk++yv6cwy1wwdvbQJCoIhye6i5FZKSRehwIVsYXt7
         TG9UtrsRButBmzsmkbWJ6MLGA+aFmz4PEV7TjBWSOCQNahD3aNLC6agp+W8ldnT/P4jx
         jnnfblDXTur+LqE8BhHHheS/z4cIpjEkth91up8gY6w4DH4QHMj1OVypIzvuSUGg76B6
         lQSQ==
X-Received: by 10.180.95.10 with SMTP id dg10mr33387577wib.41.1432050435252;
 Tue, 19 May 2015 08:47:15 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Tue, 19 May 2015 08:47:15 -0700 (PDT)
In-Reply-To: <CAP8UFD2hCScvEZxxFCc4XWLJuHM-SyqZ_x4sdmwXj8WVHrW4tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269364>

On Tue, May 19, 2015 at 5:10 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Last Autumn I started to work a bit on =C2=AB git bisect fix/unfixed =
=C2=BB (or
> more accurately =C2=AB git bisect old/new =C2=BB) by applying and rew=
orking a
> bit what your Ensimag elders had done. It is not much but maybe it ca=
n
> help you a bit.
>
> It is on this branch on my github repo:
>
> https://github.com/chriscool/git/commits/boldnew1
>
> There are only 3 original patches on this branch. The first one is
> what your elders did and the other 2 are some small cleanups on top.
>
> You will need to rebase and rework this, but it is a start.

Actually I rebased it on current master and it is available here:

https://github.com/chriscool/git/commits/boldnew2

Best,
Christian.
