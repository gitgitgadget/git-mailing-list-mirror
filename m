From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Wed, 31 Jan 2007 21:24:48 -0800
Message-ID: <m264am5u1r.fsf@gmail.com>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
	<Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45C14563.8060707@verizon.net>
	<7vk5z2r27s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 06:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCURf-0001bz-H8
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 06:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbXBAFYy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 00:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbXBAFYy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 00:24:54 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:25397 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161141AbXBAFYy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 00:24:54 -0500
Received: by nz-out-0506.google.com with SMTP id s1so411320nze
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 21:24:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=nFtmgblYzlfAioR2UxGVYBm96hTjI3jjBTM6nOICUhkO4hT7a7PmJXiveXYCk7F55ukfNmV1Tn+7/3L3GomqZqcz1cprU2JZyu+VIumj1BSBE6FqFoiYLO3QyxexiRgDTxXOoJAgtxN9B2+E6SWbb8SkpyAHnYJTZGHVyF8SP7Q=
Received: by 10.64.210.3 with SMTP id i3mr3018065qbg.1170307493399;
        Wed, 31 Jan 2007 21:24:53 -0800 (PST)
Received: from ziti ( [67.171.24.140])
        by mx.google.com with ESMTP id e16sm3009630qba.2007.01.31.21.24.52;
        Wed, 31 Jan 2007 21:24:53 -0800 (PST)
In-Reply-To: <7vk5z2r27s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed, 31 Jan 2007 19:22:47 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38328>

Junio C Hamano <junkio@cox.net> writes:

> I am not in X right now and won't be able to look at it myself
> tonight.  Could folks on MacOS comment on Mark's patch?

I gave it a quick spin on OS X.  gitk loads with a different geometry
than it had before, but seems to work the same.  If this fixes things
elsewhere, it seems fine here.

+ seth
