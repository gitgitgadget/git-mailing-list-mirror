From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Fix an "variable might be used uninitialized" gcc warning
Date: Thu, 02 Feb 2012 18:25:29 +0000
Message-ID: <4F2AD519.2010706@ramsay1.demon.co.uk>
References: <4EEBC9D6.6010204@ramsay1.demon.co.uk> <20111216235908.GA5858@elie.hsd1.il.comcast.net> <4F2834AD.20004@ramsay1.demon.co.uk> <20120131194302.GD12443@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:38:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1Y2-0003V3-Le
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933262Ab2BBSiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 13:38:15 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:48329 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932549Ab2BBSiO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 13:38:14 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Rt1Xx-0002lx-b0; Thu, 02 Feb 2012 18:38:13 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20120131194302.GD12443@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189665>

Jonathan Nieder wrote:
> Sure, when the control flow grows too complicated, that's probably worth
> fixing anyway, for the sake of humans especially.
> 
> Sometimes gcc is the only crazy one, though. ;-)

Indeed. :-D

ATB,
Ramsay Jones
