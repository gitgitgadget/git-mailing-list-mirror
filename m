From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Wed, 14 May 2014 14:35:08 -0500
Message-ID: <5373c56c5c531_56d6e3b30449@nysa.notmuch>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
 <1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
 <xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
 <536d4e7ba8ea_585ea5308a9@nysa.notmuch>
 <CACPiFCKoegOj+dxAw87UgrrwrvPSDoFzyxZV1bEPNseiK2M7vw@mail.gmail.com>
 <xmqqsiodo7o6.fsf@gitster.dls.corp.google.com>
 <53726a577d6aa_4aa4b312f862@nysa.notmuch>
 <xmqqegzxmlsr.fsf@gitster.dls.corp.google.com>
 <CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
 <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
 <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 21:46:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkf7z-0004DP-JZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 21:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbaENTqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 15:46:07 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:58919 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaENTqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 15:46:05 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so46680obc.21
        for <git@vger.kernel.org>; Wed, 14 May 2014 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=4Elp4hDFa4wmoIytmBzGhSWD8JEQzpKjEYZKpIaC6JM=;
        b=vYBWuMONIB+jtDHikiVKtATtoV9jsastrho1YkFp0hCTqG7j1vaRAxUFDSE+PJ5tdZ
         qdl8VBAPOaEhSSOah28/QByeRyZxrzo8dXAONrihRzTmfFr3Lfwn4VgsFE6YUMwh5mLh
         LMT/2wiY+/dRZhoSdbG3ivSxOiBHIxqy7HA8gk3A/JENtvIhe2WRVJHKA52CAt9AgbJH
         XRuFzTBsXGn4FhiY6N27BdhVEuauKuWq+317qsdwuuBer+MubvQvz9+MCcIuLa4+buN4
         sR+FKQlTzkFO0H30f7rrYrEwjBkrxynKfXddM7tVDh8PQoVtEVf3IhT4z5u0SGH3vKi9
         G8kA==
X-Received: by 10.60.37.199 with SMTP id a7mr5625533oek.41.1400096765253;
        Wed, 14 May 2014 12:46:05 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r3sm4876308obi.23.2014.05.14.12.46.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 12:46:04 -0700 (PDT)
In-Reply-To: <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248943>

Philippe Vaucher wrote:
> >> I have had patches and contributions rejected in the past, sometimes
> >> rudely. Same has happened to many others, if you contribute long
> >> enough, it is pretty much guaranteed that it will happen to you.
> >> Maintainer is wrong, or you are wrong, or someone is just having a bad
> >> day.
> >
> > This is not about a couple of patches I worked in a weekend being
> > rejected. This is about the work I've been doing since the past two
> > years almost like a full-time job dropped to the floor with no
> > explanation at all. I started with the expectation that they were going
> > to move to the core, because Junio said so, then he changed his mind and
> > didn't want to explain his reasoning.
> >
> > It's not just a bad day.
> 
> Here are two posts where Junio and Michael Haggerty explain the
> reasoning to you:
> 
> - http://article.gmane.org/gmane.comp.version-control.git/248727
> - http://article.gmane.org/gmane.comp.version-control.git/248693
> 
> Basically, in your case it boils down to your social manners.

You are not paying attention at all.

Junio did *not* use my social manners as a reason to block the
graduation, nor the quality of the code, he used a *TECHNICAL* reason.

Prior to his decision there were no complaints about my "manners" since
I returned. It was his *TECHNICAL* decision that triggered this.

Junio never explained his *TECHNICAL* reason, and Michael Haggerty
simply said "there are good technical arguments for and against
moving git-remote-hg out of contrib", that was all his explanation for
the *TECHNICAL* reason.

You, and other people, are using the behavior I displayed *AFTER* Junio
made his *TECHNICAL* decision as the cause for his decision not to
graduate. That's a wrong direction fallacy.

-- 
Felipe Contreras
