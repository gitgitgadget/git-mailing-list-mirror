From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.7.0 round 1
Date: Sat, 12 Dec 2015 09:27:13 +0800
Message-ID: <CANYiYbH=Q0OMyvsE2ErEr0WqzrXbbH5GjcYah2PAbkv1suh4xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	"Ying Ruei Liang (KK)" <thumbd03803@gmail.com>,
	babycaseny <babycaseny@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Changwoo Ryu <cwryu@debian.org>
X-From: git-owner@vger.kernel.org Sat Dec 12 02:27:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Yy0-00046n-2s
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 02:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbbLLB1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2015 20:27:15 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38770 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbbLLB1O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2015 20:27:14 -0500
Received: by wmec201 with SMTP id c201so92597223wme.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 17:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x9APmXKOuM/svGAPLxotPcvJk0UdL6M76f+3jpajx44=;
        b=B7EgnJlIgaNcoh9ZrQpsJEf83sNEWOBAr2l3nAbvNdQ0MT1rYKRk6AhO7lsmvTt1uz
         Ezodqujh+L/Pxy1KNqRg4bkXV5ZahnFB7ljhFpt4qqf4bkWTnL360Aj/ilReOq2eHrCW
         cfGNebhQJ8hixJr5DhKDGhwxkXRVuWtd0uYE9PF57/12qnHjgxt7DwD6tRZbog9vjnDs
         M2FwzcVowZItnNfW973Mr+bQ5BMxEuJRSKjfZ0rNdlK47fa/hErwOSlEB3/bN1H3yOi2
         YlN8sT4cl7pYDQo54ev4wELM1icM2F3BXSZ9HfHeRSBmWX/SxMWnOqMO5rO5qHHY9akD
         BTzA==
X-Received: by 10.28.23.136 with SMTP id 130mr10134955wmx.94.1449883633718;
 Fri, 11 Dec 2015 17:27:13 -0800 (PST)
Received: by 10.194.83.226 with HTTP; Fri, 11 Dec 2015 17:27:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282295>

Hi guys,

Git v2.7.0-rc0 has been released, and it's time to start new round of g=
it l10n.
This time there are 66 updated messages need to be translated since las=
t
update:

    l10n: git.pot: v2.7.0 round 1 (66 new, 29 removed)

    Generate po/git.pot from v2.7.0-rc0 for git v2.7.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
