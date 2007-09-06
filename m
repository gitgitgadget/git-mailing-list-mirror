From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 6/7] Eradicate yet-another-buffer implementation in  buitin-rerere.c
Date: Thu, 06 Sep 2007 22:16:07 +0200
Message-ID: <85hcm7a6t4.fsf@lola.goethe.zz>
References: <20070902224213.GB431@artemis.corp>
	<11890776114037-git-send-email-madcoder@debian.org>
	<118907761140-git-send-email-madcoder@debian.org>
	<11890776111843-git-send-email-madcoder@debian.org>
	<11890776112292-git-send-email-madcoder@debian.org>
	<11890776111670-git-send-email-madcoder@debian.org>
	<11890776112309-git-send-email-madcoder@debian.org>
	<11890776112641-git-send-email-madcoder@debian.org>
	<Pine.LNX.4.64.0709061504521.28586@racer.site>
	<20070906171734.GG8451@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 22:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITNlz-0007Ti-NI
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 22:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390AbXIFUQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 16:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757345AbXIFUQN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 16:16:13 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:36750 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754831AbXIFUQM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 16:16:12 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 0666A18008D;
	Thu,  6 Sep 2007 22:16:08 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id E57BD2C6B7D;
	Thu,  6 Sep 2007 22:16:07 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-134.pools.arcor-ip.net [84.61.57.134])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id ACCC53664CA;
	Thu,  6 Sep 2007 22:16:07 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 515221CAD71B; Thu,  6 Sep 2007 22:16:07 +0200 (CEST)
In-Reply-To: <20070906171734.GG8451@artemis.corp> (Pierre Habouzit's message of "Thu\, 06 Sep 2007 19\:17\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4173/Thu Sep  6 20:35:28 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57926>

Pierre Habouzit <madcoder@debian.org> writes:

> On Thu, Sep 06, 2007 at 02:05:36PM +0000, Johannes Schindelin wrote:

>> You used spaces instead of tabs here.
>
>   crap, and I did that in the 5th patch as well. well, I'll maybe send
> privately a "fixed" version of the patch to junio then, to avoid
> flooding the list with spacing issues.
>
>   And I'll also set my vim to use tabs when I'm hacking on git.

Just use Emacs and
M-x c-set-style RET linux RET

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
