From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/6] Two bugfixes
Date: Mon, 24 Mar 2008 09:35:50 +0100
Message-ID: <20080324083550.GB23337@diana.vm.bytemark.co.uk>
References: <20080320002604.13102.53757.stgit@yoghurt> <b0943d9e0803200819k7300fd1fn8a21896c7ad2a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 09:36:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdiAq-0001xQ-IB
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 09:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbYCXIgO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 04:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754259AbYCXIgO
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 04:36:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1076 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbYCXIgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 04:36:14 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jdi9m-000664-00; Mon, 24 Mar 2008 08:35:50 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0803200819k7300fd1fn8a21896c7ad2a1@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78010>

On 2008-03-20 15:19:12 +0000, Catalin Marinas wrote:

> BTW, I have about 5 patches that apply to the stable and master
> branch, mainly UI updates I needed recently (like picking multiple
> patches at once). Since the master branch still needs some work
> (which I'll try to help with), maybe it's worth releasing a 0.14.2,
> together with some of the bugs reported so far.

Absolutely. I think it would be worthwhile to treat "stable" much like
Junio handles his "maint" -- apply minor and/or important fixes there,
and release minor releases from it somewhat frequently. And merge it
to master often, so that master always has everything stable has.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
