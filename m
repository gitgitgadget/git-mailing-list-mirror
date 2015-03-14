From: Yurii Shevtsov <ungetch@gmail.com>
Subject: GSoC 2015. Microprojects
Date: Sat, 14 Mar 2015 22:24:10 +0200
Message-ID: <CAHLaBNLX8KGUhROzW80SiM507=YpbfqdSiPm7Vm9vwK6vW-Z+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 21:24:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWsbZ-0003zG-4l
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 21:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbbCNUYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 16:24:12 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33039 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbbCNUYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 16:24:11 -0400
Received: by oibu204 with SMTP id u204so10848312oib.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=46Gi+GprXm/CJh/ZGfLrD+JmAvk8UEN8ePBOt0c/zqs=;
        b=C5vrRxnASwsS3XrTBCujUYby9JTrPEnb7bIsapueEtbt5kfr4lGE9tXEnAPVuZX4rg
         XCezIP49UQBNnkK0QkBIYubsasJ20OLXmuo+u2SufJDG3c+DncforZC+JvO4ojwq4svB
         FWh77hzUY3zUS4zrwHhQZ74IPze35aO7RLooqcbUXRcqXX8JkYng6yW5L76bCj2e42LD
         G0yCdCT3UkOvvaMYJzadHGHBqCQBqGdHDx6WYz9nKPF1/a1FQj+35JYrvIdHA65yxuQP
         SlJ8uyE27+SH1XOW84HJ1SdvT12/vGANfLSvV/xGzUXAf4B6ohFChqtCa6+kF9B9DrE1
         f2ug==
X-Received: by 10.182.42.133 with SMTP id o5mr42679608obl.36.1426364650840;
 Sat, 14 Mar 2015 13:24:10 -0700 (PDT)
Received: by 10.76.10.170 with HTTP; Sat, 14 Mar 2015 13:24:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265458>

As I understood there are four unsolved microprojects. I think I can
deal with "Make "git diff --no-index $directory $file" DWIM better"
but I don't understand what exactly should I do. I tried to run 'git
diff --no-index ~/git/ diff.h' cmd on git sources but it says 'error:
file/directory conflict: /home/localhost/git/, diff.h'. I have used
git many times, but I'm not familiar with git diff. Thanks in advance!
