From: Gergely Buday <gbuday@gmail.com>
Subject: Re: git branch
Date: Mon, 23 May 2011 14:17:38 +0200
Message-ID: <BANLkTim_L0M2oFV383+5n7-X_KQTdd3BAg@mail.gmail.com>
References: <BANLkTinzped82Njnw4ZUeHY6Qu4R4hKK-w@mail.gmail.com>
	<20110523114633.GE7387@kennedy.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Mon May 23 14:18:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOU5N-0003nC-LW
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 14:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988Ab1EWMRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 08:17:41 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:55598 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab1EWMRj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 08:17:39 -0400
Received: by pxi16 with SMTP id 16so3772048pxi.4
        for <git@vger.kernel.org>; Mon, 23 May 2011 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MtmrAG5ccZ57grj+AgDIJu2lXprs2AA1BWsYWPwjT1U=;
        b=buGI2qiC5sc12GAkBY9Hn5Pg/Izi/MwIO04LaZ5DrX9j7zuaKAzYA5G307AXY8Xc7l
         EZbIlr8SZfMa5X82VueY3WMj+mDaVIanJpOg1qVPKJ90o0e+a48wnOOWuweultR+OMDm
         FWQ6ByhKhliuUOdbAf3my5MOQNmitpoTIJB5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=u0oJDHE6J38Qh1L4iasxosiK0yweEP9VqsY1t2KRBCOd00t3j6/8IU2+hNbRiLONST
         QA6588DRCKmKNxZSO9q2Sxw353M0VKTaftDq3ALpPQ4i/hvK1aBow1KYwdfELmC16yaj
         Lvul7BKMLU6lQHClzmE40gfIRYVn+/9f/SYkg=
Received: by 10.142.156.12 with SMTP id d12mr819356wfe.184.1306153058995; Mon,
 23 May 2011 05:17:38 -0700 (PDT)
Received: by 10.143.91.18 with HTTP; Mon, 23 May 2011 05:17:38 -0700 (PDT)
In-Reply-To: <20110523114633.GE7387@kennedy.acc.umu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174240>

> I'm not sure if I'm following you correctly, but with Git you need to
> check out your branch after creating it. Run git checkout install_2.0
> after you have created it.

Yes, that sounds reasonable. I did not know it was necessary to "switch to it".

- Gergely
