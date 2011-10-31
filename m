From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 23:33:09 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1110312332410.24704@twin.jikos.cz>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike> <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com> <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com> <4EAF1F40.3030907@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: linux-ide-owner@vger.kernel.org Mon Oct 31 23:33:16 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RL0Pq-0004YZ-It
	for lnx-linux-ide@lo.gmane.org; Mon, 31 Oct 2011 23:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607Ab1JaWdN (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Mon, 31 Oct 2011 18:33:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:43539 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab1JaWdM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Oct 2011 18:33:12 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 55C628AD27;
	Mon, 31 Oct 2011 23:33:11 +0100 (CET)
X-X-Sender: jikos@twin.jikos.cz
In-Reply-To: <4EAF1F40.3030907@zytor.com>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184530>

On Mon, 31 Oct 2011, H. Peter Anvin wrote:

> Perhaps we should introduce the notion of a "private tag" or something
> along those lines?  (I guess that would still have to be possible to
> push it, but not pull it by default...)

That's exactly what git does now, right? (unless you pull from a very 
specific remote).

-- 
Jiri Kosina
SUSE Labs

