From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Wed, 16 Nov 2011 11:04:25 +0400
Message-ID: <CACf55T5KPs5P76DWs_N4na5nV+ML9DGP84gFiKt0TvjijGE25Q@mail.gmail.com>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
	<CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 08:04:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQZXr-0007st-8V
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 08:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab1KPHE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 02:04:26 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57523 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab1KPHEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 02:04:25 -0500
Received: by pzk36 with SMTP id 36so17859452pzk.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 23:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dEzOBAf7/Iibk7TejrGkZEfYzuzMxTFVk5FIAG8Zqw4=;
        b=xLX6rJYUUwQIwMPBNkY97KSd8pXuJtlARcSCNj5qZpcX+pqmngdiJNgH9vk98SIoWJ
         ZDL9bh4F3ZRvPn0Vh2H5/411Z7VAYINRYUDmT3bpcg6WsI70MRt7dJRdj833Sy70INaJ
         s4KHzqoaxzrWGvWxOfhHHN0NmN2LC3cYNYyd0=
Received: by 10.68.59.98 with SMTP id y2mr29774731pbq.70.1321427065234; Tue,
 15 Nov 2011 23:04:25 -0800 (PST)
Received: by 10.68.66.230 with HTTP; Tue, 15 Nov 2011 23:04:25 -0800 (PST)
In-Reply-To: <CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185513>

2011/11/15 Shawn Pearce <spearce@spearce.org>:
> I would suggest starting over by downloading repo per [1] and using
> that script to start the process.
Cloning of the repo.git repository produces the same error
warning: remote HEAD refers to nonexistent ref, unable to checkout.

That is why I tried to use another repository...
