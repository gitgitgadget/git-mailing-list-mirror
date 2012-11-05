From: Francis Moreau <francis.moro@gmail.com>
Subject: why '--init' in git-submodule update
Date: Mon, 5 Nov 2012 17:30:51 +0100
Message-ID: <CAC9WiBgpHWFGW-z5fnQR_EWnfGJUw+G3b7C6tYMGuVu1S-kP9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 17:31:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVPZp-0003QT-7y
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 17:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab2KEQaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 11:30:52 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38377 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412Ab2KEQav (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 11:30:51 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5871088obb.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=mYzOp2UiCxbRegBC81ksphahDN87j+yiO357DweCH3g=;
        b=SvRBZR4yrpYh3/ZBV2lPyzJKTfjYJZTPnY8Fp/tcrvPz1xZR7AvxN0ER0HL5Gh3Q/C
         SYe2ngs4x4DqX7oVO1WOUibYORj7qNVOd2eWnOxlK98TFo8u5FsR15vinwL3tctCMq7m
         ouTfrLlXA2TdMrva4ji7llb0BDGYEKWmFMhkdg38NuMTQEj+VqePS5jr5uh2wsKwqieB
         hKiq5K6XkjU37LfwHqwYsm92/o5hOxrVS9iUQ2E8s5gs7u8O0xlPuNUYGjfQ+BaKTBxE
         98Y6kJoXMUVIPvhcn3bv1mBbvVK5ppQWeoh2WY0jePLyajjczMUGbf3bMmT9peIyJsgt
         WmgQ==
Received: by 10.60.172.48 with SMTP id az16mr8098946oec.64.1352133051289; Mon,
 05 Nov 2012 08:30:51 -0800 (PST)
Received: by 10.60.93.163 with HTTP; Mon, 5 Nov 2012 08:30:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209075>

Hello,

I'm wondering why the --init option from git-submodule-update is not
at least the defaut. Or even wilder, why this option exists at all and
git-submodule-update always behave like --init was always passed.

Thanks
--
Francis
