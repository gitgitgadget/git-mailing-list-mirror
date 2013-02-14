From: Jiang Xin <worldhello.net@gmail.com>
Subject: Git 1.8.2 l10n round 2
Date: Thu, 14 Feb 2013 15:36:56 +0800
Message-ID: <CANYiYbH0cmKVEC=JXX2Ze+_f7OWChBw04EP8j3bbMwdQHL0DcQ@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Feb 14 08:37:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5tNv-0007nL-FS
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 08:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033Ab3BNHg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 02:36:58 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:50933 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab3BNHg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 02:36:58 -0500
Received: by mail-we0-f174.google.com with SMTP id r6so1686568wey.5
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 23:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=OoHhWnz1Or597mNwyXsOcqSAmO8F9Zac5zmNCoJcRPc=;
        b=pJb/xx10PG4KeDLkM8WEwo1kxgTeUQJpxLiO+PbFFLEPTPVXQ9PgniXAtVzR79y4cJ
         sNnSfKAKANn18hyJwhSaEq9xtbMDiKKCQbNpvFAc6bpBTg6fbWkGpaG/Lk5mmeoIaSE1
         Vl704ZQm59B7JJCKxm7ljtRFhc803iG9GdnwApeUin622WD+SHygzYuqzwkExPTJfo1P
         ujzBIZbq4fGRIN0XwVSHvD0OL7rQ/uhdvdxqjLTwJ9M3klJtX3eKWOSBrXmM+r0ljwv7
         lred2w8gRmiGA6WWA49wwXECELq523MGxoHSThfepjY6+C013FWHJcpAiZq8gA+XoLKb
         rqjg==
X-Received: by 10.194.216.5 with SMTP id om5mr43254487wjc.27.1360827416324;
 Wed, 13 Feb 2013 23:36:56 -0800 (PST)
Received: by 10.194.82.170 with HTTP; Wed, 13 Feb 2013 23:36:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216301>

Hi,

Leaders of Git language teams please note that a new "git.pot" is
generated from v1.8.1.3-568-g5bf72 in the master branch. See
commit:

    l10n: Update git.pot (35 new, 14 removed messages)

    L10n for git 1.8.2 round 2: Generate po/git.pot from v1.8.1.3-568-g5bf72.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

This update is for the l10n of the upcoming git 1.8.2. You can get it
from the usual place:

    https://github.com/git-l10n/git-po/

--
Jiang Xin
