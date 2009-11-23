From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: new 'add-envelope' option
Date: Mon, 23 Nov 2009 22:13:10 +0200
Message-ID: <94a0d4530911231213k6ec3d4f4hb7bc293b8ddf92e8@mail.gmail.com>
References: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
	 <20091121193600.GA3296@coredump.intra.peff.net>
	 <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
	 <7v1vjrmfjw.fsf@alter.siamese.dyndns.org>
	 <94a0d4530911220403w7238dab7saf18830a89f2add5@mail.gmail.com>
	 <7v6392h2d9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 21:13:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCfHj-0004fj-0D
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 21:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597AbZKWUNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 15:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756014AbZKWUNG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 15:13:06 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:64345 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990AbZKWUNF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 15:13:05 -0500
Received: by yxe17 with SMTP id 17so5025853yxe.33
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 12:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=9NF+y28mapNG+VFWNRC8HySD3xbfaF+8nYxW4SzfoDY=;
        b=qqa046AqrgqtkY1YSpp1DE01wS/LqDI1sg89Qg3WdhlC1Oqw0hvdJE3YGk5H6JRv95
         N9F7hFMO8vdM/QAndA7ivckAPrqoEUZyNZCiEr9soOv+X+CVSk9C2vAi9T2O5UaiKQNM
         u1N/HhxAwtsv5prF+QL4Mwfi/A6+I58VtXGCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=q/kq4y9MfuDpVvZJpeoCDS0srl3WiuEK23WTqolZKZL6Ubou0F+SmiZAwdxFMr1x0D
         auJpxhZEG7fL9PlM1jnbEyJiIvjkIGrIwC2wGwHMI9dz+S4u/yeZAjx5ENQ9P1OA1D4u
         KHTGF3jh5VitZHMOUOzTZKOGSGTeuCgzF4E80=
Received: by 10.231.120.136 with SMTP id d8mr3253503ibr.14.1259007191038; Mon, 
	23 Nov 2009 12:13:11 -0800 (PST)
In-Reply-To: <7v6392h2d9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133531>

On Sun, Nov 22, 2009 at 7:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> You can say that if you want to be difficult to work with, or you can be
> that somebody yourself and make a difference.

Being difficult to work with goes both ways. You as a maintainer are
entitled to say "I won't accept this without test cases", and I as a
contributor am entitled to say "I'm not going to do that". Since I'm
doing this on my free time I'd rather work on the things I like, which
doesn't include writing test cases from scratch, primarily because I'm
not familiar with them.

> Let me show you that we can be constructive for a change ;-)
>
> How about something trivial like this?

Looks good to me, but again, that doesn't say much.

Cheers.

-- 
Felipe Contreras
