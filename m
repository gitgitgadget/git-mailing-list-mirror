From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: Re: Improved git-gui blame viewer
Date: Mon, 04 Jun 2007 23:26:36 +0200
Message-ID: <4664838C.8000109@xs4all.nl>
References: <20070602041723.GD7044@spearce.org> <f3rhme$2h9$1@sea.gmane.org> <20070604060720.GF4507@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 23:27:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvK5E-0005bz-6c
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 23:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbXFDV0r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757280AbXFDV0q
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 17:26:46 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:2377 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbXFDV0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 17:26:46 -0400
Received: from [10.0.0.3] (zwaan.xs4all.nl [213.84.190.116])
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id l54LQa4L080579;
	Mon, 4 Jun 2007 23:26:42 +0200 (CEST)
	(envelope-from mmelchior@xs4all.nl)
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <20070604060720.GF4507@spearce.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49129>

Shawn O. Pearce wrote:
> Matthijs Melchior <mmelchior@xs4all.nl> wrote:
....
> 
>>   Something I want for the normal window, in the Staged and Unstaged
>>   file lists, high-lite the last entry selected so it becomes easy to
>>   click on the next one and I can see more clearly what is displayed
>>   in the bottom area.
> 
> I'm not sure I understand what you are looking for here.  Right now
> git-gui should be inverting the foreground/background colors on
> the file that is "selected" (shown in the lower diff view pane).
> So the background should be black, and the foreground white.
> Is this not happening?  Or are you looking for something else?
> 

No, I am not looking for something else...., the inverting you describe
does not happen on my machine....

I am now running Debian git-core 1.5.2.1-1 with 'make install' done
in the origin/pu branch of git-gui.
'About git-gui' now says:
	git-gui version 0.7.2.58-gf9e9
	git version 1.5.2.1
	Tcl/Tk version 8.4.12

If you explain where this inverting is taking place, I can do some
experiments to find out more [use gray background i.s.o. inverting...]
Maybe it has something to do with Desktop themes, I use the standard
Gnome theme.

Thanks,
	Matthijs Melchior.
