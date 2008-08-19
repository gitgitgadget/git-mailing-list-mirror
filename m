From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 00/31] Push GUI, GUI improvements, various jgit stuff
Date: Tue, 19 Aug 2008 21:21:30 +0200
Message-ID: <200808192121.30372.robin.rosenberg.lists@dewire.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <20080819175931.GH20947@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:24:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWoT-000133-Rx
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbYHSTXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756044AbYHSTXD
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:23:03 -0400
Received: from av7-2-sn3.vrr.skanova.net ([81.228.9.182]:41664 "EHLO
	av7-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048AbYHSTXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:23:01 -0400
Received: by av7-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 2D5F938393; Tue, 19 Aug 2008 21:07:17 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av7-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 12FA53825D; Tue, 19 Aug 2008 21:07:17 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id DB2D937E48;
	Tue, 19 Aug 2008 21:22:58 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080819175931.GH20947@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92910>

tisdagen den 19 augusti 2008 19.59.31 skrev Shawn O. Pearce:
> Marek Zawirski <marek.zawirski@gmail.com> wrote:
> > Robin, Tor, I know that you were already contributing some graphics to
> > egit. If someone of you would like to do some icon for push/fetch with
> > pleasure, you are welcome. Otherwise I'll have to do some crappy icon
> > instead ;) Another matter are checkboxes screenshots. I'm not sure
> > about legality status of including them. Any ideas if/how we co use
> > them or some another set that we can for sure?
> 
> So my office-mate suggests that the output of a program (in this
> case the checkbox icon) isn't covered by the same copyright as the
> program that created it.  So we may be OK. 
It's not that simple. That obviously may be the case, but I'm certain
it does not apply to individual well defined pieces of artwork (or text for
that matter) included in the output. 

> Or we just use some 
> other sort of icon for the checkbox.  Maybe Tor would be able to
> come up with something useful here?
Most annoying is that we'd need one (four) for each LAF supported.

> 
> Anyway, most of this series looks pretty good to me.  I found a
> few other annoying bugs in JGit and EGit as a result of testing
> this series, but they are unrelated to the series and have been
> there all along.  So I may try to fix them in the coming weeks.
>  
> >  55 files changed, 6471 insertions(+), 981 deletions(-)
> 
> Heh.  Been busy, hmm?  ;-)

The weather in and around the Baltic Sea has been horrible for much
of August so far. Maybe that helped him. :)

-- robin
