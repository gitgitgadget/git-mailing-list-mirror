From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] remote-hg: skip ill-formed references
Date: Sat, 31 Aug 2013 22:51:58 +0300
Message-ID: <20130831195158.GA17436@wheezy.local>
References: <20130831011542.GA10486@wheezy.local>
 <CAMP44s2f7S4STbCOuh35sgdrgAdw-2Tw1LDkjhO37hXLxX3mRQ@mail.gmail.com>
 <loom.20130831T155657-714@post.gmane.org>
 <CAMP44s2VOq_KEDkytF8Knbm4g12tf=K5ZVden8t=udi=KP+yPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:58:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFrJI-0004Fu-II
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab3HaT6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:58:12 -0400
Received: from p3plsmtpa07-07.prod.phx3.secureserver.net ([173.201.192.236]:59324
	"EHLO p3plsmtpa07-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753659Ab3HaT6M (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 15:58:12 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Aug 2013 15:58:12 EDT
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa07-07.prod.phx3.secureserver.net with 
	id KXrw1m0034CavkR01Xs2tz; Sat, 31 Aug 2013 12:52:03 -0700
Content-Disposition: inline
In-Reply-To: <CAMP44s2VOq_KEDkytF8Knbm4g12tf=K5ZVden8t=udi=KP+yPQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233547>

On Sat, Aug 31, 2013 at 12:57:34PM -0500, Felipe Contreras wrote:
> On Sat, Aug 31, 2013 at 8:58 AM, Max Kirillov <max@max630.net> wrote:
>> Tha was some of the vim repositories, upstream
>> https://code.google.com/p/vim/ or debian
>> anonscm.debian.org/hg/pkg-vim/vim, or both.
>> They contain tags with ~ symbol.
> 
> I can clone both fine. This is what I get with the debian one:
> 
> error: * Ignoring funny ref 'refs/tags/debian-7.2.436+hg~e12b9d992389-1' locally

Yes, it really works with the new version. I used 1.7.10
before.

Since it is fixed already, just forget it. Sorry, should
have checked it with the latest version.

-- 
Max
