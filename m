From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Startup of Git 2.1.0 l10n round 1
Date: Mon, 4 Aug 2014 17:11:42 +0800
Message-ID: <CANYiYbGPBZpYqh_C59-FxZ7HfHGGwxKQAHatBuAiJ4W87D+LEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Alexander Shopov <ash@kambanaria.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	"worldhello.net" <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 11:11:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEEJ6-0006n8-HV
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 11:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbaHDJLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2014 05:11:48 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:41041 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbaHDJLr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2014 05:11:47 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so7294592wgg.31
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2sdjmDz2W992MhTW+cnhYJGLksqvITUNIoH8cXQYCzA=;
        b=pmC5PYrUUmQgSV7di3q/5nO63CpBMNyurD6LZnU48yB8tGw4U4xc2L6tR+XqqdKCNm
         hhPXm5i1aDX+5qoqc56WuN3g6KeOkV5KNkXnutq/2+bDbJmvn4vw90Dd/0SQxAhuWQN6
         8BJ6w+8jOqpXn6YpLYdNn7PzKs/xN4BmZ005km/cobyW1SrfaXGbFwrtDwMoq9+QvCs/
         o4oEDLJcA+OPra5ojOjf42zhVGU6hW26NEWdaNcugc6dUGyfBPhRi64CkegFDADCa2ok
         sl0II3k0OKa/+ebkOMrutdsHPg1cyHQtCgAw5nhvmr1CLxlTr5L472Pu/anXNUEU2hnv
         CuLg==
X-Received: by 10.194.192.201 with SMTP id hi9mr29870599wjc.28.1407143502222;
 Mon, 04 Aug 2014 02:11:42 -0700 (PDT)
Received: by 10.194.58.200 with HTTP; Mon, 4 Aug 2014 02:11:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254734>

Hi,

Git v2.1.0-rc0 has been released for one week, and I'm sorry it's a bit=
 late to
announce the startup of new round of l10n.  This time there are 38 new
messages need to be translated since last update for v2.0.0:

    l10n: git.pot: v2.1.0 round 1 (38 new, 9 removed)

    Generate po/git.pot from v2.1.0-rc0 for git v2.1.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
