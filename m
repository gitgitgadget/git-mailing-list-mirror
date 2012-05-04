From: karunakar merugu <karuna.linux@gmail.com>
Subject: branching based on tag.
Date: Fri, 4 May 2012 14:48:58 +0530
Message-ID: <CABECqUE-WqnR_wQzMsuEFmUu86_9i+GnJdEKYXwB+WancTFnOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 11:19:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQEfL-0001eX-Gy
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 11:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab2EDJTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 05:19:00 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55658 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753712Ab2EDJS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 05:18:59 -0400
Received: by vcqp1 with SMTP id p1so1881675vcq.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gmIwOS9JdeKi/tYyzRtgbuqwWxSSpWuLyKPQcaJ1UCs=;
        b=miRsvLfx3/z5r0QBMm4HwDHOKr3AiuNmeuC2XMrO/GnFJRAmiZ/YC2E9nBe16bioH1
         6HkW6GTvn5Wk8NJv7WcnlBxOS4K88TvptkDzv26prtM0aGMewau9qAa31BlcptGtyMna
         cX1+OWqYMYxk277JfpRTUkB2Nbl8UcIcqJyefmGwDTat2vscQjL/8yyWkIZ125hWBx1N
         2scnGI9FXrY4Oo0PMNhIizr+Cqz3FAEiuRBDocmxLLvI1m0hgu/lYhIHWH9lR3Nhi79m
         xHWepYw3IETXDS9WCkwA32rpR3Bhm380avjSSQALzgOQOjKBnb7XyUN4K7MLhV+vGKT3
         IA+w==
Received: by 10.52.96.35 with SMTP id dp3mr630782vdb.97.1336123138625; Fri, 04
 May 2012 02:18:58 -0700 (PDT)
Received: by 10.220.232.142 with HTTP; Fri, 4 May 2012 02:18:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197008>

hi
I am new to the git.
I just cloned the repository by following command
git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
After this I checked tags by
git tag -l
it gives me the lot of tags.I just want to work on some specific
tag.Is it possible for me to create separate branch on that specific
tag.
thanks,
karunakar.
