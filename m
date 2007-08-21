From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 2/2] Don't touch ref files manually
Date: Tue, 21 Aug 2007 18:38:43 +0200
Message-ID: <20070821163843.GA17045@diana.vm.bytemark.co.uk>
References: <20070810031949.19791.54562.stgit@yoghurt> <20070810032318.19791.70483.stgit@yoghurt> <b0943d9e0708210623h112faa42p97bba06bc9fab774@mail.gmail.com> <20070821155845.GA16221@diana.vm.bytemark.co.uk> <46CB0EEE.D46769FE@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org,
	Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 18:39:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INWky-0007hg-5K
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 18:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759385AbXHUQiv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Aug 2007 12:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758997AbXHUQiv
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 12:38:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2466 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759020AbXHUQiu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 12:38:50 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1INWkd-0004SE-00; Tue, 21 Aug 2007 17:38:43 +0100
Content-Disposition: inline
In-Reply-To: <46CB0EEE.D46769FE@eudaptics.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56305>

On 2007-08-21 18:12:30 +0200, Johannes Sixt wrote:

> There are some instances where the MinGW port accepts backslashes in
> ref names, but you are on the safe side with forward slashes.

This was just what I was expecting. Thanks for the confirmation!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
