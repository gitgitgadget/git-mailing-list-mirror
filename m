From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git push mirror mode
Date: Thu, 8 Nov 2007 12:44:35 +0000
Message-ID: <20071108124435.GH9736@shadowen.org>
References: <20071108121136.GG9736@shadowen.org> <Pine.LNX.4.64.0711081218090.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 13:44:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq6kZ-0007C0-Pr
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 13:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbXKHMoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 07:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbXKHMoa
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 07:44:30 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4156 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbXKHMo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 07:44:29 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1Iq6kF-00034B-1S; Thu, 08 Nov 2007 12:44:27 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711081218090.4362@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Received-SPF: pass
X-SPF-Guess: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64010>

On Thu, Nov 08, 2007 at 12:19:18PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 8 Nov 2007, Andy Whitcroft wrote:
> 
> > Ok, sometime back Junio sent out a proof-of-concept change to
> > send-pack allowing a mirror mode.
> 
> You added/left his sign-off, but did not attribute the patches to him.  
> Why?

I believe I left his signed off by from the original (first) patch, and
added mine to indicate that what I had modified was also unecombered.
The second patch is only signed off by me as I am the author.  In my
world (admittedly a kernel hacker) the first Signed-off-by: indicates the
primary authorship of that patch and the [apw@...] part tries to clarify
the changes I made therein.

No intentional stripping of credit was intended, and I believe that the
attribution as written states Junio is the originator of this patch.
However that is the way I would read the meanings of these lines, if git
has different rules or you think there is a clearer way of stating this
I am happy to change it, and resend it so attributed.

-apw
