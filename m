From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 4/4] Add optional logging of subprocess execution
Date: Mon, 3 Sep 2007 11:04:48 +0200
Message-ID: <20070903090448.GB5051@diana.vm.bytemark.co.uk>
References: <20070826202724.16265.85821.stgit@yoghurt> <20070826203344.16265.66280.stgit@yoghurt> <b0943d9e0708290350rbadfe08g9bbab7888723980e@mail.gmail.com> <20070829111102.GA29980@diana.vm.bytemark.co.uk> <b0943d9e0709030136y4f1f241cge28fb9607ec559c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 11:05:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7rf-0001Ja-LC
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 11:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbXICJEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 05:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbXICJEx
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 05:04:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2472 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbXICJEw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 05:04:52 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IS7rU-0001mQ-00; Mon, 03 Sep 2007 10:04:48 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0709030136y4f1f241cge28fb9607ec559c1@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57457>

On 2007-09-03 09:36:26 +0100, Catalin Marinas wrote:

> On 29/08/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Any chance we can drop Python 2.3 support any time soon, by the
> > way? I've confined all the ickyness to one place, but it would
> > still be good to get rid of it (not to mention being able to use
> > sets and generator expressions).
>
> Unless there is no objection, I'm actually OK with this. Feel free
> to break the 2.3 support from now on. I'll add a note stating the
> minimum versions for Python and GIT in the 0.14 release.

Great!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
