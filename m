From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Status of kha/experimental
Date: Wed, 10 Oct 2007 10:26:02 +0200
Message-ID: <20071010082602.GF12970@diana.vm.bytemark.co.uk>
References: <b0943d9e0710071418o6a664981i9d31db980c04bc50@mail.gmail.com> <20071007213307.GA32210@diana.vm.bytemark.co.uk> <b0943d9e0710091410w1559f1a0yb5055182fd289646@mail.gmail.com> <20071009214613.GC26436@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 10:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfWtX-0000St-Ds
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 10:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbXJJI0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2007 04:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbXJJI0J
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 04:26:09 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3854 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbXJJI0I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 04:26:08 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IfWtG-0003bH-00; Wed, 10 Oct 2007 09:26:02 +0100
Content-Disposition: inline
In-Reply-To: <20071009214613.GC26436@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60483>

On 2007-10-09 23:46:13 +0200, Yann Dirson wrote:

> That would require that I update them, but I'm not sure Karl would
> want them in kha/experimental, since virtually any other patch
> causes a conflict...

Right. If it's likely to be many conflicts, I wouldn't mind if you
were the one who resolved them.

> The best situation would be that there would be a code freeze at
> some time, during which I could update those patches without too
> much perturbations, but that may be asking a lot :)

There aren't that many of us working on StGit. If you can give a
reasonably accurate start date and duration of the freeze, I don't
think it would be a problem. Others would simply have to be aware that
any patches not merged before the freeze would have to be rebased on
top of your work once the freeze is over.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
