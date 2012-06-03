From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 2 new, 3 fuzzy messages
Date: Sun, 3 Jun 2012 17:52:14 +0800
Message-ID: <CANYiYbHZPEsqd6zuKJJ1fTuO1ii4Jy_ufGx8dAt9Q7fFi1xcdw@mail.gmail.com>
References: <1338659582-6864-1-git-send-email-ralf.thielow@googlemail.com>
	<CANYiYbFCTkx2JdvMbMtGHqqFz4rQMNXamicwRu2kZ3P6rtgSQQ@mail.gmail.com>
	<CACsJy8CLpNANe-6OnU=v5h6zYdcpUWjuH=_iOTAOGohd4VOD1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, trast@student.ethz.ch,
	jk@jk.gs, stimming@tuhh.de, Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 11:52:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb7Tv-0006lc-BR
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 11:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551Ab2FCJwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 05:52:15 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60678 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab2FCJwO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 05:52:14 -0400
Received: by obbtb18 with SMTP id tb18so5525779obb.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T/k6ZXppBf0lytnKa3kik6oT0EvvaKQTGRSRR6WEUCI=;
        b=h5eFxGbE9vuxD6Zbj8l9O1grc/64QwBPWI+IVIFmCjWWTigV+7vi3NhbKSl4VF64lm
         hAZsmAeVlGlkNpg8aNozC27Fyi43aHtvyc6X+Dv5NKsp3MlJf/OUzC9QsJ8ix71yBim9
         EfFJCFg4C6S6HS6e1NdsJSNrOUZ9I1OmdfK3QI/xgRrNgHQr8cLkRgWO/P2g3eyKDLp3
         5PyOC44SkecRW/YdQWyKTEIMc9bAs46KCF3D3OWBolfGfs/Y7zwtEMczY2A45NpHkelW
         pfuhOAYUYkVYRgG6Rg5fsrJ1ovYMJCePVHZM5CTsme5A7M1Us7ljRaI7FjTIMZSlPu6f
         GvdA==
Received: by 10.50.13.180 with SMTP id i20mr5569016igc.19.1338717134190; Sun,
 03 Jun 2012 02:52:14 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Sun, 3 Jun 2012 02:52:14 -0700 (PDT)
In-Reply-To: <CACsJy8CLpNANe-6OnU=v5h6zYdcpUWjuH=_iOTAOGohd4VOD1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199080>

2012/6/3 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>> Next time the diff you generated is more clear.
>
> It also creates a non-applicable patch. The problem with .po files is

It's not a big issue. The podiff driver I provided only affects 'git diff',
'git show HEAD' commands, but command 'git format-patch' will
work as usual. Any way, patches for '*.po' sent to this list is for
review only, and will not be applied directly.

-- 
Jiang Xin
