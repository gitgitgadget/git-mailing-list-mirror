From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 00/31] Push GUI, GUI improvements, various jgit
	stuff
Date: Tue, 19 Aug 2008 10:59:31 -0700
Message-ID: <20080819175931.GH20947@spearce.org>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVVVV-0003Wc-QF
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbYHSR7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 13:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbYHSR7d
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 13:59:33 -0400
Received: from george.spearce.org ([209.20.77.23]:43284 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbYHSR7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 13:59:32 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BC00E38375; Tue, 19 Aug 2008 17:59:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92890>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Robin, Tor, I know that you were already contributing some graphics to
> egit. If someone of you would like to do some icon for push/fetch with
> pleasure, you are welcome. Otherwise I'll have to do some crappy icon
> instead ;) Another matter are checkboxes screenshots. I'm not sure
> about legality status of including them. Any ideas if/how we co use
> them or some another set that we can for sure?

So my office-mate suggests that the output of a program (in this
case the checkbox icon) isn't covered by the same copyright as the
program that created it.  So we may be OK.  Or we just use some
other sort of icon for the checkbox.  Maybe Tor would be able to
come up with something useful here?

Anyway, most of this series looks pretty good to me.  I found a
few other annoying bugs in JGit and EGit as a result of testing
this series, but they are unrelated to the series and have been
there all along.  So I may try to fix them in the coming weeks.
 
>  55 files changed, 6471 insertions(+), 981 deletions(-)

Heh.  Been busy, hmm?  ;-)

-- 
Shawn.
