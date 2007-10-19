From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 16:40:30 +0200
Message-ID: <4718C1DE.5030708@viscovery.net>
References: <20071019062219.GA28499@coredump.intra.peff.net>	 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>	 <20071019073938.GN14735@spearce.org>	 <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>	 <20071019113822.GB16726@thunk.org> <4718A3AB.7090301@viscovery.net>	 <alpine.LFD.0.9999.0710191009330.19446@xanadu.home> <8aa486160710190731v67626fd8wa94ba069a17f73ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Theodore Tso <tytso@thunk.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iit1p-0001LJ-3h
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbXJSOkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2007 10:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932867AbXJSOkd
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:40:33 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29612 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932703AbXJSOkd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 10:40:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iit1N-000423-GS; Fri, 19 Oct 2007 16:40:17 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EF3F8FF52; Fri, 19 Oct 2007 16:40:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <8aa486160710190731v67626fd8wa94ba069a17f73ce@mail.gmail.com>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61719>

Santi B=E9jar schrieb:
> On 10/19/07, Nicolas Pitre <nico@cam.org> wrote:
>> On Fri, 19 Oct 2007, Johannes Sixt wrote:
>>> =3D=3D> git://repo.or.cz/git/spearce.git
>>>  * (new)              gitk -> spearce/gitk
>>>  * 1aa3d01..e7187e4   maint -> spearce/maint
>>>  * de61e42..7840ce6   master -> spearce/master
>>>  * 895be02..2fe5433   next -> spearce/next
>>>  + 89fa332...1e4c517  pu -> spearce/pu
>>>  * (new)              todo -> spearce/todo
>=20
> I like it too. I would like to add some more descripton, because I
> think for newbies the .. and ... can be overlooked.

The '*' could go away, then the '+' is more visible.

-- Hanes
