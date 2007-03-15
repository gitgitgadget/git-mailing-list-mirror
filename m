From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: URLs in gitweb on git.kernel.org
Date: Thu, 15 Mar 2007 16:46:47 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070315154647.GB20551@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 16:46:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRsAK-0004bU-Me
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 16:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbXCOPqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 15 Mar 2007 11:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbXCOPqx
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 11:46:53 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:36732 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030433AbXCOPqw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2007 11:46:52 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HRsAF-0006OQ-HJ; Thu, 15 Mar 2007 16:46:51 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2FFklup020825;
	Thu, 15 Mar 2007 16:46:47 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2FFklAs020824;
	Thu, 15 Mar 2007 16:46:47 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42287>

Hello,

I don't know who is the administrator for gitweb on git.kernel.org, so
I just try to reach her/him this way.

E.g.
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
summary

shows on the top the URL

	http://git.kernel.org//linux/kernel/git/torvalds/linux-2.6.git

=2E  It has 2 slashes after the hostname (which doesn't hurt much) and =
I
get an 404 when pointing my browser to there.

Maybe this should better read

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

?  The same holds true for some other trees I tested.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+hertz+in+sec**-1
