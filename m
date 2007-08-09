From: Pavel Roskin <proski@gnu.org>
Subject: Re: 'pu' branch for StGIT
Date: Wed, 08 Aug 2007 20:10:03 -0400
Message-ID: <20070808201003.nm90u2s5ny888wcc@webmailbeta.spamcop.net>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk>
	<1186549433.2112.34.camel@dv>
	<20070808092027.GB7860@diana.vm.bytemark.co.uk>
	<20070808213917.GA22521@diana.vm.bytemark.co.uk>
	<1186611514.7383.4.camel@dv>
	<20070808232349.GA23172@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Karl =?iso-8859-1?b?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 02:10:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIvbM-0004KB-OU
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 02:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763492AbXHIAKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 20:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762145AbXHIAKF
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 20:10:05 -0400
Received: from c60.cesmail.net ([216.154.195.49]:54713 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762676AbXHIAKE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 20:10:04 -0400
Received: from unknown (HELO epsilon2) ([192.168.1.60])
  by c60.cesmail.net with ESMTP; 08 Aug 2007 20:10:03 -0400
Received: from c-71-230-131-166.hsd1.pa.comcast.net
	(c-71-230-131-166.hsd1.pa.comcast.net [71.230.131.166]) by
	webmailbeta.spamcop.net (Horde MIME library) with HTTP; Wed, 08 Aug 2007
	20:10:03 -0400
In-Reply-To: <20070808232349.GA23172@diana.vm.bytemark.co.uk>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55401>

Quoting Karl Hasselstr=F6m <kha@treskal.com>:

> It was all due to a sloppy regexp. This is the fix:

Thank you!

And by the way, please fix the description of the commit where you =20
added --smtp-server option.  You added it to "stg mail", not to "stg =20
add".

--=20
Regards,
Pavel Roskin
