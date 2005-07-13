From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [ANNOUNCE] Cogito 0.12.1
Date: Wed, 13 Jul 2005 08:12:57 +0100
Message-ID: <20050713081257.D19871@flint.arm.linux.org.uk>
References: <20050712010058.GE5981@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 09:13:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsbQc-0006eu-UD
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 09:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVGMHNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 03:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVGMHNE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 03:13:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41744 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262609AbVGMHNC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 03:13:02 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DsbQR-0004ML-5B; Wed, 13 Jul 2005 08:12:59 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DsbQP-0007q7-U6; Wed, 13 Jul 2005 08:12:57 +0100
To: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050712010058.GE5981@pasky.ji.cz>; from pasky@ucw.cz on Tue, Jul 12, 2005 at 03:00:58AM +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Grumble.

I won't bother trying to explain, I'll just paste the errors.  We've been
here before in a previous cogito revision.

rmk@dyn-67:[linux-2.6-rmk]:<1038> cg-branch-ls
origin  ../linux-2.6
smp     ../linux-2.6-smp
rmk@dyn-67:[linux-2.6-rmk]:<1039> cg-pull origin
...
cp: cannot create link `.git/objects/f5/77ffd75c02b6087d5bf5ca89f806b10f2a0246': File exists
cp: cannot create link `.git/objects/f5/e02df58c1f92cdec1cc18cd3b7eeb48fb6d0e3': File exists
cp: cannot create link `.git/objects/f6/7ca01b4982f9e01e590468bae49bf0801bc756': File exists
cp: cannot create link `.git/objects/f7/4e32e0ff3d556da1992c4e0418a89aa1ed2e64': File exists
cp: cannot create link `.git/objects/fe/72a5b08ac185c230e0af6929c25061b7459b32': File exists
cp: cannot create link `.git/objects/ff/37bc27e6034281e7686007210554c54377d420': File exists
progress: 4707 objects, 13903516 bytes, 100% done
`../linux-2.6/.git/objects/pack' -> `.git/objects/pack'
`../linux-2.6/.git/objects/pack/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.idx' -> `.git/objects/pack/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.idx'
`../linux-2.6/.git/objects/pack/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack' -> `.git/objects/pack/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack'
cg-pull: objects pull failed

-- 
Russell King
