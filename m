From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: FFmpeg considering GIT
Date: Sun, 6 May 2007 09:56:21 +0200
Message-ID: <20070506075621.GA16194@diana.vm.bytemark.co.uk>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org> <20070505133543.GC3379@diana.vm.bytemark.co.uk> <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 06 09:57:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkbcH-0003Vu-25
	for gcvg-git@gmane.org; Sun, 06 May 2007 09:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbXEFH4w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 03:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbXEFH4w
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 03:56:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1741 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506AbXEFH4v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 03:56:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HkbbR-0004Eo-00; Sun, 06 May 2007 08:56:21 +0100
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46313>

Thanks for the patch! I haven't had time to try it out yet, but ...

On 2007-05-05 10:26:12 -0700, Linus Torvalds wrote:

> -	    error_popup "Can't parse git rev-list output: {$shortcmit}"
> +	    error_popup "Can't parse git git log output: {$shortcmit}"

=2E.. this error message should probably lose one of its two "git "s.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
