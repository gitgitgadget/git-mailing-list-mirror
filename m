From: Miles Bader <miles.bader@necel.com>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Tue, 23 Oct 2007 17:39:46 +0900
Message-ID: <buomyua6x7x.fsf@dhapc248.dev.necel.com>
References: <20071019062219.GA28499@coredump.intra.peff.net>
	<ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
	<20071019073938.GN14735@spearce.org>
	<8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
	<alpine.LFD.0.9999.0710190913280.19446@xanadu.home>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 10:41:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkFJz-0003R0-Dw
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 10:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbXJWIkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 04:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbXJWIkp
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 04:40:45 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:34489 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbXJWIko (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 04:40:44 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9N8djSH011066;
	Tue, 23 Oct 2007 17:39:48 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Tue, 23 Oct 2007 17:39:48 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay21.aps.necel.com with ESMTP; Tue, 23 Oct 2007 17:39:48 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 8EBF9B67; Tue, 23 Oct 2007 17:39:46 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <alpine.LFD.0.9999.0710190913280.19446@xanadu.home> (Nicolas Pitre's message of "Fri\, 19 Oct 2007 09\:15\:26 -0400 \(EDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62121>

Nicolas Pitre <nico@cam.org> writes:
> I think the advantage of having only one line of output per branch 
> really outweight the need for old..new notation.  Do you really benefit 
> from it?

The "one-line" issue has already been resolved in other messages, but I
just wanted to say I use this info all the time.

-Miles

-- 
"Suppose He doesn't give a shit?  Suppose there is a God but He
just doesn't give a shit?"  [George Carlin]
