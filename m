From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Test that we can add a new file to a non-topmost patch with refresh -p
Date: Fri, 18 Jul 2008 21:16:08 +0200
Message-ID: <20080718191608.GA16725@diana.vm.bytemark.co.uk>
References: <20080718084127.GA7042@diana.vm.bytemark.co.uk> <20080718170225.10086.17504.stgit@yoghurt> <20080718180109.GA14825@diana.vm.bytemark.co.uk> <9e4733910807181045mb19ab1dxaaa76696db294ddf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 20:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJv6j-0003yu-05
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 20:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968AbYGRSyB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 14:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755903AbYGRSyB
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 14:54:01 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4601 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810AbYGRSyA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 14:54:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KJvR2-0004Oi-00; Fri, 18 Jul 2008 20:16:08 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910807181045mb19ab1dxaaa76696db294ddf@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89073>

On 2008-07-18 13:45:41 -0400, Jon Smirl wrote:

> It's no big deal to me, it is easy to work around. But it did take
> me a while to notice that the add was missing.

Ah, OK, good.

> When is the refresh rewrite going to be ready for prime time?

It depends on the stack log stuff, but that is actually kind of close
to being ready now. It just needs support for hidden patches.

No time estimate, sorry -- vacation time's coming up, so I can't
really predict how much time I'll spend hacking.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
