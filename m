From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Wed, 21 May 2008 11:27:00 +0200
Message-ID: <20080521092700.GA28195@diana.vm.bytemark.co.uk>
References: <20080519022125.GV29038@spearce.org> <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org> <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com> <20080520201722.GF29038@spearce.org> <bd6139dc0805201322r6c8dae8cy45d31af6c25fd25a@mail.gmail.com> <20080520203153.GH29038@spearce.org> <7v3aoc8xtg.fsf@gitster.siamese.dyndns.org> <20080521024126.GI29038@spearce.org> <alpine.DEB.1.00.0805210930150.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, sverre@rabbelier.nl,
	Dirk =?iso-8859-1?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 21 11:29:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jykd8-00020K-2q
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 11:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbYEUJ2P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 05:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbYEUJ2P
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 05:28:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3630 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbYEUJ2O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 05:28:14 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jykb6-0007MV-00; Wed, 21 May 2008 10:27:00 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805210930150.30431@racer>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82538>

On 2008-05-21 09:30:39 +0100, Johannes Schindelin wrote:

> On Tue, 20 May 2008, Shawn O. Pearce wrote:
>
> > Junio C Hamano <gitster@pobox.com> wrote:
> >
> > > Probably --trace should be renamed to --debug then?
> >
> > Well, we do have GIT_TRACE, and git-gui --trace is sort of the
> > same idea. :-)
>
> Which brings me to the suggestion to reuse GIT_TRACE instead of
> adding an option...

=46WIW, StGit uses STGIT_SUBPROCESS_LOG for this purpose. (Can be set t=
o
"debug" to get maximum details, or "profile" to get the time of each
subprocess call.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
