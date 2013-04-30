From: Jiang Xin <worldhello.net@gmail.com>
Subject: Git 1.8.3 l10n round 2
Date: Tue, 30 Apr 2013 11:45:07 +0800
Message-ID: <CANYiYbHueuHFDeO19y6Qw8-con6o6y-vvq8zbiB_c=1YMJn6xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>,
	Harring Figueiredo <harringf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 05:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1VE-0007mv-QH
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758870Ab3D3DpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 23:45:10 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34401 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758796Ab3D3DpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:45:09 -0400
Received: by mail-wi0-f173.google.com with SMTP id c10so3450581wiw.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=G/P+mH1uELpn0qPwAmNVdH+htqspJhYpP6AJaHzboM8=;
        b=dvSJMutqyQ5+RxlTi/nt9HOc0dnTWlDoEXecTBJANS9Nr4ibTfk7naq1oezhSqWUbt
         O6FnfWblsq868r0tYli2K4ATG8xBgjtOdkVu1etpHc/pXXs/kAdPVBmNuunQPyUIQNvJ
         hIy4NbK/8Oru0tGYIBwBcTguY5LKzrGD7F7PFreIVKIwFnAuO/7kJXMEq6DEvUPYexr3
         stHwPnlRqH1CRgxoWXczfYbBLERf3kcH4Jhhv43OAHah40yGCMZb/YfQJLX7UVKXOMvR
         FVT2e+SUsvhxv6QTrMPZo5YLN7sSrSsdl03VvmrYLuqugHFSQ22FpgshR/xntk+y/y3M
         KKAw==
X-Received: by 10.180.86.230 with SMTP id s6mr21625855wiz.6.1367293508091;
 Mon, 29 Apr 2013 20:45:08 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Mon, 29 Apr 2013 20:45:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222903>

Hi all,

Since Git v1.8.3-rc0 had already been released, it's time to start new round
of git l10n. This time there are 44 new messages need to be translated.

A new "git.pot" is generated in commit v1.8.3-rc0-20-gc6bc7:

    l10n: git.pot: v1.8.3 round 2 (44 new, 12 removed)

    Generate po/git.pot from v1.8.3-rc0-19-g7e6a0 for git v1.8.3
    l10n round 2.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

This update is for the l10n of the upcoming git 1.8.3. You can get it
from the usual place:

    https://github.com/git-l10n/git-po/

--
Jiang Xin
