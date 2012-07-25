From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: ninja build
Date: Wed, 25 Jul 2012 12:33:04 -0400
Message-ID: <CAM9Z-nnBUn0h_AuugYxJ0MNmw6OiPFhuff5MrRAm-8VSmQB2Mg@mail.gmail.com>
References: <CACnwZYc-AaVppw8RHwF4O4SSaNcEOtJkyM0iOMAVGTo6kSjJsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 18:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su4WP-00039Q-Jk
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 18:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738Ab2GYQdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 12:33:08 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42923 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968Ab2GYQdH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 12:33:07 -0400
Received: by bkwj10 with SMTP id j10so668960bkw.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s9E38naRdTEljf1A/VGhAi61Ty9TaEmoLvrN/3j49aE=;
        b=mT/7TZayoHK08MlOokmO1Shk3qdtzXWMbs0pnBxJnF8sLYEpP/QjknwvZnw4RbryA1
         I9Qi4HUUGt/aVZyTMr/VaL6kGU3ee96G46D9ejijJKoF5BHMl88gHdg+wh+rqxxhngi1
         yphoWBdE1PSlEJLc70EZxtWL79jXXPXzwlYGMU9laFu1Wf6Pdb4+9YEbGKvHdOMgRxqj
         wo7s1a/9Iaw0OdNYPnjz0XOUSU+6js3a3zk8mmVRSH45cXiJ+BMg65dw35Ox39Ckf9El
         qgCIq4C5mvh/FTAJINO9CKfb6tMfNjyJSH958UMoiWraGF8Zc8I2z9KagdMaD0CRCPAM
         2VhQ==
Received: by 10.205.137.8 with SMTP id im8mr12208531bkc.135.1343233984718;
 Wed, 25 Jul 2012 09:33:04 -0700 (PDT)
Received: by 10.204.27.24 with HTTP; Wed, 25 Jul 2012 09:33:04 -0700 (PDT)
In-Reply-To: <CACnwZYc-AaVppw8RHwF4O4SSaNcEOtJkyM0iOMAVGTo6kSjJsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202173>

On Fri, Jul 20, 2012 at 11:42 AM, Thiago Farina <tfransosi@gmail.com> wrote:
> Is there any interest in building git with ninja? [1]. I think it
> would be very interesting to move forward from make to ninja.
>
> [1] http://martine.github.com/ninja/

While it might be interesting, would it be a productive use of the
community's time? So many platforms include standard varieties of MAKE
and it is well supported by the autotools framework. Tons of people
know how to maintain it.

So it may sound cool, but that alone does not make it a good idea.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
