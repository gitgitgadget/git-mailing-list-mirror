From: Samuel Chase <samebchase@gmail.com>
Subject: User experience: git-remote-hg
Date: Sat, 18 May 2013 02:20:50 +0530
Message-ID: <CANxJqTwyYuQO8bXP=yV+-aPMMo4=KB08XfxehQZZM3nC+UkvPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 22:50:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdRc8-0005ok-1M
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 22:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152Ab3EQUuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 16:50:52 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:63019 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab3EQUuv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 16:50:51 -0400
Received: by mail-ee0-f42.google.com with SMTP id c50so2727578eek.1
        for <git@vger.kernel.org>; Fri, 17 May 2013 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=Yf/tq/HrJJb/n+rkNtTH9yHjvs/szIBZ5yZ0wiPLcwQ=;
        b=WfJsKBx7st0QuActryBCKEk6blEXkkpGhgEhsixOmb/MjOlVf0vuI99CXoW8LnwBId
         1YLgxKvcCr9ZOIKWw/POYiyVGWczHHnP64i2hh+kk7+oZJzxwjfqQtUIB38CVLU59PzT
         TTxBr4zmuZJNVv8x1fG39doSukk+p7eoBEZM8ZzYuzREkOS0PNZAXrwfwkaBgT0rGhwJ
         KD9vohHsV7LeEntbBTouCE8Mh5vibGu9Lr458+uxq8Md4QlFkfJSsmAUHc3hU2fqyxYz
         HAHwktam9bQ8Kt+W9ADBCKIOu6+nMFLIHpMFkWDc1yHASpnDvKaNRYIbu4r9NZ6190cm
         n3sA==
X-Received: by 10.15.27.199 with SMTP id p47mr5987085eeu.14.1368823850271;
 Fri, 17 May 2013 13:50:50 -0700 (PDT)
Received: by 10.14.144.135 with HTTP; Fri, 17 May 2013 13:50:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224736>

Greetings Git Developers,

I just used git-remote-hg to convert a small hg repository.

It worked perfectly.

Thanks, and happy hacking,

Samuel
