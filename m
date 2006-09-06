From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git.kernel.org not putting out or git-daemon bug?
Date: Wed, 06 Sep 2006 14:11:29 +0100
Message-ID: <44FEC901.4070509@shadowen.org>
References: <44FEC6BE.5060301@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 06 15:11:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKxC8-0006Zr-Hq
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWIFNLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWIFNLx
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:11:53 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:27665 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750898AbWIFNLw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 09:11:52 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GKxBg-0005qa-Ht; Wed, 06 Sep 2006 14:11:28 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44FEC6BE.5060301@op5.se>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26529>

Andreas Ericsson wrote:
> Is it just me, or is anyone else having problems 'git fetch'-ing from
> git.kernel.org? I've been trying on and off for two hours now, but keep
> getting
> 
> fatal: unexpected EOF
> Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> 
> Around 10 o'clock GMT I got a couple of timeouts, but I haven't seen one
> of those for several hours now.
> 
> Using git version 1.4.2.ga444 to do the fetching, and trying to pull
> things on to a clone of that revision of the git repo.

I am seeing the same.  I switched my URL: to http and that got me the
data, so its still out there.

-apw
