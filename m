From: Jiang Xin <worldhello.net@gmail.com>
Subject: Kickoff for Git 2.4.0 l10n round 2
Date: Fri, 3 Apr 2015 08:57:05 +0800
Message-ID: <CANYiYbH4z=3Sd7HaC9RZMd86F2aDbvEJvUTC=TGzUBSBt-UtWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 02:57:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydpv6-0005jc-FS
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 02:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbbDCA5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 20:57:08 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36557 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbDCA5G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 20:57:06 -0400
Received: by wizk4 with SMTP id k4so31345633wiz.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 17:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=SzrtG32p0WwReVCeOXeSgNpQtPIerccOAmWBZ6pTVGw=;
        b=WFYdfGuPJbGS/IO0F0XAWDsRdXH28mRqdiA4aG19+kZbZSk+qqSk4ffYqGqRqb33gl
         0xYz+hZYcyJGVXR52gOjFmDwXhRxg1LB/KJAwGjc+KpyJwSnPhO83YLOx34VZO9zSS8f
         HoYtWtqEeuM1zX5+5eCjE+GpKwb3UYYEAaf9DNTRmc9L8D1jqXxfKSMezjhqAWKuu4el
         iV7R100sjAg6xO1/mURvtkGRWJVD6SN4rXPAoJxzOVwk4K9B42jwP0//huTVDyBwdXPk
         ABPyqUwrjVrA0ONufBKj8MQZeltgOG/tCRX4nV93K9EUU+sGsf0tiYB6UdxtSxYPgSH/
         koWQ==
X-Received: by 10.180.126.69 with SMTP id mw5mr29938812wib.12.1428022625666;
 Thu, 02 Apr 2015 17:57:05 -0700 (PDT)
Received: by 10.194.234.33 with HTTP; Thu, 2 Apr 2015 17:57:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266697>

Hi,

Today after I merged pull request from Ralf, I found there is one new
l10n update from Git 2.4.0-rc1.  I also checked the 4 potential feature
branches ("Will merge to master") documented in whats-cooking.txt,
and I guess this is the last round for 2.4.0 l10n.

The new "git.pot" is generated in the master branch of git-l10n/git-po.

    l10n: git.pot: v2.4.0 round 2 (1 update)

    Generate po/git.pot from v2.4.0-rc1 for git v2.4.0 l10n round 2.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
