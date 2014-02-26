From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take options
Date: Wed, 26 Feb 2014 22:55:14 +0800
Message-ID: <CALUzUxqr5ycLRshn9=w_RR3umUd27gCg67qunXC1d9djqKdm2w@mail.gmail.com>
References: <530DA00E.4090402@alum.mit.edu> <20140226105249.GE25711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 15:58:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIftd-0005TC-FE
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 15:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbaBZOzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 09:55:36 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:61601 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaBZOzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 09:55:36 -0500
Received: by mail-la0-f46.google.com with SMTP id hr17so701140lab.33
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 06:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+LiahWIPJrjy9DmN1pGUZXS9heBa41rS/qQQ2XW9sro=;
        b=WfLws6y4iMOweZ5igv0IG9rLRgYOFZIIsyWZidzDaLzorsu0DA86q5CgO2+/adPAZn
         Xmjf16R5XEqP4Z02p2BqNzUBMigwGgId/yAM3y38axhtmi0Lww5E9qVUI4Jg+4r4Z4ry
         B+pOPtRcOrCg/wVqPyOW+7PVBWbMMeStT015l74e0YY6OSLTZK9boo4I7f/dBUIPq1PR
         F622I16P/JZPpnpL6WlPI5tTIIqKDjOIISDX/5xXbKBP9P0zb99maJmWUCtO3mn6XOW9
         24nk4OcxcDmNphm+ouRZ1O9Z0+F8BOJ2dvmSP5xr48gJoh/7UtxCnyHu/OeM0KzTG1iM
         t/uw==
X-Received: by 10.112.65.36 with SMTP id u4mr108282lbs.90.1393426534507; Wed,
 26 Feb 2014 06:55:34 -0800 (PST)
Received: by 10.114.64.15 with HTTP; Wed, 26 Feb 2014 06:55:14 -0800 (PST)
In-Reply-To: <20140226105249.GE25711@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242730>

On Wed, Feb 26, 2014 at 6:52 PM, Jeff King <peff@peff.net> wrote:
> I'd worry a little that it is not a summer's worth of work, but I
> suspect there are other parts of rebase--interactive that could use
> attention once the student is familiar with the code.

It might be worthwhile to check for prior projects that were a "bag"
of small projects that were accepted into GSoC. I don't have the time
to do this right now, I'll get to it at a later time.

-- 
Cheers,
Ray Chuan
