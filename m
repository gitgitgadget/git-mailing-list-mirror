From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of contrib/stg-sink.
Date: Thu, 19 Apr 2007 10:59:24 +0200
Message-ID: <20070419085924.GA21936@diana.vm.bytemark.co.uk>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth> <4625DDA5.60503@vilain.net> <Pine.LNX.4.64.0704181130330.30721@reaper.quantumfyre.co.uk> <200704182219.26410.robin.rosenberg.lists@dewire.com> <20070418203502.GA8524@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Sam Vilain <sam@vilain.net>, Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 11:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeSW9-000841-PV
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 11:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161362AbXDSJB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Apr 2007 05:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161384AbXDSJB0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 05:01:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4121 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161362AbXDSJBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 05:01:25 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HeSU8-000621-00; Thu, 19 Apr 2007 09:59:24 +0100
Content-Disposition: inline
In-Reply-To: <20070418203502.GA8524@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44998>

On 2007-04-18 22:35:02 +0200, Yann Dirson wrote:

> But if the consensus is that "sink" or something else sounds better,
> I have myself no objection to bury "bury" :)

I think that "sink" is by far the best word for it, especially when
paired with "float". (The only problem is that "stg series" prints the
stack with the bottom on top and the top at the bottom, but that's old
weirdness. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
