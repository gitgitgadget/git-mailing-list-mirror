From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: Please review this pull request for maint branch with update of de.po
Date: Fri, 11 May 2012 21:37:13 +0200
Message-ID: <CAN0XMOKi7PMLC0fSpT3n1+fYL_Uop1XGiTi_BJCRuxPRRknd7Q@mail.gmail.com>
References: <CANYiYbFf73hVen2sg1viNrXxt-g+tP=bF_ryBF8JYp0ZAL0b6A@mail.gmail.com>
	<CANYiYbFiwvy8Lw+XQTehbc3k2FukrvhCvR6urfAR_3xVqXxNZA@mail.gmail.com>
	<7vtxzr1kbd.fsf@alter.siamese.dyndns.org>
	<87ipg75drv.fsf@thomas.inf.ethz.ch>
	<7vipg2le0u.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Fri May 11 21:37:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSveV-0005k1-BE
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 21:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663Ab2EKThQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 15:37:16 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51538 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422640Ab2EKThO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 15:37:14 -0400
Received: by yhmm54 with SMTP id m54so2965221yhm.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k0tG/7s34NrOXk8DHiaD4kOZ94MhNl9ztVw3Iw1A/WQ=;
        b=JtYmLKkNLt/4Xw/8FxWh23dfvTFhojtt5UwfBPSJdNh7hccXEZFpbWhuFcQcoE1S46
         q4WXMWyda/Xb+vBY/YgX8KOIj1v17x6PF27PtUDiR6aDIIis9WlcwdJanv3ZWoSGQuZC
         FZ20xkJQs5GcjI2Q0sfNiEJJtS9I7pZyjBcS2p+Doitrmc8wLMdYF2hxuwk6Xo2JqyxM
         Qg9OStbDbHS3VV5LxNQR8QI4tn0v9bPcGzRvrn1jjaNqkQTeLb3zv0eHPNsp5mgNgu7G
         GL5xV2sVRejLz7EW5KfVNbomI35UQeGpn7PmZkH4KBqDYexdmZM6mFDnDVAYcb6Ia6B6
         +IMg==
Received: by 10.236.182.131 with SMTP id o3mr11813622yhm.113.1336765033540;
 Fri, 11 May 2012 12:37:13 -0700 (PDT)
Received: by 10.146.218.6 with HTTP; Fri, 11 May 2012 12:37:13 -0700 (PDT)
In-Reply-To: <7vipg2le0u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197690>

What about a README file like "/po" has?
