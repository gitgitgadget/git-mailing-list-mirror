From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Git ticket / issue tracking ERA: Git shouldn't allow to push a
 new branch called HEAD
Date: Tue, 22 Nov 2011 16:56:12 +0100
Message-ID: <1321977372.3289.38.camel@mastroc3.mobc3.local>
References: <1321970646.3289.19.camel@mastroc3.mobc3.local>
	 <CAH5451==iXuB=QPW7bQvahB-jMnKC2axJYnW2OfFq=UNO9U6mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 16:54:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSsfq-00007l-4i
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 16:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab1KVPyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 10:54:09 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55846 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752Ab1KVPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 10:54:08 -0500
Received: by eye27 with SMTP id 27so327783eye.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 07:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:content-transfer-encoding:mime-version;
        bh=j5cES/rpkf+HFFieNT4OeMs+67Ozcp5K+bQrqWNyEC4=;
        b=Gxzxtz94EFrmzzrY47qC720LnsRq2VIzw6WI+xXPYJjQSdzxlZnRsRo3SdByxqe7ib
         9TSHZuwHqG+dqY2bM44qtYoLUpb6U2i2/sqp4MVc/cEY6UBtcFxruNFHd788Z6hgpj85
         vnU3byehg6GK18ydxawopR8ktwgTaVO5juKyA=
Received: by 10.213.32.197 with SMTP id e5mr1594730ebd.142.1321977247452;
        Tue, 22 Nov 2011 07:54:07 -0800 (PST)
Received: from [192.168.1.64] (host244-74-dynamic.0-79-r.retail.telecomitalia.it. [79.0.74.244])
        by mx.google.com with ESMTPS id o4sm43031987eeb.0.2011.11.22.07.54.05
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 07:54:06 -0800 (PST)
In-Reply-To: <CAH5451==iXuB=QPW7bQvahB-jMnKC2axJYnW2OfFq=UNO9U6mg@mail.gmail.com>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185798>

On Wed, 2011-11-23 at 01:29 +1100, Andrew Ardill wrote:
> > Since the *official* repo is now hosted on github, why don't making
> use
> > of the github ticketing system? [1]
> 
> From memory, only members of an organisation/owner of an account can
> manage tickets on github. This would be difficult to organise for
> git. 

Well... Actually I think the mailing list works pretty well.

And the ticketing system would only be useful to use as a shared TODO
list.

Let me explain my idea with an example:

An issue is discussed, a bug is acknowledged and a proposed solution is
discussed, this all happen in the mailing list, like it always has.

Someone in the "git management" (the one that usually choose how git
should evolve) open a ticket, copy the relevant part of the mailing list
(or link to the discussion in the archive) and (optionally) place the
bug / feature / enhancement into a roadmap / milestone

If the issue is not assigned anyone can see it and come by in the email
with a patch proposal.

This is just an idea, I can't propose myself to such a job, I wouldn't
be able to provide the appropriate support to it.

> > You probably already discussed this tons of times but I can't figure
> out
> > how you are gonna remember to do something if you don't have a
> roadmap
> > and a ticketing system that allow you to trace the bugs and
> features.


> We have previously discussed this, and it boils down to "if someone
> can ensure it is maintained, let's do it". So far no-one has put their
> hand up and there is a fear of the system becoming clogged with many
> issues that are not maintained. 

I see, I can understand why, it's hard to just find the time to read all
the messages in this mailing list.

Regards,
Daniele Segato
