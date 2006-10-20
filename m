From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 13:03:36 -0400
Message-ID: <45390168.6020502@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <200610201821.34712.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 19:03:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gaxmd-0004TR-TS
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 19:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992683AbWJTRDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 13:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992684AbWJTRDo
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 13:03:44 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:54680 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S2992683AbWJTRDo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 13:03:44 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GaxmU-0002ZJ-00; Fri, 20 Oct 2006 13:03:38 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610201821.34712.jnareb@gmail.com>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29505>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
> Aaron Bentley wrote:
> 
> 
>>=== added directory  // file-id:TREE_ROOT
> 
> 
> Gaaah, so rename detection in bzr is done using file-ids?
> Linus will tell you the inherent problems with that "solution".

All solutions have disadvantages.  We prefer the disadvantages that come
from using file-ids over the disadvantages that come from using
content-based rename detection.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFOQFo0F+nu1YWqI0RAlCnAJwIqwuPG/IPBBQWaGyEImTm4GMP6QCfTV89
QZaMQsTqXBH8wrt7VKAHpII=
=Qx2i
-----END PGP SIGNATURE-----
