From: Kosta Zertsekel <kostaz.dev@gmail.com>
Subject: Cannot setup gerrit 2.11.3 on clean ubuntu 15.04 machine
Date: Mon, 28 Sep 2015 21:14:24 +0300
Message-ID: <CAMObvFciZ5WqscTuHG=2MEGXf0ADQECp9bcarAQpfxG36zNzQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 20:14:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgcwb-0004Uy-1N
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 20:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095AbbI1SO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 14:14:27 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35944 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757099AbbI1SOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 14:14:25 -0400
Received: by qgx61 with SMTP id 61so128114126qgx.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=mRx9DnAQi8fXlQQrhCXQxS/vhdkjY/GBfDNq0WdHM4w=;
        b=gH85/QhzM9GEhdcWPwjraQPPgm9BH1vx+wudHn670NxhQ3q8kM3jRbNF0LrMuoNOEu
         O8l1loycVEf/gwvnL6GX+ct0ktYxL+AJhBIa/2EJiuszHYBh19nhndecwFiy9MvrpdJf
         316tGm9ATFtVKRlQkIBcZFvgdbAIfsH6ZCoYFwMM/PRzZRY7LeU1gn4WF4tTVbZL7ZLC
         viwIQW6ryAMjc9hiig/Rg5oKhXZOBskAZmHiJVdOVXbVYvskaQeVxONoCg6udq44yf+H
         rtOEt0KbOBXVJ+iXBS8sSDYHNhkBRz66wLQIHzu7UblPOAbySGUx2lAe0aKmdNoiAgxS
         qlNg==
X-Received: by 10.140.150.4 with SMTP id 4mr23890202qhw.35.1443464064605; Mon,
 28 Sep 2015 11:14:24 -0700 (PDT)
Received: by 10.55.7.7 with HTTP; Mon, 28 Sep 2015 11:14:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278739>

Hi guys.

I'd like to ask gerrit-related question.
I hope you don't stone me to death for being on (formally) the wrong
mailing list.

I created clean ubuntu 15.04 (64 bit) virtual machine.
Then I followed gerrit 2.11.3 installation documentation.
The installation and initialization seem to be ok.
But - I fail to register the first user.

Anyone can try it out following the short information here:
https://groups.google.com/forum/#!topic/repo-discuss/73hW1PCQyak

Thanks a bunch,
--- KostaZ
