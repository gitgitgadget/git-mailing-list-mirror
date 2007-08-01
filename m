From: David Kastrup <dak@gnu.org>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 01 Aug 2007 20:17:27 +0200
Message-ID: <85vebzrufc.fsf@lola.goethe.zz>
References: <200708010216.59750.jnareb@gmail.com>
	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	<7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
	<20070801092428.GB28106@thunk.org>
	<7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
	<87tzrjfe5h.wl%cworth@cworth.org>
	<alpine.LFD.0.999.0708010937050.3582@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 20:18:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGIm4-0007PN-4W
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 20:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbXHASSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 14:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXHASSR
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 14:18:17 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:37158 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752795AbXHASSQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 14:18:16 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 32CA432E81A
	for <git@vger.kernel.org>; Wed,  1 Aug 2007 20:18:14 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 226172D3FAE
	for <git@vger.kernel.org>; Wed,  1 Aug 2007 20:18:14 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-017.pools.arcor-ip.net [84.61.17.17])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id E42EF1D316B
	for <git@vger.kernel.org>; Wed,  1 Aug 2007 20:18:13 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id CD8C81C3E076; Wed,  1 Aug 2007 20:17:27 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708010937050.3582@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 1 Aug 2007 10\:03\:37 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54461>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I suspect it probably *would* make sense to default to "-l". Even if it 
> makes me get goose-bumps. I freely admit that my worries are totally 
> illogical.
>
> We might make it something like: "if you use an url, we don't default to 
> local",

Couldn't git clone http://host/directory/to/repo tell the proxy that
it should enter off-line mode and stop updating?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
