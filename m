From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 20:50:54 -0400
Message-ID: <45357A6E.3050603__32055.0519078553$1161135026$gmane$org@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr> <20061018002523.GJ20017@pasky.or.cz> <4535778D.40006@utoronto.ca> <20061018004209.GL20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Sean <seanlkml@sympatico.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:53:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzeG-0003uh-2I
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWJRAvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWJRAvD
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:51:03 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:41926 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751207AbWJRAvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 20:51:01 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZze4-0006Ki-00; Tue, 17 Oct 2006 20:50:57 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061018004209.GL20017@pasky.or.cz>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29165>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Petr Baudis wrote:

> Ok, one last question - do you do most of the work locally, fetching
> bits of data as you need, or remotely, only taking input/producing
> output over the network (the pserver model)?

Personally, I do not do remote commits over slow links.  At home, I use
a single machine, and mirror my repository to a public machine using
rsync.  At work, I store my repository on an NFS server, and push my
repository to a public machine using rsync.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNXpu0F+nu1YWqI0RAjPTAJ4w9YOM5XLpnIP9jYywtfMr+LZLvACfdycA
/TYAGUVGweR5+cPtDVAIBq4=
=rsNR
-----END PGP SIGNATURE-----
