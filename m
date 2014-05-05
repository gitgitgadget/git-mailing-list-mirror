From: Chris Packham <judge.packham@gmail.com>
Subject: material for git training sessions/presentations
Date: Mon, 5 May 2014 16:18:51 +1200
Message-ID: <CAFOYHZDNkTpQVge8Z_qOPS3eH-afKs-KeaFsQ6sOCtLbGgjdbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:18:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhsN-0005Yp-6D
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbaEEESx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 00:18:53 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40770 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaEEESw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 00:18:52 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so1118581pde.15
        for <git@vger.kernel.org>; Sun, 04 May 2014 21:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2ZXRtK4aaLXzZWdDmNN47n/plPO/2lpvf/XKmrbcQMQ=;
        b=q0SE1G24KMsYGX9Avb9UyMO5KljYmvTiK0daCOeM7rJxY3ax6CaZ/RJiGMfeX3vt5I
         RSQVhyg2M0TiybDXY44FxFgT54Bn9prMibAZqk5B8Uw29zv7ulnHJsAjWlXCSMKY+Aor
         Oglv3/MOAZuDX2dre/vufWBMKeQYnGDt3L4MlfjhYFXlEi8r0uH6TqfsvvnTvGMD9jxk
         NkrCDm7Jq1+y8E4FwvIo2vvxL7RqUMGk9bsgoWsjFICtcdSpPjO4sxRsk4BYwPu+x3Td
         SLXJt0uK4rrrVc6LHBTB3Xy9/BGrUwZsAao4ZCqMyTRQ3SLQxIWRSnWRg4TnWmG1OV+3
         3rkA==
X-Received: by 10.66.191.134 with SMTP id gy6mr67285490pac.27.1399263532111;
 Sun, 04 May 2014 21:18:52 -0700 (PDT)
Received: by 10.70.46.38 with HTTP; Sun, 4 May 2014 21:18:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248124>

Hi,

I know there are a few people on this list that do git training in
various forms. At $dayjob I've been asked to run a few training
sessions in house. The initial audience is SW developers so they are
fairly clued up on VCS concepts and most have some experience
(although some not positive) with git. Eventually this may also
include some QA folks who are writing/maintaining test suites who
might be less clued up on VCSes in general.

I know if I googled for git tutorials I'll find a bunch and I can
probably write a few myself but does anyone have any advice from
training sessions they've run about how best to present the subject
matter. Particularly to a fairly savy audience who may have developed
some bad habits. My plan was to try and have a few PCs/laptops handy
and try to make it a little interactive.

Also if anyone has any presentations I could use under a CC-BY-SA (or
other liberal license) as a basis for any material I produce that
would save me starting from scratch.

Thanks,
Chris
