From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] valgrind: do not require valgrind 3.4.0 or newer
Date: Thu, 5 Feb 2009 20:00:59 +0100
Message-ID: <20090205190059.GA16216@m62s10.vlinux.de>
References: <cover.1233858507u.git.johannes.schindelin@gmx.de> <b204f01577584835f1c0252c77ffbfab33442a79.1233858507u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:02:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV9Tz-0002vS-LX
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 20:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbZBETAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 14:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbZBETAY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 14:00:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:54482 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752350AbZBETAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 14:00:24 -0500
Received: (qmail invoked by alias); 05 Feb 2009 19:00:21 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp069) with SMTP; 05 Feb 2009 20:00:21 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+5f7N3qOe5XxYffOzIiBWXL2Kph9m5i4guE6x55j
	tTp3XlmKIKSvaB
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 6FE6219950; Thu,  5 Feb 2009 20:00:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b204f01577584835f1c0252c77ffbfab33442a79.1233858507u.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108600>

On Thu, Feb 05, 2009 at 07:34:27PM +0100, Johannes Schindelin wrote:
> Valgrind 3.4.0 is pretty new, and even if --track-origins is a nice
> feature, it is not the end of the world if that is not available.  So
> play nice and use that option only when only an older version of
> valgrind is available.

Reading the patch/the sentence above suggests that you actuallly ment: 

"So play nice and don't use that option when only an older version of
 valgrind is available."

Greetings,
Peter
