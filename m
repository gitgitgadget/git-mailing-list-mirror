From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 13/13] Add Python support library for remote helpers
Date: Fri, 6 Nov 2009 01:14:04 +0100
Message-ID: <fabb9a1e0911051614j63d602adycdc7adec7a388b25@mail.gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> 
	<1257364098-1685-14-git-send-email-srabbelier@gmail.com> <200911050855.01164.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	David Aguilar <davvid@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 01:14:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6CTI-0003Dx-JU
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 01:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759111AbZKFAOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 19:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759104AbZKFAOV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 19:14:21 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:50570 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759028AbZKFAOU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 19:14:20 -0500
Received: by ewy3 with SMTP id 3so595052ewy.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 16:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=uDsgQt+SZ+zN2v8cJJEjVPG6wZR/6acYEFpKTH+4sFA=;
        b=pAPzjUZktTzXqdM1mUsC0cv5Bd5ZC5Mb7DrvgxD+2wGVpzsM1eMI9yVzG1Us2VDteq
         U8LTWv10PEGHl6aYi3LX4X7FbGG3qH2FPFz+XaH81H/wcrUUMNT7ykFpmQwyf48MbfJv
         cotGWrCOpcKqEaTklWhQT+ppd456hE7HM41Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=DWEGlgVK0R7fN6CjSzCllPpI7VsGFAJ9Ho4DutcSwIKXZ2bYUmfZRdjAVdyypaz9bR
         E1w/hsgWQ8BRcwabu4NPvDh8KoA/yMqpEV+p9rVqcSnall63L7svp9a3qoscopmUaMbq
         gPGGDQw7h+5Q+gXLYbjWqhH0CFJIf5TCMwSTI=
Received: by 10.216.91.5 with SMTP id g5mr1250292wef.168.1257466464102; Thu, 
	05 Nov 2009 16:14:24 -0800 (PST)
In-Reply-To: <200911050855.01164.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132254>

Heya,

On Thu, Nov 5, 2009 at 08:55, Johan Herland <johan@herland.net> wrote:
> There are a few typos in the above.

Thanks, fixed locally, will include this in the next version.

> Otherwise it all looks good. Nice work!

Cool, thanks!

-- 
Cheers,

Sverre Rabbelier
