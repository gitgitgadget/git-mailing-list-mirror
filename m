From: Jiang Xin <worldhello.net@gmail.com>
Subject: New git.pot is generated for the start of git 1.8.1 l10n
Date: Fri, 23 Nov 2012 14:58:30 +0800
Message-ID: <CANYiYbENFqCB2KiqNk88fOsEHTGY5zXKhLg+Bp8LXgjNN3YoyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>
X-From: git-owner@vger.kernel.org Fri Nov 23 07:58:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbnDq-0008WB-29
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 07:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741Ab2KWG6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 01:58:31 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55014 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612Ab2KWG6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 01:58:30 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2959326iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 22:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Xx+0vZCk+WQeBxTH7iRlXsdHAAwMEk1FDqF9XlAtNC4=;
        b=uYb5mAWdn6L4vlsx1b/q/ahnCUJWyY3Q2tggZu1vQ5X6vE643xTgSijUpLbAPWoLoO
         YqnOni1ZDjyjXB1WXvZ5rDOqRNLVtF0Jptz90500DUSNXJUXbcMcJqRCREmdCC8hD1AC
         WUuoTCwZhhthPQ+Jjn43jm9YpNnUyp5UpmUHoKqh7eP7zc06N6a9UJzWlpTegznFXk1m
         RShKP3HT5FDI/tOhx6DmaUC2V1it1DLNWmvqBqO/o14FK3ZgHWFgcyrQvKbd32VK2LID
         VT5HIVlU+go/WzP1acdT6kNxuiAgrTyb1soJKEYUjEHjSMM4K/iHuloiFWh/L5h0Eyjh
         PjHA==
Received: by 10.43.1.65 with SMTP id np1mr2404084icb.23.1353653910390; Thu, 22
 Nov 2012 22:58:30 -0800 (PST)
Received: by 10.50.186.135 with HTTP; Thu, 22 Nov 2012 22:58:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210238>

Dear l10n team members,

New "git.pot" is generated from v1.8.0-273-g2d242 in the master branch.

    l10n: Update git.pot (14 new, 3 removed messages)

    Generate po/git.pot from v1.8.0-273-g2d242, and there are 14 new and 3
    removed messages.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

This update is for the l10n of upcoming git 1.8.1. You can get it from
the usual place:

    https://github.com/git-l10n/git-po/

BTW, I'm sorry for this late, because these 2 months I am on a project and
have hardly any spare time. Push me using email if I am late again.

--
Jiang Xin
