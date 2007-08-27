From: David Kastrup <dak@gnu.org>
Subject: Re: Git User's Survey 2007 partial summary
Date: Mon, 27 Aug 2007 07:45:40 +0200
Message-ID: <85tzqla5tn.fsf@lola.goethe.zz>
References: <200708190128.43515.jnareb@gmail.com>
	<200708270251.05762.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPXYP-0001tE-39
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 07:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbXH0FyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 01:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbXH0FyV
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 01:54:21 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:44700 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751373AbXH0FyU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 01:54:20 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id DB26331EDBA;
	Mon, 27 Aug 2007 07:54:18 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id CA220279400;
	Mon, 27 Aug 2007 07:54:18 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-038-115.pools.arcor-ip.net [84.61.38.115])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id A12742BB647;
	Mon, 27 Aug 2007 07:54:16 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 25C261C1E222; Mon, 27 Aug 2007 07:45:40 +0200 (CEST)
In-Reply-To: <200708270251.05762.jnareb@gmail.com> (Jakub Narebski's message of "Mon\, 27 Aug 2007 02\:51\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4071/Mon Aug 27 02:27:44 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56764>

Jakub Narebski <jnareb@gmail.com> writes:

> This is partail summary of Git User's Survey 2007 after 1 week of 
> running. It is based on "View Text Results" page:
>   http://www.survey.net.nz/members.php?page=results&qn=1304
>
> We have around 445 individual responses, as compared to (I think) 115 
> answers (Base = 115) for previous survey. That is quite a bit.
>
>
> 04. Which programming languages are you proficient with?
>
> It losk like there is only 3/4 people proficient in Perl as compared
> to Python; it looks like Python is more popular. C is most popular,
> with only a few (if everything is all right with the results page)
> people proficient in Tcl/Tk. I'm sorry, git-gui and gitk guys; it
> looks like not many developers...

If the few developers are efficient and responsive due to their choice
of programming language, the net result might still work out fine.
But it might make the the project more susceptible to discontinuation
if existing developers can't sustain their involvement for some
reason.  On the other hand, code being inscrutable because of not
being expressible well in a more common language also carries its
dangers.

> 26. Which porcelains do you use?
>
> Most people use core-git, some use cogito (the fact that it was
> lately deprecated and is no longer developed notwithstanding), some
> use StGIT, 3 even use pg (despite it is unmaintained). More people
> use StGIT than Guilt, but this can be cause by the fact that Guilt
> (formerly gq) is younger.

I found guilt essentially unusable for me due to its documentation.
There is only man-page level documentation for the various commands
comprising it, but the overall design is just "this is just like patch
sets in ..." uh, Monotone?  Don't remember which it was.  Anyway, the
docs were quite useless to me as someone who did _not_ previously use
the system mentioned as reference.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
