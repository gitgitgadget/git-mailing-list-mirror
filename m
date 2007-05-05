From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: FFmpeg considering GIT
Date: Sat, 5 May 2007 15:35:43 +0200
Message-ID: <20070505133543.GC3379@diana.vm.bytemark.co.uk>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Niedermayer <michaelni@gmx.at>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat May 05 17:38:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkML3-0003si-Jm
	for gcvg-git@gmane.org; Sat, 05 May 2007 17:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161899AbXEEPiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 5 May 2007 11:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161670AbXEEPiG
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 11:38:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4377 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161663AbXEEPiD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 11:38:03 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HkKQJ-0000zM-00; Sat, 05 May 2007 14:35:43 +0100
Content-Disposition: inline
In-Reply-To: <87y7k4lahq.wl%cworth@cworth.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46255>

On 2007-05-04 11:17:05 -0700, Carl Worth wrote:

> or by content of the patches themselves:
>
>       git log -p -S'snippet of interest'

Somewhat unrelated: how can I make gitk display these (and only these)
commits? git-log is not bad, but in 95% of cases I find gitk easier to
use.

I know that I can ask it to highlight commits that insert or remove
"snippet of interest", but frequently the highlighted commits are ten
out of ten thousand, and not that easy to find even when boldfaced.
What I want is to make it display only those commits.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
