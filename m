From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT vs. guilt: What's the difference?
Date: Mon, 18 Jun 2007 00:28:15 +0200
Message-ID: <20070617222815.GA4324@nan92-1-81-57-214-146.fbx.proxad.net>
References: <4671B96A.1080202@midwinter.com> <20070615030542.GA30110@diana.vm.bytemark.co.uk> <tnx1wgds1pv.fsf@arm.com> <20070615200139.GS6992@nan92-1-81-57-214-146.fbx.proxad.net> <20070617035923.GI7025@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Steven Grimm <koreth@midwinter.com>,
	'git' <git@vger.kernel.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jun 18 00:28:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I03EO-0005lR-QI
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 00:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbXFQW2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 18:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbXFQW2U
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 18:28:20 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:41684 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbXFQW2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 18:28:19 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8570B5A121;
	Mon, 18 Jun 2007 00:28:15 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 248D21F158; Mon, 18 Jun 2007 00:28:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070617035923.GI7025@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50376>

On Sat, Jun 16, 2007 at 11:59:23PM -0400, Josef Sipek wrote:
> > Well, people may not like python, but IMHO it is a lot easier to learn
> > it if you don't know it (that's what I did, although I did not start
> > from zero), than writing a robust and maintainable software of even
> > moderate complexity in shell script.  Shell script may be good for
> > prototyping or gluing tools in a simple way, but for advanced sofware
> > on which to rely to store my own data, it is just not really suited.
> 
> So, why do you use git? ;)

There is no such problem in git, since only some porcelain commands are
still written in shell - and anyway C rewrites are quite fashionable those
days ;)

Best regards,
-- 
Yann.
