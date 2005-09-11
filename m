From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: bogus merges
Date: Sun, 11 Sep 2005 19:00:35 +0100
Message-ID: <20050911190035.A24984@flint.arm.linux.org.uk>
References: <59a6e58305090507387d412b3d@mail.gmail.com> <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org> <20050911112130.A7510@flint.arm.linux.org.uk> <46a038f905091104483cc01a11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Wayne Scott <wsc9tt@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 20:02:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEW8Q-0002S8-9p
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVIKSAt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVIKSAt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:00:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12301 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965033AbVIKSAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 14:00:48 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1EEW8C-0005tF-3g; Sun, 11 Sep 2005 19:00:44 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1EEW87-0006Xm-PL; Sun, 11 Sep 2005 19:00:39 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <46a038f905091104483cc01a11@mail.gmail.com>; from martin.langhoff@gmail.com on Sun, Sep 11, 2005 at 11:48:10PM +1200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8309>

On Sun, Sep 11, 2005 at 11:48:10PM +1200, Martin Langhoff wrote:
> On 9/11/05, Russell King <rmk@arm.linux.org.uk> wrote:
> > On Mon, Sep 05, 2005 at 09:01:32AM -0700, Linus Torvalds wrote:
> > > I suspect rmk is using cogito-0.13
> > 
> > Correct, and rmk will probably be extremely nervous about upgrading when
> > 0.14 appears.
> 
> Well, *actually* cogito-0.13 didn't include git-core, so we have to
> look for the reasons elsewhere. Could be the leftover MERGE_HEAD
> Daniel mentions.
> 
> Russel, can you confirm what git-core version you are/were running?

Nope, because now that I look I'm actually using cogito 0.12.1
not 0.13 as I previously mentioned.  Oops.

-- 
Russell King
