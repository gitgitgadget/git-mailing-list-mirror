From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git on 64bit windows - state of the art?
Date: Tue, 19 Jun 2012 10:59:37 +0200
Message-ID: <CAGK7Mr62y4-fTFzuLGmuOd+zLkk+h1Q-rCb30TW3dWd8VLhhAw@mail.gmail.com>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 11:00:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SguIJ-0001mu-DM
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 11:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab2FSJAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 05:00:09 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:59945 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab2FSJAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 05:00:08 -0400
Received: by ghrr11 with SMTP id r11so4407256ghr.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ii3/eqAjfheSmN0ltTn3tdro1QxMu2zmquOvhl0tsWU=;
        b=yYeizDlfA1XrglIGzG58m2IGDd84F3Tq8jO1OwMMl26upoXOBxoJtbBZAT+ygj4GXP
         zxmxlfcEKj7ina6jaDSOingRpdOTK4smN77fmL6AMloBOcxK4tWjJeg46qiSoZJ83K3B
         XsBk69brHl7gILHlPD1bS7hPOwjCFE+KzOrRXhoBcOUhfKJxpf10ynhJvcdwz08t4GmL
         KLBkO+hNb/NvUCS3rgT3JcDkAQM5qa9H0IsLaX5gsjFsj8bZq5eczcFe09rIa4d7geKI
         xkPvWbBTEh8GSHawWx5QDS8GhSZI0WEOsCjC1uYwnBFxnFdtpXDIHiIotu0zcOn1WZk1
         OD2Q==
Received: by 10.42.76.65 with SMTP id d1mr7056057ick.42.1340096407537; Tue, 19
 Jun 2012 02:00:07 -0700 (PDT)
Received: by 10.50.99.10 with HTTP; Tue, 19 Jun 2012 01:59:37 -0700 (PDT)
In-Reply-To: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200186>

> I was wondering what the state of the art for running git on 64 bit Windows is?

Did they try msysgit? In my experience it has way less issues than cygwin.

Philippe
