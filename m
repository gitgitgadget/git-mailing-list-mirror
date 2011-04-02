From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git enterprise setup on a large project
Date: Sun, 3 Apr 2011 00:45:58 +0200
Message-ID: <BANLkTi=HPxV9PojG01eY2B43F6VSzyEB7g@mail.gmail.com>
References: <BANLkTinEweaD=6tNZ+52NziCFL1MvNL=qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Frederic JECKER <frederic.jecker@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 00:46:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q69a4-00082d-MC
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 00:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229Ab1DBWqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 18:46:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51333 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab1DBWqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 18:46:00 -0400
Received: by bwz15 with SMTP id 15so3248788bwz.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HQNxhCotvF2gKpCl/nmQkKDeJImvFhYWfHyd/mme+u8=;
        b=agw6XygNIIEfwqxkYBrYF2OxStx5B7stH9Hs9zjQ2ipq4K1pvWboriIt0ILgK/r41H
         jzesQYtTlgX3grr9IQPH1XsyNSu5vxdxp0XNdg+PT8WDh7kFsuV396/zxKGIUnj86UMY
         LkR3o4Kz9Fbw+VYNxcH+xKP8aE4amwSNJp164=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jX2LeuKI9+jHOQ0+b//c8/ks0TC3OzRYurnIUiXGyYZe9y3NCn4PxIIkE/VXbsqfG9
         r2STRfXcfjdX0o+Pt+m1zuuWvhsPaWcwhRgudvvADV0iAGYS/qFccEZMdhn9HgfaLHZE
         2s62iIrfX5lci0dSJg7Gm/jC3kAjuWnCsP9VU=
Received: by 10.204.114.144 with SMTP id e16mr2881721bkq.119.1301784359342;
 Sat, 02 Apr 2011 15:45:59 -0700 (PDT)
Received: by 10.204.55.71 with HTTP; Sat, 2 Apr 2011 15:45:58 -0700 (PDT)
In-Reply-To: <BANLkTinEweaD=6tNZ+52NziCFL1MvNL=qA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170664>

On Saturday, April 2, 2011, Frederic JECKER <frederic.jecker@gmail.com> wrote:
> Sorry for posting here.. just found that there was also a git-users
> mailing list.
> Please ignore my post

This is the right place.

Git-users is something just something extra.
