From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Git Wiki improvements
Date: Sun, 13 Apr 2008 18:40:23 -0700
Message-ID: <1208137224.2867.110.camel@localhost.localdomain>
References: <60CC37BF5A3B73428D0BB9B6A26B9669019D95DA@yvrmail1.corp.navcan.ca>
	 <200804140303.22624.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Pack, Dylan" <PackD@navcanada.ca>,
	"Pack, Dylan" <sarpulhu@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 03:41:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlDhC-0004wB-Qk
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 03:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbYDNBki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 21:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbYDNBki
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 21:40:38 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:48541 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbYDNBkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 21:40:37 -0400
Received: from [172.19.0.93] ([76.21.83.184])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.13.8) with ESMTP id m3E1eSvx022511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 Apr 2008 18:40:29 -0700
In-Reply-To: <200804140303.22624.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/6751/Sun Apr 13 13:15:49 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79450>

Depending on the level of customization your really looking for, you
could always make a request to kernel.org to host the wiki ( already
hosting ext4.wiki.kernel.org, btrfs.wiki.kernel.org,
moin.wiki.kernel.org, etc)

It's running a shared hosted version of mediawiki, however I know for a
fact the admin doesn't want to do *too* much customization of the
underlying wiki and doesn't have a lot of time to devote to it, he's
good at keeping it running but the content / customization would need to
be handled by a more dedicated person.

- John 'Warthog9' Hawley

On Mon, 2008-04-14 at 03:03 +0200, Jakub Narebski wrote:
> [Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>]
> 
> Pack, Dylan wrote:
> > Jakub Narebski wrote
> >> On Mon, 14 April 2008, Pack, Dylan wrote: 
> >>
> >>> I've noticed to that the wiki gets mixed up if I use the GUI editor.
> >>> Looks like I'm going to have the syntax after all of well.
> > 
> >> Unfortunately Git Wiki administrator (Petr Baudis, who also maintains 
> >> git homepage), doesn't have much time to spend on configuring wiki,
> >> and doesn't know well MoinMoin.  The problem seems to lie in the fact
> >> that Wikipedia-like (or rather MediaWiki-like) syntax provided by
> >> (I guess) media4moin plugin doesn't modify GUI editing.  This affect
> >> mosts macros, which in default MoinMoin syntax are written as
> >> e.g. [[BR]], while Wikipedia-like syntax uses e.g. {{BR}}.
> > 
> > Perhaps a move to wikidot.com would work? They have an awesome set up
> > for wikis. I've tried them out and they are fast and always improving
> > the wiki. We could even add google adsense on the wikidot site for
> > money to be put into various git projects decided on by the
> > developers. Not sure how much money though a git wiki site would make.
> 
> I'm not sure if it is a good idea.  We would loose a bit control, and 
> would have git homepage and git wiki in separate domains.  On the other 
> hand some of admin stuff would be passed to wiki hosting site.  
> Bazaar-NG, Mercurial and Monotone (and also Emacs) have their own self 
> hosted wikis.
> 
> Git homepage at git.or.cz (or git-scm.org), Git Wiki at 
> git.or.cz/gitwiki and free git hosting at repo.or.cz are all provided 
> by Petr 'Pasky' Baudis (thanks a lot, again!).
> 
> By the way, Git Wiki initially began as a "staging ground" for contents 
> which would get incorporated into Git Homepage...
> 
