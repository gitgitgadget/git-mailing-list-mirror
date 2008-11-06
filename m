From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: More help needed on merging unrelated repos
Date: Thu, 6 Nov 2008 16:28:43 +0100
Message-ID: <20081106152843.GA16238@diana.vm.bytemark.co.uk>
References: <46d6db660811040514qc6c9663u17bd231e1ba662ad@mail.gmail.com> <4910ACCA.7080007@op5.se> <46d6db660811041308o19f1131dm4d49b6703fa6d22b@mail.gmail.com> <4910C6F4.5010407@op5.se> <46d6db660811041430l74d9a100kc15ac46dea8ff63f@mail.gmail.com> <20081106083751.GA10359@diana.vm.bytemark.co.uk> <46d6db660811060413q7f4e2437maa6d87a27b8704b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 16:30:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky6o7-0005KO-Go
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 16:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbYKFP2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 10:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbYKFP2s
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 10:28:48 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3883 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbYKFP2s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 10:28:48 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ky6mp-0004FQ-00; Thu, 06 Nov 2008 15:28:43 +0000
Content-Disposition: inline
In-Reply-To: <46d6db660811060413q7f4e2437maa6d87a27b8704b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100240>

On 2008-11-06 13:13:42 +0100, Christian MICHON wrote:

> nice suggestion Karl! it took a while to understand all the
> consequences and workflow. On top of your suggestion, I had to
> remove the refs/original/refs/heads/master and the grafts file.

I've never tried to use git-filter-branch, so I was deliberately
vague. I was hoping you would be the enterprising type who would
figure out the details anyway ... ;-)

> It worked well: quite a spell, but an efficient one. Kudo++

Well, that's Git for you. Once you get the (really simple) underlying
data model you know what _can_ be done, even if it's not always
obvious _how_ to do it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
