From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 00/31] Push GUI, GUI improvements, various jgit stuff
Date: Fri, 22 Aug 2008 01:25:31 +0200
Message-ID: <200808220125.31990.robin.rosenberg.lists@dewire.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <200808212212.11184.robin.rosenberg.lists@dewire.com> <20080821201636.GZ3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJZe-0001x0-0z
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbYHUX1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 19:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbYHUX1H
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:27:07 -0400
Received: from av12-1-sn2.hy.skanova.net ([81.228.8.185]:40409 "EHLO
	av12-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbYHUX1H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 19:27:07 -0400
Received: by av12-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 1D8DC37F77; Fri, 22 Aug 2008 01:27:05 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av12-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id F16AB37EE7; Fri, 22 Aug 2008 01:27:04 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id A867A37E43;
	Fri, 22 Aug 2008 01:27:04 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080821201636.GZ3483@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93224>

torsdagen den 21 augusti 2008 22.16.36 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > onsdagen den 20 augusti 2008 04.42.42 skrev Marek Zawirski:
> > > Actually, I'm now leaving for few days, so I'm sending out just fixes 
> > > for issues pointed out by Shawn and found by me in the mean time. I'll 
> > > squash these patches with existing commits in push branch, as it is 
> > > probably worth nothing to keep this in history.
> > 
> > As I'm too eager to get this out (seems to work), I can squash it and
> > rearrange the checkbox-related code a little like stealing the icons
> > from the Eclipse CVS and grouping the checkbox classes with the
> > icons plus a tweak for selecting how the images for the checkbox
> > are created.
> 
> Yea.  Go for it.  Reusing icons from Eclipse CVS is a good way
> around the icon issue.

I pushed the cleanups to pu using the Eclipse plugin(!) built from that version. 
You may want to take a quick look before we declare it master. 

Nice work Marek!

-- robin
