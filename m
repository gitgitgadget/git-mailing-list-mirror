From: Jiang Xin <worldhello.net@gmail.com>
Subject: Git 1.8.2 l10n round 3
Date: Tue, 19 Feb 2013 13:50:51 +0800
Message-ID: <CANYiYbHF1MAEcbhhf+PfawTzTxC06LFuZuccyeQUmtf8xXE8ig@mail.gmail.com>
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
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>
X-From: git-owner@vger.kernel.org Tue Feb 19 06:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7g6o-0007Bs-C9
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 06:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab3BSFux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 00:50:53 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:44730 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab3BSFuw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 00:50:52 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so5279990wgh.7
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 21:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=JLdUv7H+qXPxID0W88N7vZzprq50mm01MulOdKzjVl4=;
        b=m2QjtQZ5KnNN10nuAiTAikMVOu5Vg0w31QGjYauybSVnpw+QQHxpTN5Iz1yEhC/T/N
         K7eO/Gp7LTV6a9R8zHR3oVWrOydZUX5OspnbNT3HfG3rGbLrkB5Sh1bWaoXkCGF9LYgi
         aJBRDAwMAWpuAkw143l2Sax+PZt4b9Cg/aAZHtOUvevxquv7CqzPiApy6q9kfQnVrmyu
         JqJKjJ0xmV6SjO+R5uBdkKO243ujxVMyyizSrHtIzgxvA/Y43kwfYAhzMd7kFcXv5hZa
         0UGRDwhFvGvbNTRc9MAF7jmZOBwae7E3SsqetrqM96hR1M9RWhb8WKL7lvesAQSFhg2C
         W1ZQ==
X-Received: by 10.194.24.197 with SMTP id w5mr18985127wjf.9.1361253051476;
 Mon, 18 Feb 2013 21:50:51 -0800 (PST)
Received: by 10.194.110.199 with HTTP; Mon, 18 Feb 2013 21:50:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216564>

Hi,

Leaders of Git language teams please note that a new "git.pot" is
generated from v1.8.2-rc0-16-g20a59 in the master branch. See
commit:

    l10n: git.pot: v1.8.2 round 3 (5 new)

    Generate po/git.pot from v1.8.2-rc0-16-g20a59 for git v1.8.2
    l10n round 3.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

This update is for the l10n of the upcoming git 1.8.2. You can get it
from the usual place:

    https://github.com/git-l10n/git-po/

--
Jiang Xin
