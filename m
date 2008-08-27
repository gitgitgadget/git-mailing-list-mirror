From: Daniel White <daniel@whitehouse.id.au>
Subject: Re: SPAM-LOW:  Re: [StGit PATCH] Remove dashed form of git command
 still in comment
Date: Wed, 27 Aug 2008 18:37:43 +1000
Message-ID: <20080827183743.5bea50ac@whitehouse.id.au>
References: <20080827002827.14720.45394.stgit@yoghurt>
	<20080827163811.6e726491@whitehouse.id.au>
	<20080827075157.GA14222@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?UTF-8?B?SGFzc2Vsc3Ryw7Zt?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 10:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYGgm-00050N-H5
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 10:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbYH0Iqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 04:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbYH0Iqc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 04:46:32 -0400
Received: from smtpgw02.myhostguy.com ([216.10.240.252]:3111 "EHLO
	smtpgw02.myhostguy.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753243AbYH0Iqb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 04:46:31 -0400
Received: from mx252n.mysite4now.com [216.10.248.252] by smtpgw02.myhostguy.com with SMTP;
   Wed, 27 Aug 2008 01:46:16 -0700
Received: from ppp118-208-103-94.lns3.bne4.internode.on.net [118.208.103.94] by mx252n.mysite4now.com with SMTP;
   Wed, 27 Aug 2008 01:45:43 -0700
In-Reply-To: <20080827075157.GA14222@diana.vm.bytemark.co.uk>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93875>

On Wed, 27 Aug 2008 09:51:57 +0200
Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:

> On 2008-08-27 16:38:11 +1000, Daniel White wrote:
>=20
> > If this hasn't been pushed out yet, just squash into your patch.
>=20
> Thanks, but this applies only to the master branch, so it's the merge
> I'd have to squash it into in that case. But merges really shouldn't
> contain too much new material, so this probably deserves to be a
> commit of its own.
>=20

Ah, didn't realise it had been merged.  I just applied the patch and ha=
d
a look for any missing changes.

> Was this the only one I'd missed?
>=20

With `git grep -e 'git-' --and --not \( -e 'stgit-' -e '-git-' \)` the
only things that seem to show up are special cases like file names,
elisp functions, man page links, etc.

--=20
Daniel White
