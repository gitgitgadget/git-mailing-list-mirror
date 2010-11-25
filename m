From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: gitolite description
Date: Thu, 25 Nov 2010 06:17:27 +0530
Message-ID: <AANLkTi=Rb3UJrdimxsMic82XBzkuXoX_FVr69G026mWs@mail.gmail.com>
References: <20101124232359.38034ff1@jive.levalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Levente Kovacs <leventelist@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 01:47:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLPzr-0005jM-AJ
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 01:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab0KYAr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 19:47:29 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65451 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab0KYAr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 19:47:29 -0500
Received: by eye27 with SMTP id 27so190116eye.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 16:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7XphhmvTd0s3C+PIV45jVNPykDF3x4EgbsFqB5Pr1jQ=;
        b=KMaeTXjuP8o06VWSBRHFrKHHZniVUa4tRY3aT7xwpUA/3o0S462f6zZyZ/yKZkkFOw
         +GoI07j7Bc8avCpUhIjB8LRdRWYl35d/cUV9s+voI4+7f2EoBrtK5H27vTGRCAAoJMWQ
         vd7DcDrI9pO0j1Sfv9nxhNSJ1FV3GtIqnmSr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=EZ85IRNmpa38mRXoVnz86bazu++0TrtKqHeTc0CGx9TH65F/bAWcRKk8zpuORJIfMi
         /GLvHIrKqHFzx/G9x31imLc1EO8bvWuPDkF8G7pBRPU06FbaabgpJsxBlKcjoDwV2pgO
         Gy+ZfgkD+NmmOzyqCqylm7QLwNiVoNJRDeYO0=
Received: by 10.213.16.83 with SMTP id n19mr3592716eba.16.1290646047738; Wed,
 24 Nov 2010 16:47:27 -0800 (PST)
Received: by 10.213.108.81 with HTTP; Wed, 24 Nov 2010 16:47:27 -0800 (PST)
In-Reply-To: <20101124232359.38034ff1@jive.levalinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162095>

On Thu, Nov 25, 2010 at 3:53 AM, Levente Kovacs <leventelist@gmail.com> wrote:
> Hi list,
>
>
> I have a gitolite and gitweb environment. Each time I set up a repository, I
> have to ssh to my server and edit the description of the newly created
> repository.
>
> Is there any way to remotely edit the description?

https://github.com/sitaramc/gitolite/blob/pu/doc/2-admin.mkd#_specifying_gitweb_and_daemon_access
