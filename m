From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 123 new messages
Date: Fri, 11 Sep 2015 17:40:08 +0200
Message-ID: <CAN0XMOKObCSMHNc+EDSj8uV-mDJ=pRFtdkZbfN4WQVpp4-Sufw@mail.gmail.com>
References: <1441985744-882-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Phillip Sz <phillip.szelat@gmail.com>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	Magnus G <magnus.goerlitz@googlemail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 17:40:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaQR4-0004Qg-CW
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 17:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbbIKPkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 11:40:10 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35445 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbbIKPkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 11:40:09 -0400
Received: by lbpo4 with SMTP id o4so41856505lbp.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f0/VMH5kY1KzoFogV2oIFzhZ8NvvCVG3k2Oz2X8vCTk=;
        b=JPKvpJq+WyDK8R2nvqxF/DsnZUNkQSU68yOyCpsKuFAMBhFil9QrET6zkVRuac7Hdj
         nQCPh2/WCX1uvYP2gMlHcEo2EqiETn0G+UUqNEy6ZXKdAy9azFzkW2GJKjl3Wvl9Lnr7
         lngs1ly64EXWZXE63xU4Kz1vBfQgl+xGTzcnAa3DvxUr0XmsjToZr5J8J7YTqoLHbz14
         NpPrIM6oma3RzIo25hcXqvAmXLpm++PxAu+gE7f99Ia4/UNCjCs5AAXEKanX682M2udU
         8rAnFWujydIOiR2flC/OC4QUaBwt8K9YLAxyjzR11QMSJ3gpeRo9zm7oqfFJOaQreayT
         N4mg==
X-Received: by 10.112.157.40 with SMTP id wj8mr10034405lbb.64.1441986008185;
 Fri, 11 Sep 2015 08:40:08 -0700 (PDT)
Received: by 10.25.201.211 with HTTP; Fri, 11 Sep 2015 08:40:08 -0700 (PDT)
In-Reply-To: <1441985744-882-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277674>

Am 11. September 2015 um 17:35 schrieb Ralf Thielow <ralf.thielow@gmail.com>:
> Translate 121 new messages came from git.pot update in df0617b

I forgot to change this part of the message. Should be 123, obviously.

> (l10n: git.pot: v2.6.0 round 1 (123 new, 41 removed)).
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 391 ++++++++++++++++++++++++++++++---------------------------------
>  1 file changed, 186 insertions(+), 205 deletions(-)
