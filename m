From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 01:04:34 +0100
Message-ID: <87vbynnhwt.fsf@igel.home>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
	<CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
	<20131212042624.GB8909@thyrsus.com>
	<CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
	<52B02DFF.5010408@gmail.com> <20131217140746.GB15010@thyrsus.com>
	<CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
	<20131217210255.GA18217@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Dec 18 01:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt4d1-00005j-Hy
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 01:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab3LRAEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 19:04:39 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41424 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab3LRAEi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 19:04:38 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3dkc0N45x5z4KK4J;
	Wed, 18 Dec 2013 01:04:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3dkc0N3zYxzbbgV;
	Wed, 18 Dec 2013 01:04:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id M8w-DMg8OeeL; Wed, 18 Dec 2013 01:04:35 +0100 (CET)
X-Auth-Info: 495En1KCinYKy9G13jKK3X2BFHToIpuMZOGscYsOj1A=
Received: from igel.home (ppp-88-217-34-0.dynamic.mnet-online.de [88.217.34.0])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed, 18 Dec 2013 01:04:35 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id C0F112C4436; Wed, 18 Dec 2013 01:04:34 +0100 (CET)
X-Yow: Remember, in 2039, MOUSSE & PASTA will be available
 ONLY by prescription!!
In-Reply-To: <20131217210255.GA18217@thyrsus.com> (Eric S. Raymond's message
	of "Tue, 17 Dec 2013 16:02:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239415>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> All versions of CVS have generated commitids since 2004.

Though older versions are still in use, eg. sourceware.org still does
not generate commitids.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
