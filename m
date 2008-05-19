From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] doc/git-daemon: s/uploadarchive/uploadarch/
Date: Mon, 19 May 2008 15:34:36 -0500
Message-ID: <4831E45C.80607@freescale.com>
References: <20080519200832.GA23239@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, lionel@over-blog.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 19 22:39:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyC6V-0005r0-Cz
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 22:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbYESUgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbYESUgQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 16:36:16 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:61653 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbYESUgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 16:36:15 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m4JKZ3CL023250;
	Mon, 19 May 2008 13:35:04 -0700 (MST)
Received: from [10.214.72.3] (mvp-10-214-72-3.am.freescale.net [10.214.72.3])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4JKZ2We002045;
	Mon, 19 May 2008 15:35:03 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080519200832.GA23239@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82448>

Jeff King wrote:
> The git-daemon upload-archive feature has always used the
> config directive 'daemon.uploadarch'; the documentation
> which came later seems to have just mistakenly used the
> wrong name.
> 
> Noticed by lionel@over-blog.com.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Personally, I think uploadarchive is much more readable,

Agreed.

> but it is too late to tweak at this point.

Oh, I don't know.  We could introduce a better spelling if
we left the old, lesser spelling around for a compatibility period.

jdl
