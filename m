From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.6.0 round 1
Date: Sat, 5 Sep 2015 10:17:54 +0800
Message-ID: <CANYiYbEVU7A2w999jqLQ=V35WM0WTo--RHJHW7Ocw0FfsmqmLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 04:18:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY33e-0003CF-RS
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 04:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760318AbbIECR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2015 22:17:58 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37020 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbIECR4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2015 22:17:56 -0400
Received: by wicfx3 with SMTP id fx3so33326388wic.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 19:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TXkt1czq2mv8zcvaCwA3qOY/CEED7voBYle0/zoP4no=;
        b=Boe/nvjRAqBhYlFdwqdQhOTdo65BECoiGhxt2pgdaaqLwdj3/tn+jjjjco96/gNrgX
         goJtZ8E+QB5ImVV/9K9FNRBHa3tsCUkR69MZ+0VuYhfVKD9f/4AZ31IJRvZBwtPORwh/
         U7fNkUS1E3xd8wbAUM+6LDDLyCXBKHu0YggKr5TBtS/Yt1vrfmaQGfjOvTf/7yLqJdYl
         wbbaJcwQ04LFbjaWdWkM/jUiTA8uFsF4JTA0tqClI4XBVMML1yMuXJ3eIok0oel0vCrD
         lX/8zC0wPE10TTbzgxQbu+uiJxhabbWKDobV5YSZSWDToLJhoGjff65q64B90bWypEeH
         Az2A==
X-Received: by 10.180.100.74 with SMTP id ew10mr13198936wib.12.1441419474937;
 Fri, 04 Sep 2015 19:17:54 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Fri, 4 Sep 2015 19:17:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277360>

Hi,

Git v2.6.0-rc0 has been released, and it's time to start new round of g=
it l10n.
This time there are 123 updated messages need to be translated since la=
st
update:

    l10n: git.pot: v2.6.0 round 1 (123 new, 41 removed)

    Generate po/git.pot from v2.6.0-rc0-24-gec371ff for git v2.6.0 l10n
    round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
