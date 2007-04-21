From: Michael <barra_cuda@katamail.com>
Subject: Re: [RFH] How to get git-gui.sh history
Date: Sat, 21 Apr 2007 16:54:16 +0200
Message-ID: <200704211654.16393.barra_cuda@katamail.com>
References: <e5bfff550704210204p1f231076p6a68cb9d6038f4e3@mail.gmail.com> <7vtzvaulwe.fsf@assigned-by-dhcp.cox.net> <e5bfff550704210238gfdb5a51i2a7f4a8d16396b28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 17:35:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfHcA-0004Wm-6W
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 17:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbXDUPfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 11:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbXDUPfB
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 11:35:01 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:38799 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbXDUPfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 11:35:00 -0400
X-Greylist: delayed 2575 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Apr 2007 11:35:00 EDT
Received: from dial-up-mi-214.lombardiacom.it ([::ffff:212.34.225.214]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:212.34.225.214+4EQ56xt7GN; Sat, 21 Apr 2007 16:52:01 +0200
User-Agent: KMail/1.9.4
In-Reply-To: <e5bfff550704210238gfdb5a51i2a7f4a8d16396b28@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45174>

Marco Costalba wrote:
> On 4/21/07, Junio C Hamano <junkio@cox.net> wrote:
> > "Marco Costalba" <mcostalba@gmail.com> writes:
> >
> > $ git rev-list -- git-gui.sh | wc -l
> > 158
> >
> 
> This is strange....

I think Junio was referring to Shawn's git-gui repo:
http://repo.or.cz/w/git-gui.git

...Obviously, if you search for git-gui.sh in the toplevel directory
of git.git repo you won't find anything ;)...
