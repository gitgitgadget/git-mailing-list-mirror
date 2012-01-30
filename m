From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: L10n for Git in Chinese begins
Date: Mon, 30 Jan 2012 11:40:28 +0100
Message-ID: <CACBZZX5EEqT1qm4ZhZykSw9wBpE9uAgKH76yA-E9QvcRp-6uuQ@mail.gmail.com>
References: <4F265AEF.5020409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: worldhello.net@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 30 11:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrofO-0004K4-DX
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 11:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab2A3Kku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 05:40:50 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46993 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750900Ab2A3Kkt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 05:40:49 -0500
Received: by lagu2 with SMTP id u2so2095679lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ErvAjctjqMs8M6KGAtHX2BPX8lil+ley4rgCl4TGbjI=;
        b=GbBb78thV+1ZBFMwN1aGeIH88GTCn5KFoNYnycRFwpcJC0G1EUeksc5vl1xDG6xgbl
         WeFJpuq3EBPZYFXIv/ModCYzSBWPnQBlPHCc+j8+redAOlawYTNSH3RJRKzoFncVBADT
         wpk7OdNIeSXhPzTOJk8cmT4rYXc1X5Tv3Pa0E=
Received: by 10.112.9.3 with SMTP id v3mr4324214lba.36.1327920048157; Mon, 30
 Jan 2012 02:40:48 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Mon, 30 Jan 2012 02:40:28 -0800 (PST)
In-Reply-To: <4F265AEF.5020409@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189338>

2012/1/30 Jiang Xin <worldhello.net@gmail.com>:
> With the release of v1.7.9 or some earlier , Git is multilingual.
> I select some typical git commands and translated into Chinese,
> works nice.
>
> - git status (in c)
> - git stash (in bash)
>
> Now I create a repo in Github hosting the po file (zh_cn.po) for git.
>
> - repo: https://github.com/gotgit/git-l10n-zh-cn/
> - file: https://github.com/gotgit/git-l10n-zh-cn/blob/master/zh_cn.po
>
> Any help is appreciated, and will contribute here after 100% completed.

That's awesome, especially to get someone covering a really big
language whose speakers aren't usually near-native English speakers.

Please tell me if you have any problems, especially with the
instructions I added in po/README or anything else. I'd be happy to
fix them in Git if applicable.
