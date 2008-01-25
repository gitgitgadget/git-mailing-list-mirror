From: Pavel Roskin <proski@gnu.org>
Subject: Re: stg clean removes conflicting patch
Date: Fri, 25 Jan 2008 03:40:22 -0500
Message-ID: <20080125034022.quettsgqsgck0k0o@webmail.spamcop.net>
References: <1201233317.2811.17.camel@dv>
	<20080125080434.GA5599@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?b?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 09:42:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIK8K-0003il-6z
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 09:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764522AbYAYIk1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 03:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764901AbYAYIk0
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 03:40:26 -0500
Received: from c60.cesmail.net ([216.154.195.49]:53389 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764439AbYAYIkX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 03:40:23 -0500
Received: from unknown (HELO epsilon2) ([192.168.1.60])
  by c60.cesmail.net with ESMTP; 25 Jan 2008 03:40:26 -0500
Received: from pool-96-227-20-21.phlapa.east.verizon.net
	(pool-96-227-20-21.phlapa.east.verizon.net [96.227.20.21]) by
	webmail.spamcop.net (Horde MIME library) with HTTP; Fri, 25 Jan 2008
	03:40:22 -0500
In-Reply-To: <20080125080434.GA5599@diana.vm.bytemark.co.uk>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71689>

Quoting Karl Hasselstr=F6m <kha@treskal.com>:

> For known-to-be-failing tests, you can use test_expect_failure. I'll
> amend your patch to do that when I pick it up (if Catalin doesn't bea=
t
> me to it).

Yes, please go ahead with the change.  I just wasn't aware of it.

--=20
Regards,
Pavel Roskin
