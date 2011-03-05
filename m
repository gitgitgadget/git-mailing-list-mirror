From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] Add link to git-cherry(1) in git-cherry-pick(1)
Date: Sat, 5 Mar 2011 20:12:40 +0100
Message-ID: <AANLkTi=QZhtByUe5h5w1MFrQ703MsWpoWHZcxvFsvNZk@mail.gmail.com>
References: <4D728A6A.8090507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 20:12:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvwuE-00031k-6L
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 20:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab1CETMl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2011 14:12:41 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43056 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab1CETMk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2011 14:12:40 -0500
Received: by vws12 with SMTP id 12so2830607vws.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 11:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=JZB96Qqf45dOVscQkStGLqX8NODkrwTdwrf1CD9J/wU=;
        b=AIEX0jA5/fRG7xGsi5gdzNb1HsEYJSDkSzk4mDw5d7dxavJSV4xF65ZNLzGWSWFPVf
         U5PM7U6+hbdUD4/pZ/tEJxMgAfQyASM5gIWOfvvK+HXyU7hmP8pMnVYikCleg6VSQ7j9
         Xc5I3B3DxUuc9zDzxJCa7qWMSRVsRC5Lz4MNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=VNM/X6Yq2xfrN8uIjOiZ4R9DL08tlNghvG9BafdvFZPuT+dzXRJ3cCsptilwE22yal
         wAHcB7N5ztFvWfd5KzTGNsjPBCkXuGW3k25rydN3r/yC90YBd4u5e0/bPEQ1PIJTqiv7
         YAsjf+P8OmEvGRJjQq0jEtndUptmGDkpdDr54=
Received: by 10.52.71.228 with SMTP id y4mr3107710vdu.28.1299352360316; Sat,
 05 Mar 2011 11:12:40 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Sat, 5 Mar 2011 11:12:40 -0800 (PST)
In-Reply-To: <4D728A6A.8090507@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168505>

Hm now I started to wonder: is git cherry the same as git branch --cont=
ains?

On Sat, Mar 5, 2011 at 8:09 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
>
> Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
> ---
> =A0Documentation/git-cherry-pick.txt | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-ch=
erry-pick.txt
> index 749d68a..c078cc9 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -162,7 +162,7 @@ Documentation by Junio C Hamano and the git-list =
<git@vger.kernel.org>.
>
> =A0SEE ALSO
> =A0--------
> -linkgit:git-revert[1]
> +linkgit:git-revert[1], linkgit:git-cherry[1]
>
> =A0GIT
> =A0---
> --
> 1.7.4.1.179.gb9a20
>
> --
> Piotr Krukowiecki
>



--=20
Piotrek
