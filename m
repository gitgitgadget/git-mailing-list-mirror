From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from
	Windows Explorer
Date: Fri, 25 Sep 2009 15:59:40 -0700
Message-ID: <20090925225940.GB14660@spearce.org>
References: <4ABB84F4.7080403@gmail.com> <20090925220510.GY14660@spearce.org> <bdca99240909251541h2e9932a3r67c1d8604e56a8df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mstormo@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 00:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrJlT-0002Xs-8E
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 00:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbZIYW7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbZIYW7h
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 18:59:37 -0400
Received: from george.spearce.org ([209.20.77.23]:37887 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZIYW7h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 18:59:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EE1CD38151; Fri, 25 Sep 2009 22:59:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bdca99240909251541h2e9932a3r67c1d8604e56a8df@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129132>

Sebastian Schuberth <sschuberth@gmail.com> wrote:
> On Sat, Sep 26, 2009 at 00:05, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Something is wrong with both patches; neither applies. ??It looks
> > to be an issue with whitespace, like context lines are gaining an
> > extra space at the start of the line.
> 
> Hmm, the patches apply fine onto master for me.

After going through your client and the GMane email gateway?
Or before you pasted it into the message?
 
> As a side note, I've never liked sending patches via mail. It just
> feels like writing a text on a computer just to print it out, scan in
> the sheet again, and then sending the scanned image as an attachment
> via email. Isn't there a better way to contribute patches to Git, like
> pushing to a mob branch as for the msysGit project?

It works fine, so long as the tools in the chain leave the body
of the message alone and don't try to outsmart the human who put
it there.

The git project in particular as rules about only applying patches
off the mailing list, because then all contributions are in a
permanent, public archive.  Its also the form of communication most
contributors prefer for code reviews.

-- 
Shawn.
