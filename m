From: Daniel White <daniel@whitehouse.id.au>
Subject: Re: [StGit] Debian packaging update
Date: Sat, 23 Aug 2008 13:58:55 +1000
Message-ID: <20080823135855.1a7aafd4@whitehouse.id.au>
References: <20080818201036.7c2c00f8@whitehouse.id.au>
	<b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com>
	<20080822235154.5e1f979c@whitehouse.id.au>
	<b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Karl =?UTF-8?B?SGFzc2Vsc3Ryw7Zt?=" <kha@treskal.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 06:01:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWkJz-0005q8-MR
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 06:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbYHWEAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 00:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbYHWEAq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 00:00:46 -0400
Received: from smtpgw02.myhostguy.com ([216.10.240.233]:1268 "EHLO
	smtpgw02.myhostguy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbYHWEAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 00:00:46 -0400
Received: from mx252n.mysite4now.com [216.10.248.252] by smtpgw02.myhostguy.com with SMTP;
   Fri, 22 Aug 2008 20:59:03 -0700
Received: from ppp118-208-1-137.lns1.bne1.internode.on.net [118.208.1.137] by mx252n.mysite4now.com with SMTP;
   Fri, 22 Aug 2008 20:58:56 -0700
In-Reply-To: <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93417>

On Fri, 22 Aug 2008 22:57:02 +0100
"Catalin Marinas" <catalin.marinas@gmail.com> wrote:

> 2008/8/22 Daniel White <daniel@whitehouse.id.au>:
> > Since it is now packaged by Debian is it still necessary to be
> > maintaining Debian packaging?
> 
> This is mainly to make it easier for Debian maintainers. Someone might
> also want to build a .deb package for a different version or flavour
> of Debian.
> 

I had been reading an article recently about packaging, and there was
the suggestion that upstream having packaging caused headaches when
merging new versions.

But I definately agree that the second case is handy.

> > Having a look at the Debian version, they have made quite a few
> > changes against our packaging.  It might be worth getting some
> > patches from them that are not specific to Debian policy (like the
> > setup of bash completion).
> 

Just to clarify, I believe the automatic setup of bash completion _is_
specific to Debian policy.

> I don't follow the Debian package much but I'll have a look to see the
> differences.
> 

-- 
Daniel White
