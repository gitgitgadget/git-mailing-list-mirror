From: Javier Domingo Cansino <javierdo1@gmail.com>
Subject: Re: Branching workflow
Date: Mon, 22 Sep 2014 17:59:02 +0200
Message-ID: <CALZVapmm3=zgx4xZegieSxiUOcYcz9DMHVFknA8SeeYwO5fVJQ@mail.gmail.com>
References: <CALZVapnjN_69y0+PLFA2t8b72WDK+D4BhjDRnRPxU_9iX+_NuA@mail.gmail.com>
 <xmqq8uw1oij6.fsf@gitster.dls.corp.google.com> <CALZVapkvVNxb-jJssZqjT-Y8sApK8O1pe3xTB8guNtx9Md2W6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 17:59:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW61P-0003D7-ED
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 17:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbaIVP7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 11:59:23 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:41523 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbaIVP7X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 11:59:23 -0400
Received: by mail-vc0-f180.google.com with SMTP id hq11so4245740vcb.39
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qNJ5jHA6z9wC0U3tgooyCaIjQN2HsxazTLjBD4r/SW4=;
        b=qtBSq7DhObWXero0zTO2tNTnPSm68bwajh07pSNa4zwRbc7E5dUjULKKsmOfz6Hk8e
         KS+O2Gh/xz7+h5dOQBOloWcGozsv3qRgr6CClwnL+ehyS9IDfFx7F8wGWNG6kjopXTBz
         9vK1hk6tZZZqT5VIDVDxVvaevlZsmy5Z9HBHoQ68/+AsB5tXaWHiadk702Vvqq5Nju4f
         jypY0IVqS8eRWszTRw1jh24EvE6G1WeB6YhyK+Y3vytsKpcnvaduP4ggum10eIvKViCg
         tDg0HkOrahFhdNBJNSwvT5BaUnFUsAWYXG38rPLHcK+gKpuERepNKQ4LMYYSdt1uNHMh
         ktuA==
X-Received: by 10.221.59.2 with SMTP id wm2mr7810425vcb.52.1411401562326; Mon,
 22 Sep 2014 08:59:22 -0700 (PDT)
Received: by 10.220.161.68 with HTTP; Mon, 22 Sep 2014 08:59:02 -0700 (PDT)
In-Reply-To: <CALZVapkvVNxb-jJssZqjT-Y8sApK8O1pe3xTB8guNtx9Md2W6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257367>

Hello!,

I have been using this workflow you suggested, and I happen to find it
really good fitting in many projects I am.

I would like to seek for a little more advice. I keep rebasing all my
work each time master branch is updated, and I would like to know if
this is usually done or not.

The workflow is not using emails, but each developer has his clone
where he works, and occasionally sends work to the gerrit tool we use,
upgrading the patch with each master update.

I know this is a crazy workflow, and I would like to know when you
usually consider to update the sent patch with a rebase.

Cheers,

-- 
Javier Domingo Cansino
