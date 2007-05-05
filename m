From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [git-svn PATCH] Fix markup in git-svn man page
Date: Sat, 5 May 2007 15:02:17 +0200
Message-ID: <20070505130217.GA3379@diana.vm.bytemark.co.uk>
References: <20070504070003.9117.75385.stgit@yoghurt> <7vslacs0p6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 19:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkNyV-0003eR-8e
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934015AbXEERXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 5 May 2007 13:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934048AbXEERXH
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:23:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4562 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934015AbXEERXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 13:23:06 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HkJtx-0000tB-00; Sat, 05 May 2007 14:02:17 +0100
Content-Disposition: inline
In-Reply-To: <7vslacs0p6.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46268>

On 2007-05-04 15:06:45 -0700, Junio C Hamano wrote:

> Looks sane to me. I did not know about double-semicolon, which is
> mentioned in the user guide documentation at the asciidoc site but I
> could not tell how it is different from double-colon form. I am
> guessing (from the behaviour after applying your patch) that it
> allows second level of listing...

Yes, it was used that way in the parts of the man page that already
looked OK, so I just copied it. If it looks good to you too, it must
be correct. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
