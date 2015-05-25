From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: Suggestion to add a new command(git print-tree)
Date: Mon, 25 May 2015 17:21:01 +0100
Message-ID: <CAKB+oNtOXJO39QR2ZukMVM8juceBrBeiWLz92eVEOteVO99brA@mail.gmail.com>
References: <CAKB+oNunwVEc+UJxXN0y5U1VMKsZTyjQ-1zr_bdJbd+tOKeTPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 18:21:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ywv7s-00027D-Kp
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 18:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbbEYQVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 12:21:06 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34043 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbEYQVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 12:21:01 -0400
Received: by qkgx75 with SMTP id x75so68023711qkg.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=UJa8cmtX62r5hXVcyssKvKUs/kvIRWbYZnYRIxW9oi4=;
        b=bJVX5CyY82gbjbJwrxJh8F5Vp2SaTfxGS/Pn9LHsQkSrOaznIfeldH29+K4OSVK1ev
         k0yn1UiitD5/adBH+gssziphBXGzIiIPgB2fVc15LkO/Ho3uAqCzxMaNsW/kTvQUsvmN
         zhJm5EhsKk3NI1RF4OU3zsG22lFHIB04BThBHo5F2Ovg4VYtWuP8YE13Xy4QF57BvqTU
         vehClfPooU/qZIsMY3TZImsMGzROHVIaSIXc1fVuU1SsV/jxMC2sutbnjeHuJYgPCjXb
         qgflQ4b+eky2claoMQtbK1t7HyZXmawNblJV0nquVVOqm5CPXmhhjtcWLbkIZxWqE3Oe
         n4lQ==
X-Received: by 10.140.131.21 with SMTP id 21mr2407509qhd.51.1432570861138;
 Mon, 25 May 2015 09:21:01 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Mon, 25 May 2015 09:21:01 -0700 (PDT)
In-Reply-To: <CAKB+oNunwVEc+UJxXN0y5U1VMKsZTyjQ-1zr_bdJbd+tOKeTPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269842>

With discussions i have on the irc channel(#git) i just noticed there
is the git ls-tree command but it doesn't format the tree so it will
be a good thing for the tree to be formatted. I will like to embark on
the project.
Regards
Alangi Derick Ndimnain


On Mon, May 25, 2015 at 5:17 PM, Alangi Derick <alangiderick@gmail.com> wrote:
> Hello everyone,
>      I will like us to discuss on this topic to add a new command into
> git that will enable us to print the entire working tree in a git
> repository. Something similar to work happens when you run the linux
> command: "pstree".
>      This is important in searching and also more that i will be
> discussing while talking about the idea. Thanks and if there is
> anything to say about this, feel free to comment.
>
> Regards
> Alangi Derick Ndimnain
