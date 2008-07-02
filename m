From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 3/3] git-branch -v: show the remote tracking statistics
Date: Wed, 2 Jul 2008 10:33:06 +0200
Message-ID: <20080702083306.GA28337@diana.vm.bytemark.co.uk>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net> <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org> <7vhcb8en92.fsf@gitster.siamese.dyndns.org> <486B3B05.4080006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Ingo Molnar <mingo@elte.hu>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 10:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxnr-0001ou-Ar
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 10:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbYGBIeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2008 04:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbYGBIeG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 04:34:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1365 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbYGBIeF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 04:34:05 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KDxly-0007Ps-00; Wed, 02 Jul 2008 09:33:06 +0100
Content-Disposition: inline
In-Reply-To: <486B3B05.4080006@viscovery.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87115>

On 2008-07-02 10:23:33 +0200, Johannes Sixt wrote:

> * jc/report-tracking   41666f7 diverged 3 vs. 117

Or even "ahead 3, behind 117" here. Otherwise the user has to remember
which number is which, which kind of defeats your point. And it's just
one more character.

>   foo                  1234567 behind 22
>   bar                  fedcba9 ahead 6

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
