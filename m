From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit] Debian packaging update
Date: Fri, 29 Aug 2008 00:27:11 +0200
Message-ID: <20080828222711.GB21850@diana.vm.bytemark.co.uk>
References: <20080818201036.7c2c00f8@whitehouse.id.au> <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com> <20080822235154.5e1f979c@whitehouse.id.au> <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com> <20080828140929.GB3584@khazad-dum.debian.net> <20080828192450.GH4985@nan92-1-81-57-214-146.fbx.proxad.net> <20080828205255.GA28644@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Daniel White <daniel@whitehouse.id.au>, git@vger.kernel.org,
	stgit@packages.debian.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYpdU-00060a-8n
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 00:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844AbYH1WFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 18:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYH1WFX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 18:05:23 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3652 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbYH1WFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 18:05:22 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KYpxP-0005mh-00; Thu, 28 Aug 2008 23:27:11 +0100
Content-Disposition: inline
In-Reply-To: <20080828205255.GA28644@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94192>

On 2008-08-28 22:52:55 +0200, Yann Dirson wrote:

> The official package ships a copy of documentation pages from the
> wiki, because they contain information not otherwise available. Do
> we want to keep a copy of these files in the official repo ?

We discussed this a while back, and i believe we agreed that having
the primary copy in the StGit tree is a good idea. So, yes.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
