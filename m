From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t7006 sometimes hangs in cronjobs on OS X
Date: Sat, 12 Feb 2011 23:31:59 -0600
Message-ID: <20110213053159.GB15887@elie>
References: <201102091538.46594.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 13 06:32:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoUZB-0007Fv-A7
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 06:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909Ab1BMFcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 00:32:08 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46459 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1BMFcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 00:32:06 -0500
Received: by ywo7 with SMTP id 7so1637098ywo.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 21:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ABqiRLt41XGC0TRWeBkp99pxqxVJQHrf8qOhCYDMYlA=;
        b=LLnUwRiDYCMBNKpbpRLHnnuNlGYWUwebRmdgHWC1zuaw5XigBE+qYnA0O3s8n8hGjm
         z2D6cwVPZY/rmlR0v0tjzcWipx4zsmzGGeP34+lGtfb+1LGe3U3kl/PoNyXMZzP2qsJl
         nqYJ5PC5CMQ+ExUfzbGdEyCY5oescJexqQVVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XliE7v6eAEmL1N/2VI4wIKr1CgNo1P9xd89PmS2kop3jZBGukDyABokW+7/T87kDti
         3HkCRSGxRpiPqecx3RXJcYAtIJ632wMIVvjYoBFOGErGUyroL3s9xL73OOeZNN57ZUKn
         C3TZfXiBtp0ZCQuMWQJEcYBFmhjOr/KXNsoIc=
Received: by 10.101.138.19 with SMTP id q19mr361899ann.109.1297575124099;
        Sat, 12 Feb 2011 21:32:04 -0800 (PST)
Received: from elie (adsl-69-209-71-45.dsl.chcgil.sbcglobal.net [69.209.71.45])
        by mx.google.com with ESMTPS id w4sm1658222anw.16.2011.02.12.21.32.01
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 21:32:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201102091538.46594.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166640>

Thomas Rast wrote:

> So if you have any idea what the problem could be or what I should be
> looking for, help would be much appreciated...

Still no idea, but I've passed the report on.

https://rt.cpan.org/Ticket/Display.html?id=65692

Thanks, both.
