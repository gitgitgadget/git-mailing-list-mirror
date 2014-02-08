From: Duy Nguyen <pclouds@gmail.com>
Subject: Bug tracker (again)
Date: Sat, 8 Feb 2014 14:26:57 +0700
Message-ID: <CACsJy8BvEhqBSv2nGG3PTC3aarURAMic0SwMVppeDRkSXiZfCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 08:27:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC2KL-0007GA-CN
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 08:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbaBHH13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 02:27:29 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40178 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbaBHH12 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 02:27:28 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so6761340qab.33
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 23:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=x89J76GFYLq8zd42jO0TK27rdBk/CiKhQXuDCnrVDZU=;
        b=URpyQqWV0Pg8ZgtkRJFyuNFKiNKn3S5UL0UiQpkNyaOeSc3ykDhG575jfp4EIfJnh7
         jCpWkapsL44pFM3x3kDYenHtpvTKKvrOVCQoUY15EhbKNMbcUlavwkKEl8krmM9p//ho
         XdeY+M/WcR1gkaqryg7MpndRFFviXYIlhqQsEVyFTLbk3iwuGywf5LmZsx6GTRoR+4Cz
         qTxxO8CZA3BWyjW/Nt7sL3ZvoUZRF4xpHjsHgeDE77VhFrMUIGYplJLLFTrV4R1fYYeM
         R1zg/1LIrcDjGmxsxGiHz/z75SGEGmMy/iTSWmOq4nqy7eSXqgbiWVOZKQbAVB5p3jxT
         WI0Q==
X-Received: by 10.224.19.199 with SMTP id c7mr10051544qab.78.1391844447777;
 Fri, 07 Feb 2014 23:27:27 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 7 Feb 2014 23:26:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241822>

(Dropped some CC as this becomes a different topic)

On Sat, Feb 8, 2014 at 2:20 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Duy Nguyen wrote:
>
>> Don't take it the wrong way. I was just summarizing the last round. It
>> surprised me though that this went under my radar. Perhaps a bug
>> tracker is not a bad idea after all (if Jeff went missing, this bug
>> could fall under the crack)
>
> I'm happy to plug
> - http://bugs.debian.org/cgi-bin/pkgreport.cgi?src=git;include=tags:upstream
> - http://packages.qa.debian.org/common/index.html (email subscription link:
>   source package = git; under "Advanced" it's possible to subscribe to
>   bug-tracking system emails and skip e.g. the automated build stuff)
> - https://www.debian.org/Bugs/Reporting (bug reporting interface -
>   unfortunately the important part is buried under "Sending the bug
>   report via e-mail")
> again. :)

So I wonder if we use debian bug tracker for git upstream. I haven't
used debian tracker much (or debian for that matter). It's probably
best just ask instead of searching and guessing.

I suppose if debian people (mostly debian git maintainer?) are not
opposed to us using their tracker for upstream bugs, then it's just a
matter of associating a mail thread with a bug number for tracking.
That could be probably be done via email, then reply all to the thread
in question with a bug email address. After that all email discussions
are also tracked via this bug email. Anybody can help track bugs. Say
if 3 weekdays are over and nobody said a thing about something that
looks a lot like bug, then it should be tracked (problems that can be
quickly fixed do not need tracking). Hmm?
-- 
Duy
