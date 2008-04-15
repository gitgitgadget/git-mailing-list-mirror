From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Fwd: Bug in StackedGit
Date: Tue, 15 Apr 2008 13:55:45 +0200
Message-ID: <20080415115545.GA32149@diana.vm.bytemark.co.uk>
References: <6efe08af0804150301t9f4a1dbte564902736ebc302@mail.gmail.com> <6efe08af0804150306x1075970cxd6c9bed3dd0a6394@mail.gmail.com> <20080415103854.GA31188@diana.vm.bytemark.co.uk> <6efe08af0804150346u4e3fc383y90dca9a723818d63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Vitaly V. Ch" <vitaly.v.ch@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 13:56:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JljmR-0002kL-Jj
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 13:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759719AbYDOLzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 07:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbYDOLzz
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 07:55:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4506 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759719AbYDOLzz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 07:55:55 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JljlJ-0008Oq-00; Tue, 15 Apr 2008 12:55:45 +0100
Content-Disposition: inline
In-Reply-To: <6efe08af0804150346u4e3fc383y90dca9a723818d63@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79590>

On 2008-04-15 10:46:38 +0000, Vitaly V. Ch wrote:

> On Tue, Apr 15, 2008 at 10:38 AM, Karl Hasselstr=F6m <kha@treskal.com=
>
> wrote:
>
> > On 2008-04-15 10:06:43 +0000, Vitaly V. Ch wrote:
> >
> > > after stg commit all patch history is loss. It's sucks. there
> > > are nothing lost in bzr loom .
> >
> >  I assume you refer to the patch history shown by "stg log"?
>
> Yes. There are sometimes sens to revert some patch after commit to
> previous version.

That use case (resetting a single patch to any previous version, even
if the patch has since been committed or deleted) is handled (albeit
in a somewhat unpolished form) by the code in my experimental branch
since about 12 hours ago. Just in time. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
