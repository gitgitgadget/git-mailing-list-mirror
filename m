From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: Please review this pull request for maint branch with update of de.po
Date: Fri, 11 May 2012 21:50:41 +0200
Message-ID: <CAN0XMOJLrGcB3=jy09b57FPc=ZoRxmo1Gx09vOLoxPexEe5fiQ@mail.gmail.com>
References: <CANYiYbFf73hVen2sg1viNrXxt-g+tP=bF_ryBF8JYp0ZAL0b6A@mail.gmail.com>
	<CANYiYbFiwvy8Lw+XQTehbc3k2FukrvhCvR6urfAR_3xVqXxNZA@mail.gmail.com>
	<7vtxzr1kbd.fsf@alter.siamese.dyndns.org>
	<87ipg75drv.fsf@thomas.inf.ethz.ch>
	<7vipg2le0u.fsf@alter.siamese.dyndns.org>
	<CAN0XMOKi7PMLC0fSpT3n1+fYL_Uop1XGiTi_BJCRuxPRRknd7Q@mail.gmail.com>
	<7vehqqld4w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 11 21:50:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSvrU-000546-JZ
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 21:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab2EKTun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 15:50:43 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60860 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab2EKTum (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 15:50:42 -0400
Received: by yenm10 with SMTP id m10so3012923yen.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LNih3DIEy94gqBqUuzfeHW0vzdBaH7jAJ0qwlbcFUrI=;
        b=pbd9PJ6yirAiHCDcCazPJqiW4DbENvgL5exRJe9WfwYrxo/hJDSzKyo31/Rlw7LXJg
         zpDbX7T7fs/bxdsxojY3y/mgMmhL3F+pfPo1psGSxBf88GwzinOEhI4Wg0e4rrz+4Otb
         QSMao4jRZ0AJaypS1Owg6VYUmnG5VxFTVvBuMDb1IDqH8zEt/HdzzaLnn+wCQDdiUbkI
         eRdTsi9bVqmkmBwizXI4ecuYA/FFfOCD4JKvzpXH8iam7OyWw6olFQKr3xQjOEL5jvm8
         9aF+gBU5YcWz/MgIAugHGDS3Jdh4htH6QGkmAyWNipJTcJAlHiNZwGQ7kqFRZW3Gw/ZG
         9cGg==
Received: by 10.236.108.199 with SMTP id q47mr11695873yhg.76.1336765841976;
 Fri, 11 May 2012 12:50:41 -0700 (PDT)
Received: by 10.146.218.6 with HTTP; Fri, 11 May 2012 12:50:41 -0700 (PDT)
In-Reply-To: <7vehqqld4w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197692>

On Fri, May 11, 2012 at 9:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ralf Thielow <ralf.thielow@googlemail.com> writes:
>
>> What about a README file like "/po" has?
>
> Sorry, but I cannot tell what you want to know about it.
>

This was just an idea to do it in the same way.
What I want to say is that there is a README file in the po folder which
telling people that if they want to change something here, they have
to go through
the git.l10n repo to get changes into the git-core repo.
That's presumably the same situation here, isn't it?
Just an idea.
