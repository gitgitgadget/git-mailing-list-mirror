From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Teach bash to complete branch names in some places.
Date: Mon, 7 May 2007 03:11:08 +0200
Message-ID: <20070507011108.GA28137@diana.vm.bytemark.co.uk>
References: <20070506231357.31547.25929.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon May 07 03:11:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkrl5-00075V-DU
	for gcvg-git@gmane.org; Mon, 07 May 2007 03:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbXEGBLP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 21:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbXEGBLO
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 21:11:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3364 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbXEGBLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 21:11:13 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hkrkq-0007Kr-00; Mon, 07 May 2007 02:11:08 +0100
Content-Disposition: inline
In-Reply-To: <20070506231357.31547.25929.stgit@gandelf.nowhere.earth>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46403>

On 2007-05-07 01:13:57 +0200, Yann Dirson wrote:

> Unfortunately, the current completion framework does not seem
> flexible enough to get branch completion after "-b" flags, but I
> feel things are already better this way.

Perhaps another round of stealing stuff from git's bash completion is
in order?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
