From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [ksummit-attendees] [PATCH] commit: Add -f, --fixes <commit>
	option to add Fixes: line
Date: Mon, 28 Oct 2013 23:38:05 +0000
Message-ID: <20131028233805.GL16735@n2100.arm.linux.org.uk>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda> <20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf> <xmqqa9hui2lp.fsf@gitster.dls.corp.google.com> <20131028071606.GA16878@leaf> <20131028085911.GA9411@lst.de> <1383001793.5117.14.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Hellwig <hch@lst.de>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	ksummit-attendees@lists.linuxfoundation.org,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Oct 29 00:38:40 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VawOO-0004OM-3I
	for glk-linux-kernel-3@plane.gmane.org; Tue, 29 Oct 2013 00:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757814Ab3J1Xib (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 28 Oct 2013 19:38:31 -0400
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41807 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757509Ab3J1Xi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Oct 2013 19:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
	h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=+iNpkc3AJqw7wbF+gpFG/f7Xn2hrSPENS8D7Ik/wcv8=;
	b=m8iDHrEzvII0BJNR/XqTzAZ1JE8aa9FlAYWVrkAjQrY04vd5UAdMnVLbNvcQDyTQyDPGK8VpXK04honwYquuqYviHmZI7xUcNS/CysF46fKAy66Aio4S+YQWbSPgPuLmrHnauQbvdxrCi8mr1/EAaHFdJ0Cx9A7qoGeovqZvfM0=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:52059)
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1VawNs-0004A2-HW; Mon, 28 Oct 2013 23:38:08 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1VawNq-0004Ko-Cd; Mon, 28 Oct 2013 23:38:06 +0000
Content-Disposition: inline
In-Reply-To: <1383001793.5117.14.camel@pasglop>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236876>

On Tue, Oct 29, 2013 at 10:09:53AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2013-10-28 at 09:59 +0100, Christoph Hellwig wrote:
> > Btw, can we please take away this discussion from ksummit-attendees?  It's got
> > absolutely nothing to do with kernel summit and is getting fairly annoying.
> 
> Ack. Additionally, iirc, we had decided that
> 
>  - We don't cross post multiple lists
> 
>  - We drop the annoying subject tags
> 
> As is, all I see is some attempt at doing an lkml dup, which is
> pointless

I agree too.  This whole thread seems to be about noise, and I too
thought there was something about not cross-posting between this list
and any other list.
