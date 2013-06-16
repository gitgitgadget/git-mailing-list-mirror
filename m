From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH V3 0/4] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Sun, 16 Jun 2013 14:30:37 +0530
Message-ID: <CALkWK0mrmcDP6JpHwzLdE7Vbp=YtpBpJ47u-py+BgZVeac3o1g@mail.gmail.com>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Sun Jun 16 11:01:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo8pu-00014e-My
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 11:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046Ab3FPJBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 05:01:19 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:64524 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab3FPJBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 05:01:18 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so4720811ied.0
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rGYgaDJeRWkJNxduh/NKqexMS70fElCUeP2RRd6rh1Y=;
        b=TffWoiTIC2HpUyN85sBLodsZo2luT0a4R1zOTT0Rc2Rgz+0AWCFAfo4R9MWmW04YDW
         eJvosOmx/5DimJT0KQUjeimKAlcfLY6awOQmiTmy/EjaVg3xu3gdQu6ok/ZR0J0Riz6R
         97VBNg6cVflh2lOSsO4YGDxGgwKpz+uB10w1uvNavh12VTbImS2kJGofV28ZVs6wQMG2
         E4EtqAxqh1QjOQQ6kPGJ6cCM5kKLMb30gSxVq6G6grwCCzLMPtjT+Mr4bhVg7kGms8RW
         MHcvKaqkyZpCZ2+Sd/dEXYT9VtAz00F29hanST72t+1E8T18IglV9iTrncJyx5mjzjTf
         8FtA==
X-Received: by 10.50.18.80 with SMTP id u16mr2472577igd.13.1371373278049; Sun,
 16 Jun 2013 02:01:18 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 16 Jun 2013 02:00:37 -0700 (PDT)
In-Reply-To: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228002>

<benoit.person@ensimag.fr> wrote:
> Subject: [PATCH V3 0/4] git-remote-mediawiki: new tool to preview local changes without pushing

Quick tip: use git format-patch -v3.  The uppercase 'V' indicates that
you probably typed it out yourself, or used --subject-prefix="PATCH
V3".
