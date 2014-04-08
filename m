From: Guanglin Xu <mzguanglin@gmail.com>
Subject: Re: [GSoC 2014] Replacing object loading/writing layer by libgit2
Date: Tue, 8 Apr 2014 09:35:43 +0800
Message-ID: <CAATe9uiSn8o5JRWphVG=Auv6dfZTyCvq=-d=fDeQU0o9q6n+Pg@mail.gmail.com>
References: <CAATe9uhR3P=C8f10VoiEksXiQCnUXqRdXO5vQr_NUe2YP33xJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vicent Marti <vicent@github.com>, tr@thomasrast.ch
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 03:36:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXKxc-0007Wc-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 03:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbaDHBfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 21:35:44 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:51402 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbaDHBfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 21:35:43 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so258739iec.16
        for <git@vger.kernel.org>; Mon, 07 Apr 2014 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qKzB0XHvLyQB4PqEgTEZATaHGisUajOzIbIg8pSfAaI=;
        b=d1aXk8tUqtbFpflvhoQI2zOCGNKnfDpw7xqSDjiVc5PfrB6Rw3yrdNJsPWQBMZ5cRd
         0YWJZC2u6MIKmEY2QPaPH/JOImzvAK5hWHteKjapUrVZdj0Gu5GitwdB/pyG6PGd4Jmf
         3ux6UAvsypgcAGh8NjhdelzzocZuWpVUp1fqbio/XqiWeM+/HNcegIzS8epMnOjmwxVv
         cMHe+iHCd9g1fNJvb3mZdkZSBTt0CRInuR5EOVoAHkLcjGYUnmw/V4zOx2Rl8xCcvnoX
         wy9TsMyPotqi0uj5Ag5cxcQEj/YBn6mXYGr0+EStUnR19GNZQ1zUXI/eegrPT2X53XoO
         NQxg==
X-Received: by 10.50.154.66 with SMTP id vm2mr1587222igb.4.1396920943097; Mon,
 07 Apr 2014 18:35:43 -0700 (PDT)
Received: by 10.64.14.135 with HTTP; Mon, 7 Apr 2014 18:35:43 -0700 (PDT)
In-Reply-To: <CAATe9uhR3P=C8f10VoiEksXiQCnUXqRdXO5vQr_NUe2YP33xJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245916>

Hi all,

I withdraw this proposal because I realize that I won't be eligible to
work in July and August as an F-1 student.

Good luck to other applicants!

Guanglin

2014-03-20 23:37 GMT+08:00 Guanglin Xu <mzguanglin@gmail.com>:
> Hello,
>
> My name is Guanglin Xu. I am a second-year master student at Sun
> Yat-sen University in China, majoring in Software Engineering. I am
> also a perspective PhD student matriculated in the US. I'm planning on
> doing summer projects which I can work remotely. The GSoC 2014 program
> of Git project is a great choice.
>
> I am kind of a "skillful" Git user with 4 years' experience in 3
> projects. For example, I am a Top 5 contributor in LibVMI project
> (https://github.com/bdpayne/libvmi); I host a team-made mobile app in
> Github (https://itunes.apple.com/us/app/ying-yue/id689566688?ls=1&mt=8).
> For more of my projects see here
> (http://www.andrew.cmu.edu/user/guanglin)
>
> To get familiar with the flow of Git development, I worked on
> microproject [2] and had corresponding conversations with Eric
> Sunshine, Jacopo Notarstefano and Sun He in threads. Thank you for
> their comments on my work.
>
> Now I've submitted my proposal to google-melange. In brief, I propose
> to replace object loading/writing layer by libgit2, which comes from
> the GSoC 2014 ideas page of Git project. Particularly, since I didn't
> realize where the hardest part is when I looked into the initial aim
> of this idea, I added a performance requirement that the new
> implementation should at least not run slower than previous one. Maybe
> I underestimated specific challenge in working with Git, suggestions
> or warnings for this topic are all welcomed.
>
> Thanks for your consideration for GSoC 2014.
>
> Guanglin
