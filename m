From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sun, 26 Apr 2009 21:41:23 -0400
Message-ID: <m2ab62g9fg.fsf@boostpro.com>
References: <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
	<b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com>
	<alpine.LNX.2.00.0904251445030.2147@iabervon.org>
	<b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com>
	<94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com>
	<E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com>
	<20090426112802.GC10155@atjola.homenet>
	<FA5C0FFA-2DCD-4DF1-9A94-C2A26A9DCAE9@boostpro.com>
	<20090426175613.GA4942@atjola.homenet>
	<F2B2D447-57B4-459C-8A0D-A94C12AE791C@boostpro.com>
	<20090426222532.GA12338@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Witten <mfwitten@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 10:16:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyG3E-0007l6-8T
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 03:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZD0Bvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 21:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbZD0Bvs
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 21:51:48 -0400
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:11546 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbZD0Bvs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 21:51:48 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Apr 2009 21:51:47 EDT
Received: from mr08.lnh.mail.rcn.net ([207.172.157.28])
  by smtp02.lnh.mail.rcn.net with ESMTP; 26 Apr 2009 21:42:15 -0400
Received: from smtp01.lnh.mail.rcn.net (smtp01.lnh.mail.rcn.net [207.172.4.11])
	by mr08.lnh.mail.rcn.net (MOS 3.10.4-GA)
	with ESMTP id KUV71178;
	Sun, 26 Apr 2009 21:41:25 -0400 (EDT)
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com (HELO zreba.local) ([207.172.223.249])
  by smtp01.lnh.mail.rcn.net with ESMTP; 26 Apr 2009 21:41:25 -0400
Received: by zreba.local (Postfix, from userid 501)
	id 998DB49E482; Sun, 26 Apr 2009 21:41:23 -0400 (EDT)
In-Reply-To: <20090426222532.GA12338@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s
	message of "Mon, 27 Apr 2009 00:25:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.92 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117604>


on Sun Apr 26 2009, Bj=C3=B6rn Steinbrink <B.Steinbrink-AT-gmx.de> wrot=
e:

>> I think this is why Git remains more opaque than it should be.  You
>> can't assume that people will naturally develop the smartest possibl=
e
>> mental model of a VCS, even with faced with some hints in the form o=
f
>> a partial understanding of Git.
>
> I don't think I understand what you mean here. If users don't underst=
and
> the data model, that's caused by missing/bad documentation or because
> the user doesn't want to read the existing documentation. (I'll make =
no
> assumptions here, it's been some time since I had a close look at the
> docs). But I've been talking about how the given implementation store=
s
> data in the repository. Could you explain?

You don't have to "not want to read the documentation" to have an
incomplete mental model.  The mental model development doesn't happen
upon finishing the documentation; it happens while the person is
learning.  Halfway through the docs, I have an incomplete mental model.
If you make it hard enough for me, maybe I never finish and I retain
that incomplete model forever.  The more you can help people avoid
incorrect assumptions as they read along, the easier it will be for the=
m
to grok the next bit they are reading, and the less likely they are to
become discouraged.

--=20
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
