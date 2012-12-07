From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/6] Improve remote helper documentation
Date: Fri, 7 Dec 2012 12:26:44 -0800
Message-ID: <CAGdFq_j-zXfCAWpwzxOYdzYgHovfqBj1xHJTy07y-bCvr-aqMQ@mail.gmail.com>
References: <1354038279-76475-1-git-send-email-max@quendi.de> <7v1uf1he6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 21:27:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th4WR-0002be-IT
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 21:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424196Ab2LGU11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 15:27:27 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:54753 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424191Ab2LGU1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 15:27:25 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so874256qad.19
        for <git@vger.kernel.org>; Fri, 07 Dec 2012 12:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zx9P6tWgJ5UcsL7v0ltDc3Lbe394HOJvtsUVN2sqi30=;
        b=B3YpLuA6DRxIFQXjg0AmEkFuZGqBia7RpFoNWSSTF6HwNqLp0XVbTk88yuGAqcf1cv
         SVFzlK7T4oYPc3lp3Zhr5gS0RamPqeRbLIsS9UJVeK7YGGHprI07BMQ9mWYPLX4tRZ91
         DrqVOeecGCKGA+Yx+4aM9aK47e8CnjCEXLEwGdM2TBu9wu9We5bZuk2CPinOOMMy+ORl
         clrN9EY68xzAMcLcHNeeQf1RX2ZtFI1swKuwtZHstibTsFZILAWjFEFkMj4FYY2gXupp
         NEb2ApdOei0p35fbBPxYmgjAnr+GNvPhbTjlux3DU+4+3mLBqSrDMbSzmrtqWUOXCn14
         KxHQ==
Received: by 10.224.210.194 with SMTP id gl2mr11674145qab.32.1354912044916;
 Fri, 07 Dec 2012 12:27:24 -0800 (PST)
Received: by 10.49.51.227 with HTTP; Fri, 7 Dec 2012 12:26:44 -0800 (PST)
In-Reply-To: <7v1uf1he6m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211191>

On Fri, Dec 7, 2012 at 11:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> A second ping to people who have touched transport-helper.c,
> remote-testsvn.c, git-remote-testgit, and contrib/remote-helpers/ in
> the past 18 months for comments.  I've re-read the documentation
> updates myself and didn't find anything majorly objectionable.

FWIW:

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier
