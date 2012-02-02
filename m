From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/3] vcs-svn: suppress a -Wtype-limits warning
Date: Thu, 02 Feb 2012 22:18:58 +0000
Message-ID: <4F2B0BD2.2030801@ramsay1.demon.co.uk>
References: <4F28378F.6080108@ramsay1.demon.co.uk> <20120131192053.GC12443@burratino> <7vipjpzxav.fsf@alter.siamese.dyndns.org> <20120202104128.GG3823@burratino> <20120202110601.GL3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Barr <davidbarr@google.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 23:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt523-0000WC-5X
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 23:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791Ab2BBWV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 17:21:26 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:41604 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753133Ab2BBWVZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 17:21:25 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Rt51w-0003bs-ab; Thu, 02 Feb 2012 22:21:24 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20120202110601.GL3823@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189717>

Jonathan Nieder wrote:
> ---
> That's the end of the series.  I hope it was entertaining.
> 
> Thoughts of all kinds welcome, as usual.

Yes, this is a much better approach! Thanks!

I've only compile tested (on cygwin and mingw) so far, but
I don't expect any problems ...

So, please disregard my earlier v2 patch. [If it's not already
obvious, I often don't read the list every day and I missed
all of the discussion which resulted in this series (while, at
the same time, writing testing and sending the v2 patch!).]

ATB,
Ramsay Jones
