From: John Tapsell <johnflux@gmail.com>
Subject: Re: Don't want to leave git for hg
Date: Wed, 18 Feb 2009 08:37:03 +0900
Message-ID: <43d8ce650902171537r753e9aa7ob91206092308c18b@mail.gmail.com>
References: <m27i3ou7fy.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 00:38:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZZWN-0001Lr-2F
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbZBQXhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbZBQXhH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:37:07 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:59784 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbZBQXhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:37:06 -0500
Received: by gxk22 with SMTP id 22so4783001gxk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 15:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=CVsGitabM2YCjzyPECNc3SIzMK23yublNsElUkQ8NY8=;
        b=tRjdEBy8m9RUu+GgzBNv85HAly+OHJzCUNBnZaXltXTeigCpI7t4T/XZF2hPnpowlZ
         41PyYjqRJd3Bl5Qk2xVSGFpoZ1flwoSYmCMVXCCFkA3pNOLQ9i+dgaxzcY4vvnvaBfkQ
         9okwr9P5XXPg0Ctd/0SC2AtKW3slymgVkSDE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=DIVcansjFI9Pe2E+/bUIqnKL1ZrZoIzEBbZBX6ol3E8OEqEUXyZD42oIpVh3AJaMGl
         Y/NeqGTMaEh4mLrGoFSJ524l1L0N3a8ZaB5LelOt/8i2pO05GH50ZeefrL5+Y4BxzSbP
         owHkFWwCrYmILvnw9LOJhQwR7KQU9NP0cIyE0=
Received: by 10.150.98.4 with SMTP id v4mr3685668ybb.158.1234913823596; Tue, 
	17 Feb 2009 15:37:03 -0800 (PST)
In-Reply-To: <m27i3ou7fy.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110475>

2009/2/18 Francis Moreau <francis.moro@gmail.com>:
> Hello,
>
> I unfortunately have to work on a hg repository.
>
> For reasons that all git users understand I still want to use git.
>
> So I'm wondering if others git users faced the same problem and if so
> how they did workaround it ?

Maybe just learn mercurial, and submit patches for any features that
you desperately miss?  I doubt your employer will want you faffing
around with hg2git etc just because of one or two minor missing
features.

> I found hg2git which could have solve my issue but it seems pretty old
> and no more maintained.
>
> Thanks
> --
> Francis
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
