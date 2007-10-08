From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/6] Survive capital punishment
Date: Mon, 8 Oct 2007 10:58:30 +0200
Message-ID: <20071008085830.GA7983@diana.vm.bytemark.co.uk>
References: <20071008085430.9734.75797.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeoRn-0003n4-8q
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 10:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbXJHI6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 04:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbXJHI6e
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 04:58:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2237 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbXJHI6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 04:58:33 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IeoRa-00027x-00; Mon, 08 Oct 2007 09:58:30 +0100
Content-Disposition: inline
In-Reply-To: <20071008085430.9734.75797.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60307>

On 2007-10-08 10:55:02 +0200, Karl Hasselstr=F6m wrote:

> Karl Hasselstr=F6m (6):
>       Let some commands work with detached HEAD
>       Don't have a global crt_series in stgit.commans.common
>       Refactor crt_series creation
>       Properly detect that HEAD is detached
>       Use our nice message printout wrapping system
>       Allow caller to customize title of error/warning message

Will be available from

  git://repo.or.cz/stgit/kha.git safe

momentarily (I just need to rebase the experimental branch on top of
it).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
