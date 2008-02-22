From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Allow renaming of the top-most branch by just calling stg rename <new-patch-name>
Date: Fri, 22 Feb 2008 08:38:11 +0100
Message-ID: <20080222073811.GB6630@diana.vm.bytemark.co.uk>
References: <200802172203.55533.onno@gmx.net> <20080218140005.GA18668@diana.vm.bytemark.co.uk> <200802212230.56646.onno@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Onno Kortmann <onno@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 08:39:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSSUx-0006B9-Uv
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 08:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbYBVHiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 02:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755537AbYBVHiV
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 02:38:21 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4235 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbYBVHiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 02:38:19 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JSSTz-0001rC-00; Fri, 22 Feb 2008 07:38:11 +0000
Content-Disposition: inline
In-Reply-To: <200802212230.56646.onno@gmx.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74700>

On 2008-02-21 22:30:56 +0100, Onno Kortmann wrote:

> Ok, I tried to do this, I'm not used at all to sending patches with
> (st)git :-) Thanks for the pointer and the assistance.

No problem. Thanks for writing the patches!

> Hopefully, --refid works as I understand it and the new patches
> appear in this thread.

Mailing patches to yourself is a good way to try things out if you're
not sure they're going to work (but you seem to have had no problems
with it).

> I'll send out another patch, a test case for the stg rename command.

Thanks, I'll pick both of them up, probably tomorrow (unless Catalin
does so first).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
