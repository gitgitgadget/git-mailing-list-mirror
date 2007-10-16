From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 22:56:26 +0200
Message-ID: <20071016205626.GA1835@uranus.ravnborg.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com> <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 22:55:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhtRn-00049D-4M
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 22:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933834AbXJPUy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 16:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935221AbXJPUy4
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 16:54:56 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:40587 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935225AbXJPUyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 16:54:55 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id B3C88E30275;
	Tue, 16 Oct 2007 22:54:53 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 032F0580D2; Tue, 16 Oct 2007 22:56:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61254>

On Tue, Oct 16, 2007 at 12:20:50PM -0700, Linus Torvalds wrote:
> 
> The answer is *also* not "tabs are just for initial code 
> indents", because not only will most sane editors never even show the 
> difference, it's simply not how people work. So such a rule about 
> invisible things doesn't work.
It is insane to *require* diciplined people to use tabs for more than
code indents.
If you insist on using tabs all over the place - fine with me.
But do not frown upon me and other diciplined people becasue we use
spaces to make sure our arguments to a function call is properly
aligned in a tab=10,tab=8,tab=2 environment.

The arguments "tabs are always 8 spaces properly aligned" is just
to reach the lowest common denominator around developers.
And frankly there are some that do better than that.

The root casue are the stupid editors that does not make it
easy to be diciplined and thats where the errors come from
and all the stupid rules like the above.

	Sam
