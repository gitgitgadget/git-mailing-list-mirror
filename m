From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 2/2] Don't touch ref files manually
Date: Tue, 21 Aug 2007 22:48:31 +0200
Message-ID: <20070821204831.GA20965@diana.vm.bytemark.co.uk>
References: <20070810031949.19791.54562.stgit@yoghurt> <20070810032318.19791.70483.stgit@yoghurt> <b0943d9e0708210623h112faa42p97bba06bc9fab774@mail.gmail.com> <20070821164629.GB17045@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org,
	Yann Dirson <ydirson@altern.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 22:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INaee-0006PU-NU
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 22:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbXHUUsn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Aug 2007 16:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbXHUUsn
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 16:48:43 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4334 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbXHUUsm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 16:48:42 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1INaeN-0005SG-00; Tue, 21 Aug 2007 21:48:31 +0100
Content-Disposition: inline
In-Reply-To: <20070821164629.GB17045@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56327>

On 2007-08-21 18:46:29 +0200, Karl Hasselstr=F6m wrote:

>   * The test in your tree has the latin1 form of my name in it,
>     instead of utf8. (I noticed because I got a conflict when I
>     rebased onto your master.)

That seems to have happened to the other new test too.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
