From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 10:03:16 -0400
Message-ID: <4538D724.5040508@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<200610172351.17377.jnareb@gmail.com>	<4535590C.4000004@utoronto.ca>	<200610180057.25411.jnareb@gmail.com>	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>	<20061018053647.GA3507@coredump.intra.peff.net>	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>	<20061018185225.GU20017@pasky.or.cz> <eh76np$trg$1@sea.gmane.org> <BAYC1-PASMTP061F10D0B5AF9F6608134CAE0C0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alexander Belchenko <bialix@ukr.net>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 16:03:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gauy5-0002VG-Rq
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992616AbWJTODW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992617AbWJTODW
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:03:22 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:57236 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S2992616AbWJTODW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 10:03:22 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Gauxz-00006Y-00; Fri, 20 Oct 2006 10:03:19 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP061F10D0B5AF9F6608134CAE0C0@CEZ.ICE>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29470>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sean wrote:

> Petr already mentioned that the data currently shown in the email
> text isn't really useful.

In Bazaar bundles, the text of the diff is an integral part of the data.
 It is used to generate the text of all the files in the revision.

Bazaar bundles were designed to be used on mailing lists.  So you can
review the changes from the diff, comment on them, and if it seems
suitable, merge them.

> Although that might just make the email bigger for not a lot of
> gain.

It's my understanding that most changes discussed on lkml are provided
as a series of patches.  Bazaar bundles are intended as a direct
replacement for patches in that use case.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFONck0F+nu1YWqI0RAgrHAJ0flmF1wCGYYUSk8f2iy8LuZnkaKQCdFSIo
JIaKi9S8TzUkhvaWpYYP5AA=
=MgZo
-----END PGP SIGNATURE-----
