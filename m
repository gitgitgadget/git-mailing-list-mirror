From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Thu, 29 Nov 2007 08:17:05 +0100
Message-ID: <20071129071705.GB24070@efreet.light.src>
References: <200711282339.59938.jnareb@gmail.com> <200711290248.23239.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 08:17:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxdeV-0003zm-5Y
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 08:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbXK2HRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 02:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752745AbXK2HRS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 02:17:18 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:44918 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648AbXK2HRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 02:17:17 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8950A572FD;
	Thu, 29 Nov 2007 08:17:14 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 09QKUa20i251; Thu, 29 Nov 2007 08:17:08 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3F0D557621;
	Thu, 29 Nov 2007 08:17:05 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1Ixddx-0006PM-2p; Thu, 29 Nov 2007 08:17:05 +0100
Content-Disposition: inline
In-Reply-To: <200711290248.23239.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66509>

On Thu, Nov 29, 2007 at 02:48:22 +0100, Robin Rosenberg wrote:
> I did start doing this so here's my version (pre-msysgit). Please try to bring up the defintion
> of "atomic" again with the author. I did complain a little but nothing happened. The issue is
> that Clearcase is listed as having "atomic" commits which is not true for any usable definition
> of atomic in SCM context. With the definition in use there I think CVS should be considered
> having atomic commits too, at least I've never seen a half-committed file there.

Actually, I did. Or rather, I did see a commit, that didn't make it to the
server, but the client thought it did!

Maybe instead of asking the author to change the definition of atomic, ask
him to add an item for whole-tree commits. That more precisely describes what
is the point.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
