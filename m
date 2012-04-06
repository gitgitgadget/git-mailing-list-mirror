From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Fri, 6 Apr 2012 15:32:55 +0300
Message-ID: <CAMP44s0J5mzq+=WQ8KdYxXp2TNAYbA_X6qVVWgLg-=8rdOmEgg@mail.gmail.com>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 14:33:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG8Lg-0004KU-BP
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 14:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab2DFMc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 08:32:58 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:32920 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab2DFMc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 08:32:57 -0400
Received: by wejx9 with SMTP id x9so1434691wej.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mT2C8Wx4AAjov1I7XaCgbPkEWicPKk8LkvJ33flbv+s=;
        b=hj27qo2fJ8jlr7hPBj4zl5f4MOPidsdFrv5lwgJf4M/nyiXh6U9G1DD6HqgCOH7agx
         7k5RmD7TI2ATYChg8wXhCzq0waD9nIlnDCpDa3kUiqF9olq5QuJ/RdoJQ82Q2Xhm3Qdx
         pPXbFYt2KynPCDyjfdJ3+YaTxxhXUc58EA5Cy2L4yhibQjR/AG+UWlS6CMuo/jTwAxbp
         EyIF8woj6mASMhBPwf79VgbdLQR2AwpqbmRhzDS6K/vLH6xfq7PnzIVoZuH+oO448lTi
         cYMFecvPTsmDhy3tVY65/ZMvl9BwwjZtSWM0apzFckH7Lx/hdljdO2jIqJDwlZ7Y9qyx
         fh9Q==
Received: by 10.180.85.69 with SMTP id f5mr11501898wiz.18.1333715575854; Fri,
 06 Apr 2012 05:32:55 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 05:32:55 -0700 (PDT)
In-Reply-To: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194870>

On Fri, Apr 6, 2012 at 3:21 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Some mail servers (Microsoft Exchange) mangle the 'From' header, so
> while applying the patches, the author has to be fixed manually.
>
> This option allows to always specify the author of the commit in the
> body of the message, even if the committer is the author.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Some recipients don't exist any more; you might want to reply to this
message instead.

Cheers.

-- 
Felipe Contreras
