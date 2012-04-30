From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Glossary for bootstrapping Git translations
Date: Mon, 30 Apr 2012 18:29:30 +0700
Message-ID: <CACsJy8C6QLYz1fks=r7KbvS80x=x7ZpzfE3ACGOv1S3YEPH4qw@mail.gmail.com>
References: <CACBZZX7H8qB05qc+ovaeFJ_qR3bF7=uWq6bjOHq8+_YNDLTu2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Hinrik_=C3=96rn_Sigur=C3=B0sson?= <hinrik.sig@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Xin Jiang <worldhello.net@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 13:30:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOonx-0007Qx-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 13:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574Ab2D3LaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 07:30:04 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44546 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab2D3LaC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 07:30:02 -0400
Received: by wejx9 with SMTP id x9so1739989wej.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AHHMVYo2/akvX57GCM+cDviZQfz6VTW8FjPgZESrzmk=;
        b=zQBZTZTe3kTAjIWxgula/VqYpQc8kKFh46Fo5HdfebnyB8BWMu1eBjqNFVaXaaJVlG
         P4Ofa4bxHi6rD/keA3M3NS+F8dLYXTo8z/Z8nd88diyP1ul4BnzE6IKGCyTPubzJjhPm
         Nvw6tfpN/vyKCVPhcW6FlYTaI79gwPQ7c++tYJYzb3OgDYbIl3+GBTI1Osfeqhqc91Nz
         +iVrJOxWbV9qB4PfKbPfXHSu1CHGT/s+CZksNKDL2vzNsmEBGU6x0ce1N/dlg3NE/nBZ
         yP5tmv0K3Q4sDLsaGb3F3B5aKkwPWMqVgjXCxSVQNSePD0Utx97lUryiuckNB+2T0XlN
         akkw==
Received: by 10.180.81.166 with SMTP id b6mr8639782wiy.0.1335785400900; Mon,
 30 Apr 2012 04:30:00 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Mon, 30 Apr 2012 04:29:30 -0700 (PDT)
In-Reply-To: <CACBZZX7H8qB05qc+ovaeFJ_qR3bF7=uWq6bjOHq8+_YNDLTu2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196554>

2012/4/30 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
> I think having something like this in po/GLOSSARY or in a similar
> location would be very useful to get new translators started. I'm
> CC-ing the other translation leads so they can look the English core
> terms I've come up with over, and suggest new ones.

Just checking. Have you looked at Documentation/glossary-content.txt?
That and this glossary may not be exactly the same, but you should be
able to copy some terms from there (e.g. pathspec), or even add some
back.
--=20
Duy
