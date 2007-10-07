From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Status of kha/experimental
Date: Sun, 7 Oct 2007 23:33:07 +0200
Message-ID: <20071007213307.GA32210@diana.vm.bytemark.co.uk>
References: <b0943d9e0710071418o6a664981i9d31db980c04bc50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iedkt-0005gZ-5E
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbXJGVdc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 17:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbXJGVdc
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:33:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1270 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbXJGVdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:33:31 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IedkJ-0008TN-00; Sun, 07 Oct 2007 22:33:07 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0710071418o6a664981i9d31db980c04bc50@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60221>

On 2007-10-07 22:18:44 +0100, Catalin Marinas wrote:

> How stable is the kha/experimental branch? Since there are more and
> more bugs added to the tracking system, I'll have to start looking
> at them before a 0.14 release. Is it worth merging the
> kha/experimental now or we better wait for after 0.14?

The idea is that experimental contains changes that need testing, but
may not yet be ready for your master. (They are generally safe,
though; I run StGit from my experimental branch at work, for example.)
When I decide that they are ready, I move them to safe. If there are
any patches you feel should be in safe rather than experimental, just
ask. Or you could just take them directly from experimental without
asking, of course. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
