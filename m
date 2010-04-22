From: Aghiles <aghilesk@gmail.com>
Subject: Re: git push in --tracked branches.
Date: Thu, 22 Apr 2010 15:52:16 -0400
Message-ID: <m2r3abd05a91004221252u497174bfi8a49215ad496295d@mail.gmail.com>
References: <y2w3abd05a91004211702qf4cd42bau20ac52a4d35a6bf1@mail.gmail.com> 
	<20100422004433.GC14249@coredump.intra.peff.net> <i2n3abd05a91004211813t8111c77am381bc0b8226a0c9b@mail.gmail.com> 
	<20100422015251.GA25093@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 21:52:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O52SH-0003Xs-Pp
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 21:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591Ab0DVTwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 15:52:45 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:43102 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585Ab0DVTwj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 15:52:39 -0400
Received: by wwb24 with SMTP id 24so5127947wwb.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 12:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=K3XzWUmDTjc9kwDksDB4YqppMkEHJL2UnfpbxZqOWWQ=;
        b=MteI4IjSUT5/7zYferW7D/cFep/B5utwK0HKvqCf7C69VqjwMrdvoAlcaVWWpS524M
         QDI6whbK+ZpBgFAvuwXOVGbqORMyjJksDN2x4gRe+nDK7vzADHKrOItbmvYSVbbirmr5
         BtozRVaktssLrG1k5v1x6KrF+oSU0dlB4ypE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=H8533K9JZ9oYzZaTGqhbtF1rvGL8RTCxgnZkcijfWHemNjYqfH/xcScQkESooWDVjE
         WfZfVr7qB3cOPFVItgK0PfhoHIljDv0NUseaJx2lKZ16dKN4rxyIAEEM6g2i+H1yKzXE
         7MSRk2Go4+PxFS0af9FfLst0f/5MgMx9dL7Zo=
Received: by 10.216.187.80 with HTTP; Thu, 22 Apr 2010 12:52:16 -0700 (PDT)
In-Reply-To: <20100422015251.GA25093@coredump.intra.peff.net>
Received: by 10.216.90.9 with SMTP id d9mr6005310wef.95.1271965957304; Thu, 22 
	Apr 2010 12:52:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145551>

Hello Jeff,

> Git grew out of the first type of workflow, and that has always been the
> default. Tools for helping the latter workflow have developed later.
> There was some discussion about changing the default, but it hurts
> people used to the current default, so we ended up with the config
> variable.

Thank you for the explanation. For what it's worth (probably 0) I vote
for the default to be 'tracking'.

  -- aghiles
