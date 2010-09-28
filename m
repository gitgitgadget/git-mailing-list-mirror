From: =?ISO-8859-2?Q?Gerg=F5_Balogh?= <geryxyz@gmail.com>
Subject: using git on sourceforge
Date: Wed, 29 Sep 2010 00:34:53 +0200
Message-ID: <AANLkTimejXBmV0TGeZ1=DA3tTe3HkUre4MHN9_UMomYN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 00:35:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ilH-0003hU-TV
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab0I1Wez convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 18:34:55 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55340 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab0I1Wey convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 18:34:54 -0400
Received: by qyk33 with SMTP id 33so210860qyk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=3cdq2z2XseopU6RcQXbdYMGkephpJTxpEhgAnrDOlVo=;
        b=FxW4F8Pb+T4p9dewLvqHkjo92oH2uZLnwZp7gdMJdvuRAw3IhU4UuKa+l9BLjXuQK0
         7TgKJ45ZiXNfFZ+FcaDI1MLJBrpuXURJiM+0mcxDPmSwy2J3g6csmS4vFTYrq5f8Mpo5
         I4iCUFdY/UQhR790JF1SaU9/6serCoDjaba6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=AnbNM+GeYGEw9l4Ky6RY4kMh65Y0t3UMHMHf0+uk8Y2GiMiMhiqmXAkcPxuyIC/7WE
         1T19ClD9cBn/q3xTJ0AMBkk3pLcoMQxPrbWZEyvE+yTGvfQPT863lrde2HAIhkBhoDtj
         sMoyd3xmohljj35HxP90boPDpNfImuXhwz1ts=
Received: by 10.224.44.151 with SMTP id a23mr526114qaf.6.1285713293794; Tue,
 28 Sep 2010 15:34:53 -0700 (PDT)
Received: by 10.229.28.66 with HTTP; Tue, 28 Sep 2010 15:34:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157493>

hello

I just looking some help to using sourceforge with git. Special I
can't push into my remove repo. I try the following command:

git remote add origin
ssh://geryxyz@kinim.git.sourceforge.net/gitroot/kinim/kinim
git push origin master

then I've got the following input and the git did not terminate (I
didn't get the prompt back):

Counting objects: 5, done.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (5/5), 1.34 KiB, done.
Total 5 (delta 0), reused 0 (delta 0)

please anybody explain what does that mean, and (if I made some
mistake) wher goes it wrong!
I try to do it using the GIT Extension tool too. It open the a command
line window at push and asking for the password. I type it then
everything stop. the window stay I thing forever. somethimes I get
this messages about the remote hung up the connection; the peer
terminated it; or just a warning that I try to pull an empty repo.
this last one is true.

please somebody help to me it need for my education at the university.

--=20
Gery [Balogh Gerg=F5]
