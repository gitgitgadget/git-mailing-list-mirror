From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 15:10:20 -0400
Message-ID: <45391F1C.80100@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz> <200610202047.11291.jnareb@gmail.com> <Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 21:11:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GazlY-0007vl-6V
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 21:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992871AbWJTTK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 15:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992869AbWJTTK3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 15:10:29 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:31899 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S2992860AbWJTTK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 15:10:27 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Gazl8-0004DQ-00; Fri, 20 Oct 2006 15:10:22 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29525>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> Git goes one step further: it _really_ doesn't matter about how you got to 
> a certain state. Absolutely _none_ of what the commits in between the 
> final stages and the common ancestor matter in the least. The only thing 
> that matters is what the states at the end-point are.

That's interesting, because I've always thought one of the strengths of
file-ids was that you only had to worry about end-points, not how you
got there.

How do you handle renames without looking at the history?

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFOR8c0F+nu1YWqI0RAkhJAJ9QJ3nyP/437/bNPI3VEVHZP0dEZACfZyEg
SWAp+673iTDEZfH00M4RG4k=
=1XO+
-----END PGP SIGNATURE-----
