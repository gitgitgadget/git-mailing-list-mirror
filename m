From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] t7004: Skip tests for signed tags in an old version of gpg.
Date: Sun, 08 Jul 2007 22:22:01 +0200
Message-ID: <20070708202201.GN1528MdfPADPa@greensroom.kotnet.org>
References: <46913CC2.4030101@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 22:22:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7dGi-0008OA-ER
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 22:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbXGHUWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 16:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756121AbXGHUWE
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 16:22:04 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:56796 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755455AbXGHUWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 16:22:03 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JKV009TPN8QVO@psmtp12.wxs.nl> for git@vger.kernel.org; Sun,
 08 Jul 2007 22:22:02 +0200 (MEST)
Received: (qmail 6673 invoked by uid 500); Sun, 08 Jul 2007 20:22:01 +0000
In-reply-to: <46913CC2.4030101@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51914>

On Sun, Jul 08, 2007 at 09:36:34PM +0200, Carlos Rica wrote:
> As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
> the gpg version 1.0.6 didn't parse trust packets correctly, so for
> that version, creation of signed tags using the generated key fails.
> 
> Signed-off-by: Carlos Rica <jasampler@gmail.com>
Acked-by: Sven Verdoolaege <skimo@kotnet.org>

skimo
