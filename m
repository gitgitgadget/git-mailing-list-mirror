From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.5.0 round 1
Date: Sat, 27 Jun 2015 19:46:00 +0800
Message-ID: <CANYiYbFTMxafBKoGkWVo1Ok1LRWK=6crtTJMnkD1CpsVEfgHEA@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Jun 27 13:46:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8oYl-0002lz-3Z
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 13:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbbF0LqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2015 07:46:05 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33234 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbbF0LqC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jun 2015 07:46:02 -0400
Received: by wgck11 with SMTP id k11so107036223wgc.0
        for <git@vger.kernel.org>; Sat, 27 Jun 2015 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9AWKXMN7sZrr0v1NLpTBGcbMEM1ur37kgg700+FnufY=;
        b=OpbuasDs86wZEMx0gjDihm5OU7Fabw2B0AJSP8Y4eD/lF99LKl5c7MMqbQL2bPnS0B
         nKVCXg48ey+fqBdxnTLnJvwg6KyTJnHI6LRHVWb/ZnzFD+bjrQ11/kqyOdX7DOCj2Mui
         pHaAlG29P+kPozVS0KrcPgQmv1llgzrQ7tC1POs/3Frd1kX35aBhnnjyBOfmn6FXkGSm
         q+8kaBSStI4nHT/TsBR2MMVLU8SkW5ulr101ACB6ecZEvJKR7oDx5vDnUhL7udctZhZ8
         w2pkNnV7OguqtvTFujbR4vdjM09ehRN6g+HT9D7KGoTNj6WHIy/z2DVRtRVJYEyXfcs2
         jaOw==
X-Received: by 10.194.189.80 with SMTP id gg16mr11605384wjc.9.1435405560389;
 Sat, 27 Jun 2015 04:46:00 -0700 (PDT)
Received: by 10.194.64.131 with HTTP; Sat, 27 Jun 2015 04:46:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272857>

Hi,

Git v2.5.0-rc0 has been released, and it's time to start new round of g=
it l10n.
This time there are 65 updated messages need to be translated since las=
t
update:

    l10n: git.pot: v2.5.0 round 1 (65 new, 15 removed)

    Generate po/git.pot from v2.5.0-rc0 for git v2.5.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
