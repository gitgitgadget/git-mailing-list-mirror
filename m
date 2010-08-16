From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Wiki "CygwinBinaryInstall" missing
Date: Mon, 16 Aug 2010 18:55:47 +0800
Message-ID: <AANLkTing0yxhzvMwOsYi5j1-u4VXN=1Wg04Ebbhi4JD7@mail.gmail.com>
References: <AANLkTikDBW5jUu4MYOEL-TEkD6t4jC-Wthsmbk=hGc55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 12:56:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkxMU-0003q2-LK
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 12:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab0HPKzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 06:55:54 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49047 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab0HPKzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 06:55:53 -0400
Received: by ewy23 with SMTP id 23so2205220ewy.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=8FLynf+AhSVyYkCOJ64Si7LV6bEe/gfZhPTmlyfWnjc=;
        b=OZ/9VXwGjS5PPzeHIj+3GLaMzKeeokZ4N96BRXhsQupHBvIwUYr431FcT43dPS0J13
         JcmOq8jWwJTlnG9uqYC8mFoJX6FxJSJAYoneO26CS/3Aca6V0fEB/PtkKpNUC2l3MNfc
         ORWsrc5qH/yRV8EvYjZqHuT75RIped3uetHtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YT0yqucycNPyrBPrSLQD4dQ5PhIjAmmmF/W86EvHc6br2ySAfGif18bN3+Mb39cIZK
         K43fr5pp9iIFHK4OBSx94rK+J0nSyQVc9c6JsAPQZPnXZwO3jz6ukZniSK4cbxFBY25N
         umSi+G3QZR8QXcCWIVSGN0F2r+9cUNqrW1ytQ=
Received: by 10.213.22.11 with SMTP id l11mr2564129ebb.31.1281956147931; Mon,
 16 Aug 2010 03:55:47 -0700 (PDT)
Received: by 10.213.22.134 with HTTP; Mon, 16 Aug 2010 03:55:47 -0700 (PDT)
In-Reply-To: <AANLkTikDBW5jUu4MYOEL-TEkD6t4jC-Wthsmbk=hGc55@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153657>

On Mon, Aug 16, 2010 at 4:49 PM, Daniele Segato <daniele.bilug@gmail.com> wrote:
> Hi,
>
> I asked a collegue to install git on cygwin instead of using msysgit.
>
> I wanted to pass him a link with documentation on how to do it so I
> followed a link in the wiki from
> https://git.wiki.kernel.org/index.php/Installation
>
> for instance this link:
> https://git.wiki.kernel.org/index.php/CygwinBinaryInstall
>
> which is missing in the wiki.
>
> I've found reference of people using it around the web, for example:
> http://rip747.wordpress.com/2008/06/24/help-git-on-cygwin-not-working/
>
> here someone is saying he followed the official guide (which point to
> that link).
>
> Is the CygwinBinaryInstall page been moved or deleted?
>
> In the first case: the link should be updated and, where is it?
>
> in the second case: why?

Not to sure - the page was probably lost during the migration to the
new MediaWiki setup.

If you get the time, you can just re-create the page with the
instructions to install git on cygwin.

IIRC, the usual way to get cygwin packages is to use the cygwin installer.

Alternatively, you can also compile it from the source - I've been
doing that for some time now, albeit with some features disabled (eg.
gitk).

-- 
Cheers,
Ray Chuan
