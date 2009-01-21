From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH (topgit)] tg-patch: add support for generating patches
	against worktree and index
Date: Wed, 21 Jan 2009 23:26:13 +0300
Organization: St.Petersburg State University
Message-ID: <20090121202613.GA5400@roro3.zxlink>
References: <1231438975-13624-1-git-send-email-kirr@landau.phys.spbu.ru> <20090108195356.GA14644@lapse.rw.madduck.net> <20090108201614.GA4185@roro3> <20090108211149.GA19983@roro3> <20090118150637.GC27522@roro3.zxlink> <20090120002103.GA12549@lapse.rw.madduck.net> <20090120175635.GA5721@roro3.zxlink> <20090121032052.GB7422@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 21:26:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPjeV-0007DR-VS
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 21:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbZAUUYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 15:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbZAUUYz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 15:24:55 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:4450 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbZAUUYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 15:24:54 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 308D017B66E; Wed, 21 Jan 2009 23:24:53 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3.zxlink>)
	id 1LPjeP-00021w-62; Wed, 21 Jan 2009 23:26:13 +0300
Content-Disposition: inline
In-Reply-To: <20090121032052.GB7422@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106659>

On Wed, Jan 21, 2009 at 02:20:52PM +1100, martin f krafft wrote:
> also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2009.01.21.0456 +1100]:
> > No problem and take your time.
> > 
> > It was just me having no idea about what's going on.
> 
> I am a little confused about the patches, and git-am does not seem
> to be able to apply two patches from the same email. I use Maildir,
> so I am passing the single message with multiple patches to git-am,
> and it applies all changes into one single commit.

I see.

It seems I need to study how to prepare patches with patchy comments, or
get my hands dirty with `git am` :)

> Anyway, do you have a repo which I can cherry-pick from?

Sure

    git://repo.or.cz/topgit/kirr.git  for-upstream


Thanks,
Kirill
