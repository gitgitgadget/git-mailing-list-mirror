From: David Kastrup <dak@gnu.org>
Subject: Re: git-gui problem with version number.
Date: Fri, 27 Jul 2007 07:50:40 +0200
Message-ID: <85ejiu5r9r.fsf@lola.goethe.zz>
References: <86odhzpg2l.fsf@lola.quinscape.zz>
	<20070727044634.GG20052@spearce.org> <85y7h25sg6.fsf@lola.goethe.zz>
	<20070727053627.GI20052@spearce.org> <85odhy5rm6.fsf@lola.goethe.zz>
	<20070727054815.GJ20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIjK-0007J3-Bu
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760697AbXG0Fux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbXG0Fux
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:50:53 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:46486 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759477AbXG0Fuw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 01:50:52 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 8130017FCFC;
	Fri, 27 Jul 2007 07:50:51 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 6FEB32DA967;
	Fri, 27 Jul 2007 07:50:51 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-061-025.pools.arcor-ip.net [84.61.61.25])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 41EEB1329A;
	Fri, 27 Jul 2007 07:50:51 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E6DA41C39595; Fri, 27 Jul 2007 07:50:40 +0200 (CEST)
In-Reply-To: <20070727054815.GJ20052@spearce.org> (Shawn O. Pearce's message of "Fri\, 27 Jul 2007 01\:48\:15 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3779/Thu Jul 26 21:33:22 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53898>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> David Kastrup <dak@gnu.org> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> > Anyway, you can setup a build with the most recent 'stable
>> > development' version of git-gui:
>> >
>> >   git checkout -b with-new-gitgui
>> >   git pull -s subtree git://repo.or.cz/git-gui.git
>> 
>> Ok.  Would the necessity for this depend on the Tcl version?
>
> I thought all versions of Tcl did not understand the 'creative'
> git version strings.  So I'm surprised to hear it works on one
> system but not on another, even though you have the same version
> of git and git-gui.

I'll check once I am at work, but I am pretty sure that the versions
are pretty much in synch.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
