From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC PATCH v2 2/2] MSVC: Fix an "incompatible pointer types"
 compiler warning
Date: Thu, 10 Dec 2009 18:38:59 +0000
Message-ID: <4B214043.8060900@ramsay1.demon.co.uk>
References: <4B1997A0.9000004@ramsay1.demon.co.uk> <200912051257.21386.j6t@kdbg.org> <4B1EAD9A.3090205@ramsay1.demon.co.uk> <200912082131.44498.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Dec 10 20:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIoKu-00069F-QB
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 20:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761549AbZLJTFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 14:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761405AbZLJTFs
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 14:05:48 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:36986 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761393AbZLJTFs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 14:05:48 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1NIoKn-0002kQ-mK; Thu, 10 Dec 2009 19:05:54 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <200912082131.44498.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135039>

Johannes Sixt wrote:
> To cut this short: According to your explanations, using -D_USE_32BIT_TIME_T 
> with MSVC is bad. Please reroll without references to _USE_32BIT_TIME_T.

OK, will do...

ATB,
Ramsay Jones
