From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: bogus merges
Date: Sun, 11 Sep 2005 11:21:30 +0100
Message-ID: <20050911112130.A7510@flint.arm.linux.org.uk>
References: <59a6e58305090507387d412b3d@mail.gmail.com> <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wayne Scott <wsc9tt@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 12:29:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEP5M-00085n-NC
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 12:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVIKK2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 06:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVIKK2o
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 06:28:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26632 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932467AbVIKK2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 06:28:43 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1EEP4g-0005gE-UF; Sun, 11 Sep 2005 11:28:39 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1EEOxm-00022B-Vk; Sun, 11 Sep 2005 11:21:31 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org>; from torvalds@osdl.org on Mon, Sep 05, 2005 at 09:01:32AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8289>

On Mon, Sep 05, 2005 at 09:01:32AM -0700, Linus Torvalds wrote:
> On Mon, 5 Sep 2005, Wayne Scott wrote:
> > A recent commit in linux-2.6 looks like this:
> 
> It hopefully shouldn't happen any more with the improved and fixed
> git-merge-base.
> 
> > Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
> > Date:   Wed Aug 31 10:12:14 2005 +0100
> 
> I suspect rmk is using cogito-0.13

Correct, and rmk will probably be extremely nervous about upgrading when
0.14 appears.

-- 
Russell King
