From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Noob question regarding git push
Date: Wed, 19 Jan 2011 23:50:27 +0100
Message-ID: <AANLkTik5QOoWNjUP8LvRE=AmiAtmchc8NND9aKDe2svR@mail.gmail.com>
References: <AANLkTi=X8PURGSX5ODHpXACUWuA0oioTkeNEmRVnkx1D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Harry Johnson <hjohnson@viasic.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 23:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfgrg-0003Bv-D2
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 23:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936Ab1ASWuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 17:50:50 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64648 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1ASWut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 17:50:49 -0500
Received: by yxt3 with SMTP id 3so611201yxt.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 14:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=EOJLAuDcCbk3Uf1i1ZAaZtQ6l2ZL2frhck/36kGFlWA=;
        b=K20KISTE7yW5jxXC1EfdGpz+g6WvcJFhIm07se/HmHAZ91yT8FfJxxzCNwWAN4BKn7
         3GYKDABduvkOX9FcXTovQ+RaQiX78ghsRcZhKLP1ni/8zSgqG6j+3AUhwX0LNUuSiOSW
         WrcUwFdgsw9x3Si4geoquMofXtuDrbsiUZcSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ssaqK/ekfg02R3Mg4/XK6DbLb/6I95L1zvwwOMo9q9Io4llbqTiThaT/KD8BTbApJL
         Ubbed1sjoA6NaMAS9X1NkL8TTpRKp60FBHQVHKGfJNYS8U7r2av8kXQT4z0uXBjF/7Sh
         LKHrjYkZb68fefKhZo8LRCkDWFsLaF6aBIbMk=
Received: by 10.151.78.10 with SMTP id f10mr1480917ybl.157.1295477448111; Wed,
 19 Jan 2011 14:50:48 -0800 (PST)
Received: by 10.151.6.10 with HTTP; Wed, 19 Jan 2011 14:50:27 -0800 (PST)
In-Reply-To: <AANLkTi=X8PURGSX5ODHpXACUWuA0oioTkeNEmRVnkx1D@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165298>

Heya,

On Wed, Jan 19, 2011 at 23:30, Harry Johnson <hjohnson@viasic.com> wrote:
> What's the proper technique for making sure you see the actual changes
> that were pushed to a repo?

I think this is the FAQ you want:

https://git.wiki.kernel.org/index.php/GitFaq#Why_won.27t_I_see_changes_in_the_remote_repo_after_.22git_push.22.3F


-- 
Cheers,

Sverre Rabbelier
