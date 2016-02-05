From: Britton Kerin <britton.kerin@gmail.com>
Subject: gitk view documentation? tooltips?
Date: Fri, 5 Feb 2016 08:02:46 -0900
Message-ID: <CAC4O8c9Vr-kjCOYBaTK-ZnpdPtkDoMXWQep-oSq3tVO=FukhQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 18:02:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRjmW-0000kR-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 18:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbcBERCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 12:02:48 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37383 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbcBERCr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 12:02:47 -0500
Received: by mail-wm0-f49.google.com with SMTP id g62so36039700wme.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6F0Uadna0JQ7d+RXxH+POwO7U8G3nD0TZ+XSMXcRJoc=;
        b=PbEydC7XskPSd1dkbNtEdLUKnC9IOUC5KVle7fIvpHVQY/PfAR8045fmD+0EbXExTo
         cmHXIamHjIJvuyU2MVSaN+UmLzLDdnhxImLhtudvLnKM+Ve4+C+iTcauVnB6613MnbvI
         KVkhnirvZ8GUNbEfjFnS3n/TwKEL0DtfBSo9SaR2LVd0NPkyHpZO1Z3OKxIhuWU/ZGWd
         VfhAaElTH6wqsjW7AtADiuLNA55e6qehecY+cv7raW1dYP3+t9AN9rS9PVPL+LJxspOO
         ruDOvpzqMB2VeF6hXIU48ROTcKZ+9p9qS1ZTcaptjen3CnFGrVXoYDVmfanx8QysxeKC
         l/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=6F0Uadna0JQ7d+RXxH+POwO7U8G3nD0TZ+XSMXcRJoc=;
        b=StgjWlV7pA7HcK+9JWvHPUvFBFHQaJxkCtfmlZ1sKx5DJsXXjQUnaiZOWyFgk6zs+Y
         ck4I9HGa+pa4M9Z6uT0AX5LvUTP89u5vPLGxigCvCI1XukL+S/Zl39lLczdZGNfZs1ct
         8Q7QaUgn74WnjDOgwcQL9Fk1SZ9qBdoVcUAd7+zmY3Kyxt45lptcGSo1dFe7U5yoFklG
         sK/E2527LzX9eL+BWTqzc8J/wLLDOH37YKu1Ug0mVTbOvAPIXzgGxMIJ7nce60kyrosJ
         0FNBrvqlOjRC3hWGz1hntzKEkKVw1csPnKPXgZEQ0LOV7iGSAcOHi/QtDLiJtYvgIg/j
         gviA==
X-Gm-Message-State: AG10YOSSNMU2l/Dc+VzOTMsJzP0J5XbtlQh5SsDHbokiBXKtTT4+RoqVfaY4xgy6YI/6FFGDYI/aV1WSu7xxiA==
X-Received: by 10.194.173.233 with SMTP id bn9mr14913442wjc.1.1454691766614;
 Fri, 05 Feb 2016 09:02:46 -0800 (PST)
Received: by 10.194.178.161 with HTTP; Fri, 5 Feb 2016 09:02:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285588>

I guess I found the view documentation in git-log and git-rev-list man pages

For some reason my brain also slightly resists permanently learning
what some of the arrows, search, find fields etc at the top level do.

Might tooltips for all this stuff be helpful?
