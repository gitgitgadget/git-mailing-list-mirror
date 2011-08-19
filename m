From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH 0/10] color and pager improvements
Date: Fri, 19 Aug 2011 08:34:13 +0200
Message-ID: <4e4e03fb.6d8e455c.bm000@wupperonline.de>
References: <20110818224644.GC8481@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 08:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuIxf-0000XR-0U
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 08:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab1HSGxl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 02:53:41 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:35012 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab1HSGxl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 02:53:41 -0400
Received: from point.localnet (mue-88-130-68-172.dsl.tropolys.de [88.130.68.172])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id ADBC511E351D
	for <git@vger.kernel.org>; Fri, 19 Aug 2011 08:53:39 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1QuIxX-0V6-00 for <git@vger.kernel.org>; Fri, 19 Aug 2011 08:53:39 +0200
In-Reply-To: <20110818224644.GC8481@sigill.intra.peff.net>
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179683>

Jeff King wrote on Thu, 18 Aug 2011 15:46:44 -0700:

> On Fri, Aug 19, 2011 at 12:33:01AM +0200, Ingo Br=FCckl wrote:

>> My goal was to be able to turn off paging for "stash list" only whil=
e all
>> other stash commands should continue paging.

> Ah, OK. I think the only other stash command that pages is "stash sho=
w",
> but I don't think it's unreasonable to want paging for that but not f=
or
> "list".

Maybe "stash list" simply should - like other commands - not paginate b=
y
default.

Ingo
