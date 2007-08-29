From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 4/4] Add optional logging of subprocess execution
Date: Wed, 29 Aug 2007 19:16:21 +0200
Message-ID: <20070829171621.GA2214@diana.vm.bytemark.co.uk>
References: <20070826202724.16265.85821.stgit@yoghurt> <20070826203344.16265.66280.stgit@yoghurt> <b0943d9e0708290350rbadfe08g9bbab7888723980e@mail.gmail.com> <20070829111102.GA29980@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 19:16:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQR9h-0000Ir-0L
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 19:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbXH2RQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Aug 2007 13:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbXH2RQe
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 13:16:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2335 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbXH2RQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 13:16:33 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IQR9R-0000aF-00; Wed, 29 Aug 2007 18:16:21 +0100
Content-Disposition: inline
In-Reply-To: <20070829111102.GA29980@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56969>

On 2007-08-29 13:11:02 +0200, Karl Hasselstr=F6m wrote:

> On 2007-08-29 11:50:11 +0100, Catalin Marinas wrote:
>
> > Any objection to calling this variable STGIT_SUBPROCESS_LOG? We
> > already have STGIT_DEBUG_LEVEL (used in stgit.main). I can do it
> > in my tree before pushing as I already merged your branches.
>
> No, no objection at all. I was simply too lazy to actually check
> what the existing naming convention was, and misremembered.

You changed it in the code, but forgot to change it in the commit
message. :-P

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
