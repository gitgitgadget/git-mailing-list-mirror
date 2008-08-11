From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: clone branching?
Date: Mon, 11 Aug 2008 22:39:17 +0200
Message-ID: <20080811203917.GA20662@diana.vm.bytemark.co.uk>
References: <4b6f054f0808111124g58309f64v496ceb250a068985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Trans <transfire@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:18:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSdqS-00086r-My
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbYHKURQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 16:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755155AbYHKURQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:17:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4546 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbYHKURP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:17:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KSeAf-0005k0-00; Mon, 11 Aug 2008 21:39:17 +0100
Content-Disposition: inline
In-Reply-To: <4b6f054f0808111124g58309f64v496ceb250a068985@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91992>

On 2008-08-11 14:24:23 -0400, Trans wrote:

> I'm new to this list and evaluating whether to use Git. On the whole
> I really like Git, however, I'm not sure l like the way it handles
> branching.
>
> Can Git be effectively used if clone is used for branching, rather
> then using the internal branch naming?

Yes, definitely.

git supports multiple branches per repository/working copy, but
doesn't force you to have more than one. And it's very easy to pull
changes from one repo to another.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
