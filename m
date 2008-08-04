From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT v2 PATCH] Do not mess-up with commit message formatting when sending email
Date: Mon, 4 Aug 2008 17:57:51 +0200
Message-ID: <20080804155751.GA15749@diana.vm.bytemark.co.uk>
References: <20080804141640.GB12232@diana.vm.bytemark.co.uk> <20080804151913.4269.74254.stgit@dawn.rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:37:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ276-000675-Vj
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 17:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbYHDPfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 11:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbYHDPfq
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 11:35:46 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1784 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbYHDPfq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 11:35:46 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQ2RT-00046i-00; Mon, 04 Aug 2008 16:57:51 +0100
Content-Disposition: inline
In-Reply-To: <20080804151913.4269.74254.stgit@dawn.rfc1149.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91374>

Your round-trip time was shorter than mine by a few orders of
magnitude. ;-)

On 2008-08-04 17:19:14 +0200, Samuel Tardieu wrote:

> The long description gets its trailing blanks removed as well as any
> leading empty lines. Leading blanks are left untouched to preserve
> the formatting.

Thanks, much better. Will apply.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
