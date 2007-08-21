From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Make use of the get_patch() utility function
Date: Tue, 21 Aug 2007 23:56:58 +0200
Message-ID: <20070821215658.GB20965@diana.vm.bytemark.co.uk>
References: <20070821203757.9118.30049.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:57:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INbiu-0005tO-MZ
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 23:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbXHUV5B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Aug 2007 17:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbXHUV5A
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 17:57:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2985 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbXHUV5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 17:57:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1INbic-0005hE-00; Tue, 21 Aug 2007 22:56:58 +0100
Content-Disposition: inline
In-Reply-To: <20070821203757.9118.30049.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56336>

On 2007-08-21 22:39:11 +0200, Karl Hasselstr=F6m wrote:

> Catalin, would you consider taking this cleanup? It was hidden at the
> beginning of my DAG series, so you probably didn't notice it.

If you like, you can pull this one, plus a fix from Yann and a fix
from David that you seem to have missed, from the fixes branch at
git://repo.or.cz/stgit/kha.git.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
