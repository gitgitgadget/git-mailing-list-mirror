From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Submodule usability
Date: Sat, 29 Sep 2007 20:52:38 +0200
Message-ID: <20070929185238.GB19943@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0709291302240.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 20:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbhPM-0004Rj-OK
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 20:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbXI2SvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 14:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754213AbXI2SvL
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 14:51:11 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:38693 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbXI2SvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 14:51:10 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id B837C801820;
	Sat, 29 Sep 2007 20:51:09 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id DF432580D2; Sat, 29 Sep 2007 20:52:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709291302240.5926@iabervon.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59484>

Hi Daniel
On Sat, Sep 29, 2007 at 01:24:53PM -0400, Daniel Barkalow wrote:
> 
> Also, would it be reasonable to have a gitmodules option for submodules 
> that the supermodule doesn't make sense without? E.g., multiple projects 
> are now using kbuild as their build system,

Out of couriosity...
I know of busybox and klibc.
Are there any others using kbuild these days?

I see that several build system share some ideas with kbuild
which I btw am glad to see.
But if there are enough project taking benefit of kbuild I should
maybe revisit my idea to factor out all the common stuff somehow.


	Sam
