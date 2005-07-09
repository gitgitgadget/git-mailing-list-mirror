From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Linus kernel tree corrupt?
Date: Sat, 9 Jul 2005 11:43:03 +0100
Message-ID: <20050709114303.B2175@flint.arm.linux.org.uk>
References: <9e473391050708085756bd463e@mail.gmail.com> <12c511ca05070810065db87043@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 09 12:43:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrCnk-0005ne-Bq
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 12:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVGIKnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 06:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVGIKnJ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 06:43:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28434 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261413AbVGIKnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 06:43:08 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DrCnY-0000Le-QB; Sat, 09 Jul 2005 11:43:05 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DrCnX-00023R-IU; Sat, 09 Jul 2005 11:43:03 +0100
To: Tony Luck <tony.luck@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <12c511ca05070810065db87043@mail.gmail.com>; from tony.luck@gmail.com on Fri, Jul 08, 2005 at 10:06:09AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2005 at 10:06:09AM -0700, Tony Luck wrote:
> On 7/8/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> > What happened in this session...
> 
> Linus has "packed" his GIT tree ... and now http-pull doesn't work. 
> rsync still does (provided
> you have a new enough cogito).

So does that mean we should ignore cogito's whinging about rsync being
deprecated?

-- 
Russell King
