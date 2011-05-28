From: Jakub Narebski <jnareb@gmail.com>
Subject: How would Git chapter look like in "The Architecture of Open Source Applications"?
Date: Sat, 28 May 2011 14:17:38 +0200
Message-ID: <201105281417.39883.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 14:17:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQISp-0007wC-SV
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 14:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925Ab1E1MRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 08:17:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44988 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab1E1MRt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2011 08:17:49 -0400
Received: by bwz15 with SMTP id 15so1881449bwz.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=NEXBnf3URxG95fw3hwx/ZQr4hoT91ult1KVeo28uxMw=;
        b=g4Af3dwlYgbqKgl+B20zkNE12j5YMxyicJGCaw1c5eszLzUgiyX0lsOoxomX8VZfcy
         jE14yttUlWeT9yQk0I9JZpibqCNTK+QwTzFj8xdI8wl3CbYRqUgtxXEtTMw2QgPWQS4O
         e8B6p9TXA2/nbSGz8A9LNDUYQiaiTFTeYIGOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=Z6hZdcRVJvhsKfsIWc+CQcP69wXd5Z6GSnp1VbnJqlOH0CxjVDWNkeu93d4XbBdY+A
         n1ZnokoL3xjpwVoOLx/ASxAsdCz1f3YHxG5iLUVKeiObLwA6sZvT0e0yWG1uZRoErZwA
         2oZttryDuxG3AywEli3QAjZ85RI3yAt/jS6Gk=
Received: by 10.204.136.213 with SMTP id s21mr2719560bkt.0.1306585068389;
        Sat, 28 May 2011 05:17:48 -0700 (PDT)
Received: from [192.168.1.13] (abvz93.neoplus.adsl.tpnet.pl [83.8.223.93])
        by mx.google.com with ESMTPS id t23sm1970246bkf.4.2011.05.28.05.17.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 May 2011 05:17:47 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174660>

>From LWN.net (http://lwn.net/Articles/444981/):

  "The Architecture of Open Source Applications"[1] is a new book with
  chapters on the design of a wide variety of programs, including
  Asterisk, bash, Eclipse, LLVM, *Mercurial*, Sendmail, Telepathy,
  and many more. It's available for purchase or downloadable under
  the terms of the CC Attribution 3.0 license; some readers have
  already taken advantage of that license to make an epub[2] version
  available. Revenue from sales go to Amnesty International.

[1]: http://www.aosabook.org/en/
[2]: http://media.dropdo.com.s3.amazonaws.com/2Wo/Architecture%20of%20Open%20Source%20Applications.epub

Among covered programs is Mercurial (chapter by Dirkjan Ochtman)...
but unfortunately no Git (they probably thought that one DVCS is enough).

How would such chapter on Git look like?  Authors of this book
encourage (among others) to write new chapters.

-- 
Jakub Narebski
Poland
