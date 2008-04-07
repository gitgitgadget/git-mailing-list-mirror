From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: bug in git-apply
Date: Mon, 7 Apr 2008 09:04:49 +0200
Message-ID: <20080407070449.GA13171@diana.vm.bytemark.co.uk>
References: <20080406235334.GA8483@diana.vm.bytemark.co.uk> <7vej9isc3y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 09:06:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JilQd-0001LK-S5
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 09:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbYDGHFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2008 03:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbYDGHFY
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 03:05:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3207 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbYDGHFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 03:05:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JilPN-0003bK-00; Mon, 07 Apr 2008 08:04:49 +0100
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7vej9isc3y.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78949>

On 2008-04-06 18:11:13 -0700, Junio C Hamano wrote:

> How about doing this?

Well, it does fix the stgit test suite failure, so I'm all for it!
(Though I see you've already pushed it to master.) Thanks.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
