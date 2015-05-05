From: Alangi Derick <alangiderick@gmail.com>
Subject: Re-consideration
Date: Tue, 5 May 2015 19:22:15 +0100
Message-ID: <CAKB+oNuBBsSKvxC-a2RYj-8w7fg6HeCWJGo5CFP0KO_XbhGPiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 20:22:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YphU9-00019W-LO
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 20:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762836AbbEESWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 14:22:19 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35193 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbbEESWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 14:22:16 -0400
Received: by qgej70 with SMTP id j70so85822205qge.2
        for <git@vger.kernel.org>; Tue, 05 May 2015 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=MOq1Oc+EG5Bxnj+UXMy0FnKa565+RCycRVqORHUleWc=;
        b=bRK1VHAYMiDc2t+B79FcG4cLL26R2o8Krf2JaLMMiNakLbLe9h1X7mUbAaWeF5y2QF
         gB0f5bqqbwfYxch7pVsFv/psLqPuJjxrCBIqOlBCUNSVJNjqpDVM1IW5rNU86KR84y40
         CfemCbvVCazWPUgLJL5Z+DeWsAnYCyHpuqqSeP5lcdxnoAvtaJGOqnNvsTJ4X9KzkLA5
         pkmrg0KQcbXmdy94lw7v15M0q2dQcBrfMJp+ZdlYDXZo6aUenjwwmU7yZhrOM/7hSMmL
         yygZPirv3lFHOtmZOYz/FXg219MkSgS2u/e6E2zVjwR1BFm0EQWD7tmP9dDtuwLR1PEh
         qMkA==
X-Received: by 10.140.100.200 with SMTP id s66mr35051891qge.1.1430850136018;
 Tue, 05 May 2015 11:22:16 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Tue, 5 May 2015 11:22:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268412>

Hello,
     Considering the patches i submitted, i was making a research on
plumbing and porcelain commands. But till now, i am still reading
about it meaning i want the members of the mailing list to reconsider
and i will submit a patch concerning the translation so that we debate
and discuss on. If the patch stands and is accepted, then i will
continue submission of patches in that same line.
      For the mean time, i will like someone on the mailing list to
give me and example of what i will be translating, but i bare in mind
that i will be working with porcelain commands since they are what
users want as compared to the plumbing commands(scripts) which is low
level and should not be translated.

What i thought i was to do was that, if i see a statement like this;
    die("something");
i will translate it to
    die(_("something"));
but it seems i am not quiet doing the right thing. So will like
someone who is familiar with the translation format to give me and
example so i can spear head from there.

Regards
Alangi Derick Ndimnain
