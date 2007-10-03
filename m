From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 19:02:41 +0200
Message-ID: <20071003170241.GA7571@diana.vm.bytemark.co.uk>
References: <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com> <20071003104943.GA3017@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031550490.28395@racer.site> <20071003160731.GA7113@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031718110.28395@racer.site> <20071003162816.GA17403@artemis.corp> <Pine.LNX.4.64.0710031742400.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Wincent Colaiuta <win@wincent.com>,
	Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 19:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id7fG-0002XI-84
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 19:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbXJCRFa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 13:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbXJCRF3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 13:05:29 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2945 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbXJCRF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 13:05:29 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Id7cP-00023E-00; Wed, 03 Oct 2007 18:02:41 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710031742400.28395@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59860>

On 2007-10-03 17:44:39 +0100, Johannes Schindelin wrote:

> I wonder how hard it would be to teach _everybody_ to specify
> _exactly_ what they want.
>
> Of course, we'd need an "--existing" option to git-push to trigger
> the behaviour that we have right now.

I could _definitely_ live with that. If the branch config doesn't say
what to do when no arguments are given, then demand a specification on
the command line.

I'll shut up on this topic now, though, since I'm not exactly helping
with the patch/opinion ratio.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
