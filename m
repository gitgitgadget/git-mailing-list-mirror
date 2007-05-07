From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 7 May 2007 14:16:03 +0200
Message-ID: <20070507121603.GA3255@diana.vm.bytemark.co.uk>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <8b65902a0705070440t40889af0p1fb8dbf7e2a072e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 14:16:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl28R-00021P-16
	for gcvg-git@gmane.org; Mon, 07 May 2007 14:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933580AbXEGMQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 08:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933606AbXEGMQH
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 08:16:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4369 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933580AbXEGMQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 08:16:07 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hl28J-0000sT-00; Mon, 07 May 2007 13:16:03 +0100
Content-Disposition: inline
In-Reply-To: <8b65902a0705070440t40889af0p1fb8dbf7e2a072e4@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46454>

On 2007-05-07 13:40:33 +0200, Guilhem Bonnefille wrote:

> In order to improve my productivity with Git, and in order to avoid
> traps around moving from SVN to Git, I often use the Git Emacs mode.
> It is really usefull for beginners as it works similarly for CVS,
> SVN and Git: synthetic view of all modifications, easy selection of
> what will be commited... The biggest drawback of this "porcelain":
> using it, you do not understand the Git's index philosophy.

git-gui is a good tool here (so good, in fact, that this is the second
time today I spam the list about it). It shows very pedagogically the
diff between HEAD and index, and the diff between index and working
dir, and allows you to point and click your way to committing
precisely the subset of changes you intended to commit. As an added
bonus, it's perfectly usable even if you don't know anything about
emacs.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
