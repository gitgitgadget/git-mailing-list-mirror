From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ksummit-attendees] [PATCH] commit: Add -f, --fixes <commit>
 option to add Fixes: line
Date: Tue, 29 Oct 2013 10:09:53 +1100
Message-ID: <1383001793.5117.14.camel@pasglop>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>
	 <20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
	 <xmqqa9hui2lp.fsf@gitster.dls.corp.google.com>
	 <20131028071606.GA16878@leaf> <20131028085911.GA9411@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Christoph Hellwig <hch@lst.de>
X-From: linux-kernel-owner@vger.kernel.org Tue Oct 29 00:17:53 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Vaw4G-0005dj-D4
	for glk-linux-kernel-3@plane.gmane.org; Tue, 29 Oct 2013 00:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757824Ab3J1XRh (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 28 Oct 2013 19:17:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:51939 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757793Ab3J1XRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Oct 2013 19:17:33 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r9SN9wPC025689;
	Mon, 28 Oct 2013 18:10:00 -0500
In-Reply-To: <20131028085911.GA9411@lst.de>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236874>

On Mon, 2013-10-28 at 09:59 +0100, Christoph Hellwig wrote:
> Btw, can we please take away this discussion from ksummit-attendees?  It's got
> absolutely nothing to do with kernel summit and is getting fairly annoying.

Ack. Additionally, iirc, we had decided that

 - We don't cross post multiple lists

 - We drop the annoying subject tags

As is, all I see is some attempt at doing an lkml dup, which is
pointless

Ben.
