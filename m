From: Joel Costigliola <joel.costigliola@gmail.com>
Subject: http://git-scm.com/docs/git-rebase is (partially) not well formatted
Date: Mon, 14 May 2012 13:44:45 +0200
Message-ID: <CAC0j=P0ggu4XuL==7mku08D3z7coQQbxsy2sfB-0EFO7k9SESQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 13:44:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STthr-0004S8-LQ
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 13:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab2ENLoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 07:44:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56703 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681Ab2ENLoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 07:44:46 -0400
Received: by yhmm54 with SMTP id m54so4066597yhm.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=07KsEN+x+n+DKRSxDvCnvWrMrftdivPCdq+/FcW8w7Q=;
        b=M6zlA4jeeLi9AGZGEr02C3XVjC3uHBylJmDjJj05scJmLHqOun8Bv3z70FY7a+8FJN
         QR/bay3iYebUkKMXrr2tMODC5iLPgVln5mUWJahIHpTXgTnAHsnJAnxwWSvO7/f+IE3R
         1OoRakpG5KdRhxanG7wFPYNhfpPfAPAnONBbo4FuyrEF2BB/KR8k8OoOHrwMEYRssKNI
         znjZQVIKND4tDhPNgO6f1a80YCMd22SI5/JhfBUkE4OxEkBIAteZSoHqRPGrLq9TNSoe
         5tPJVn/YyVH2fnBhEtobiO+ery6UcuZ/bSg8YWzghtFGOjkyG39f/sLcybCa7ALe9Txf
         cnvQ==
Received: by 10.236.173.135 with SMTP id v7mr3274151yhl.19.1336995885865; Mon,
 14 May 2012 04:44:45 -0700 (PDT)
Received: by 10.236.173.42 with HTTP; Mon, 14 May 2012 04:44:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197767>

Hi,

I just wanted to point out that the rebase reference doc page
http://git-scm.com/docs/git-rebase is partially unreadable.
It is ok and nice until phrase :
"This is useful if F and G were flawed in some way, or should not be
part of topicA. Note that the argument to --onto and the <upstream>
parameter can be any valid commit-ish."

Then the formatting is improper, no more paragraph or special
formatting for command.

Regards,

Joel
