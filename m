From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] import-tars: use Archive::Tar instead of unpack()
Date: Tue, 24 Apr 2007 12:13:23 +0200
Message-ID: <20070424101323.GC23811@diana.vm.bytemark.co.uk>
References: <1171289831.629.6.camel@ibook.zvpunry.de> <127B27FE-1F9A-4328-A87A-77B907FFEBA7@zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Loeffler <zvpunry@zvpunry.de>
X-From: git-owner@vger.kernel.org Tue Apr 24 12:13:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgI1Z-0004SC-Dd
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 12:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbXDXKN0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 06:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbXDXKN0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 06:13:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1495 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbXDXKNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 06:13:25 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HgI1T-0006eC-00; Tue, 24 Apr 2007 11:13:23 +0100
Content-Disposition: inline
In-Reply-To: <127B27FE-1F9A-4328-A87A-77B907FFEBA7@zvpunry.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45439>

On 2007-04-24 10:39:54 +0200, Michael Loeffler wrote:

> Search for this mail and try the patch.
>
> > Von: Michael Loeffler <zvpunry@zvpunry.de>
> > Datum: 12. Februar 2007 15:17:11 MEZ
> > An: git@vger.kernel.org
> > Betreff: [PATCH] import-tars: use Archive::Tar instead of unpack()

Sorry, the same objection as Shawn raised in the original thread
applies here too: I don't have Archive::Tar installed! :-(

I might try it later, but I don't really have the time to chase after
that dependency right now. Sorry.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
