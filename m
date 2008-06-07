From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 5/5] Add test_patches target to Makefile
Date: Sat, 7 Jun 2008 11:42:47 +0200
Message-ID: <20080607094247.GG32647@diana.vm.bytemark.co.uk>
References: <20080606204322.8805.32313.stgit@localhost.localdomain> <20080606204611.8805.45597.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 11:43:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4uxk-0002Ve-5D
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 11:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbYFGJmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 05:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbYFGJmx
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 05:42:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2923 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbYFGJmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 05:42:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K4uwh-0000SM-00; Sat, 07 Jun 2008 10:42:47 +0100
Content-Disposition: inline
In-Reply-To: <20080606204611.8805.45597.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84195>

On 2008-06-06 21:46:11 +0100, Catalin Marinas wrote:

> This target tests individual patches in the series.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

Looks good. It doesn't run the tests with all patches popped, which my
invocation did, but I gues we needn't all be paranoid. :-) (And it
would be somewhat tricky to do now that you support testing an
arbitrary subset of the patches.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
