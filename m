From: Wilbert van Dolleweerd <wilbert@arentheym.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Thu, 6 May 2010 09:29:35 +0200
Message-ID: <o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com>
References: <4BE141E3.2060904@gmail.com>
	 <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 09:30:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9vX2-0005Ly-VO
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 09:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab0EFH3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 03:29:37 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:58826 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520Ab0EFH3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 03:29:36 -0400
Received: by bwz19 with SMTP id 19so314127bwz.21
        for <git@vger.kernel.org>; Thu, 06 May 2010 00:29:35 -0700 (PDT)
Received: by 10.204.7.212 with SMTP id e20mr7564521bke.117.1273130975264; Thu, 
	06 May 2010 00:29:35 -0700 (PDT)
Received: by 10.204.114.131 with HTTP; Thu, 6 May 2010 00:29:35 -0700 (PDT)
X-Originating-IP: [77.61.241.211]
In-Reply-To: <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146452>

> I personally find that autocrlf causes more confusion than it solves problems.
>
> I've yet to see a text editor on windows that can't handle \n line
> endings. (Notepad doesn't count)
>
> Just keep the project with \n line endings, disable autocrlf, and make
> sure that people are aware of this.

Editors may handle it gracefully but older Windows programs will have problems.

For instance, Visual Studio 6 will barf on Visual Basic projectfiles
with non-windows line-style endings. (And please don't ask why I know
this....)

-- 
Kind regards,

Wilbert van Dolleweerd
Blog: http://walkingthestack.blogspot.com/
Twitter: http://www.twitter.com/wvandolleweerd
