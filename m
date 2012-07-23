From: Kevin <ikke@ikke.info>
Subject: Re: Egit is not included into eclipse bundles
Date: Mon, 23 Jul 2012 10:43:20 +0200
Message-ID: <CAO54GHA5oo6h8frVEK6ZfOZC-Ks8jtgWCp7EX8Yzjz_vGihFBQ@mail.gmail.com>
References: <CAPZPVFYoUFFAnKhx7RZszjwDWQ18aZBgUu_5dNF+dtV+=sYDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 10:43:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StEF1-0002w1-Ue
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 10:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab2GWInm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 04:43:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35511 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab2GWInl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 04:43:41 -0400
Received: by weyx8 with SMTP id x8so4073893wey.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 01:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Kowc5lCTdCgSInA71X9Ai6zKraRfbK0iqkF3BxTmGr8=;
        b=CSUdLdQN9zzYMhhMbudangkgmbABlrv3bSwrJrdbz6K2UJbtujdnASBXQ83Ey8wV67
         NNZ58TQ8irUbUSgqHcdMsOCGvRH8BnXCyT82d3BkroSIphQGd+4d0tERgW3So1qMNRYQ
         m9gluU4ehnnJsDrTQEs79dyu5zPxcQ4qfMEQXnd9TJ7o1hiZ1mvovsNcT608J1mvIQmb
         tBHiKH3oxJyIJo2KryDI/0awOXYQJ/OJTmHfaGPWBHDBFrh9de+QqrLDI5XSuW+BdtSL
         LUiDX7bSL98ajhiICErpRoOVCM0KkNbwVTARIrsSYGsZLifOb481p8iCSqTUoBvNrSCv
         M7Nw==
Received: by 10.180.87.232 with SMTP id bb8mr11455345wib.0.1343033020325; Mon,
 23 Jul 2012 01:43:40 -0700 (PDT)
Received: by 10.227.38.74 with HTTP; Mon, 23 Jul 2012 01:43:20 -0700 (PDT)
In-Reply-To: <CAPZPVFYoUFFAnKhx7RZszjwDWQ18aZBgUu_5dNF+dtV+=sYDxA@mail.gmail.com>
X-Google-Sender-Auth: _EfYocP5p6eSiLh9C8SR_8F1y4U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201926>

Hello,

Egit is not a part of git. It's not developed by the git developers, so this
question is not really fit for this mailing list. You'd have to ask the
Eclipse developers why it's not included.

Ikke

On Fri, Jul 20, 2012 at 11:51 PM, Eugene Sajine <euguess@gmail.com> wrote:
>
> Hi,
>
> I have a strong impression that Egit was supposed to be included into
> the default eclipse distribution starting from Eclipse Helios. May be
> it was my wild dream that I would like to become true, but I would
> appreciate any info about why I still can't see it in Juno?
>
> Thanks,
> Eugene
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
