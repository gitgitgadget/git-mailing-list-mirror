From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Continued work on sr/vcs-helper and sr/gfi-options
Date: Mon, 7 Dec 2009 01:52:24 +0100
Message-ID: <fabb9a1e0912061652s3133a8c8s8b43bbc666c6016f@mail.gmail.com>
References: <fabb9a1e0912051653s77ba25e1g9ff1e21219cd06c9@mail.gmail.com> 
	<7vr5r8oov1.fsf@alter.siamese.dyndns.org> <fabb9a1e0912060223h148a67b0q589b8461dae6330e@mail.gmail.com> 
	<7vfx7nekuf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 01:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHRqQ-0003ha-5Y
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 01:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126AbZLGAwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 19:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758122AbZLGAwj
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 19:52:39 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:35834 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757674AbZLGAwi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 19:52:38 -0500
Received: by vws35 with SMTP id 35so1836418vws.4
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 16:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=xqtoW9MWptZ7xUY7+1N13Dp8I24D+5U9gSOrJNFFPGQ=;
        b=TfgCVnz0a3KPbmKz1tdHM7/2dPE/CcDxm2G9ptggdgqADwYGVymaan16qtFdEjhndU
         NKCYyPZ8In8/9re2nGt1y982CHj37fl/l9QK10fcZsiHP7YEuf0XQHFY+jlfLb6NwFLv
         HCT3LXJt9pJWpkDscwf4H6PK8eu39UyMyg/iU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Yg+otALqp0xddkJeVkFW52oHii3vkOlgSu8unaQPPZTLhVBVr+LwulmFzX+/UAq4F/
         /KwdYPbiJYgrucYkxhyGacZ6Q52N+Z7lb6VuYJfhq/wPnRSchoDZO0OUruPdjRZWS8E7
         3x4cHgCQvQkcTZ1q2sOprVdGQFVOYVCJu8aSI=
Received: by 10.220.125.5 with SMTP id w5mr7567709vcr.30.1260147164078; Sun, 
	06 Dec 2009 16:52:44 -0800 (PST)
In-Reply-To: <7vfx7nekuf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134703>

Heya,

On Mon, Dec 7, 2009 at 00:36, Junio C Hamano <gitster@pobox.com> wrote:
> It would make sense if you use 1.6.6 features in your new series (as the
> forkpoint of sr/vcs-helper is beginning to look a tad stale), but
> otherwise unnecessary; that is the reason why I said it is "(optional)"
> and it is up to what is in the remote-hg patch.

Gotcha, I don't think I use any 1.6.6 features though, so I don't
think that will be necessary.

> I was thinking about carrying it myself (perhaps with help from you in
> conflict resolution as necessary) when I wrote it

That would be great! If you are you offering to create the
sr/pu-remote-hg branch and merge it to pu so that I can send patches
based on that, please do. If not, what do I do instead? :).

-- 
Cheers,

Sverre Rabbelier
