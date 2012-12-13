From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Submodule not updated automatically on merge conflict
Date: Thu, 13 Dec 2012 13:46:43 +0800
Message-ID: <CAHtLG6S28bhkAuypy-YgYY9wOWTH+Mp9g-CWmM_aDf7=dpKXZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 06:54:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj1kR-0001jS-Ol
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 06:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780Ab2LMFx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 00:53:58 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52203 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab2LMFx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 00:53:57 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so1410894lbb.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 21:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=nYtL/z4ADyhh+wtp7KgnMgI9tQxbh/jDey1/f2VtnFc=;
        b=TeWAEQrvV74Kr9NEQV2BBC5w1r2H+iFtZyhjmQ+iYYEr+38E3MukNuHzCX6SFXmtTS
         RRpWpL7LwDt2hkgNzM6AFCY1UBWe2CVRDcO7luEsBRg13KwP2kXpIspwTXS7cS4UwKDu
         nNamXguq6fwTMXroXkTWNqVmSEW2gWrSCywETlPJAMKINrCunjW1BlY+71BxoAxX7i0p
         ndiGp3V841wsOdWq2qCUQ6jq5H2dIhH1f2hLXXJ+LMXEh8YOqqnymYAXEPmKL5PHCjFG
         Q5H3EPnR7uQhpvVsWG7b2LTs6Gbr2vSd14Qbbp2hPRx/zFvXFPpMVc75LCDQvibUwW1i
         By8A==
Received: by 10.152.148.40 with SMTP id tp8mr536548lab.30.1355377603478; Wed,
 12 Dec 2012 21:46:43 -0800 (PST)
Received: by 10.112.132.199 with HTTP; Wed, 12 Dec 2012 21:46:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211435>

Hi,

If there are merge conflict files, then changed submodules are not
updated automatically.
Why not submodules?
Files do try to merge / update.

Regards,
ch3cooli
