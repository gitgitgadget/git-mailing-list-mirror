From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 16:48:19 +0000
Message-ID: <45D33D53.6040209@webdrake.net>
References: <vpq64a4bzp1.fsf@olympe.imag.fr>	<20070214142731.GA1478@moooo.ath.cx>	<45D33485.5020906@webdrake.net>	<17875.14305.910866.273778@lisa.zopyra.com> <17875.14859.177000.558634@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:49:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNJN-0003kP-W0
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbXBNQsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbXBNQsZ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:48:25 -0500
Received: from alf.nbi.dk ([130.225.212.55]:4974 "EHLO alf.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932381AbXBNQsY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:48:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by alf.nbi.dk (8.9.3/8.9.3) with ESMTP id RAA04535;
	Wed, 14 Feb 2007 17:48:19 +0100 (MET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
In-Reply-To: <17875.14859.177000.558634@lisa.zopyra.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39679>

Bill Lear wrote:
> Actually that was a bit tongue-in-cheek, syntactically incorrect (I
> believe missing '='), I'm not actually sure it will work, nor if the
> patch for this actually got in to 1.5.0.  The patch I saw does not
> appear to pass the rest of the command line to the system call, but
> perhaps I'm wrong and someone else can confirm.

Can you explain in detail exactly what your .gitconfig modifications are
doing?  If I understand right, is there any particular point in
bothering with these aliases, is it not just equivalent to using scp by
itself?
