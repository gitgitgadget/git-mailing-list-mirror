From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Sat, 15 Oct 2005 14:57:54 -0700
Message-ID: <20051015215754.GD5509@reactrix.com>
References: <867jciz18w.fsf@blue.stonehenge.com> <864q7kqsa4.fsf@blue.stonehenge.com> <7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net> <86achcoyvz.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0510141543030.23242@iabervon.org> <863bn3lypn.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 23:58:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQu2V-0000k7-I7
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 23:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVJOV6A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 17:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVJOV6A
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 17:58:00 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:51325 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751232AbVJOV6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 17:58:00 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9FLvs72013398;
	Sat, 15 Oct 2005 14:57:54 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9FLvsZt013396;
	Sat, 15 Oct 2005 14:57:54 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <863bn3lypn.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10147>

On Sat, Oct 15, 2005 at 06:03:00AM -0700, Randal L. Schwartz wrote:

> OK, it happened this morning.  While syncing to update from
> yesterday's version, I got:
> ...
> Definitely broken.  But I can "rsync" just fine.

Which version of curl did you build with?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
