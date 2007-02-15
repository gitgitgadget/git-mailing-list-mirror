From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Thu, 15 Feb 2007 01:54:31 +0100
Message-ID: <20070215005431.GB94048@dspnet.fr.eu.org>
References: <17875.17647.74882.218627@lisa.zopyra.com> <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com> <17875.30687.661794.512124@lisa.zopyra.com> <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org> <17875.33204.413186.355557@lisa.zopyra.com> <7vzm7gl8cf.fsf@assigned-by-dhcp.cox.net> <7vvei4l84q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702142303250.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vire4l76a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 02:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHVNt-0003uM-BC
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 02:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbXBOB0B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 20:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbXBOB0B
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 20:26:01 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:1640 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbXBOB0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 20:26:00 -0500
X-Greylist: delayed 1888 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Feb 2007 20:26:00 EST
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id C579DA338D; Thu, 15 Feb 2007 01:54:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vire4l76a.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39783>

On Wed, Feb 14, 2007 at 02:13:01PM -0800, Junio C Hamano wrote:
> I wonder what you are doing inside .git directory in the first
> place.  I never chdir() into it myself, but that may be because
> I practicaly live inside Emacs.

"Hmmm, how did I call this remote already? ls .g<TAB>rem<TAB><RET>
ahhh, I see".

Emacs happily does the completion too, but obviously also requires +r
for that.

  OG.
