From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format
Date: Fri, 23 Mar 2012 11:10:18 +0100
Message-ID: <878virfx11.fsf@thomas.inf.ethz.ch>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
	<CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
	<8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
	<CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
	<871uomrubl.fsf@thomas.inf.ethz.ch>
	<8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
	<871uomq64c.fsf@thomas.inf.ethz.ch>
	<BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, <git@vger.kernel.org>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 11:10:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB1S0-0001IW-8t
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 11:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab2CWKKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 06:10:22 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:13987 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838Ab2CWKKW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 06:10:22 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Mar
 2012 11:10:17 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Mar
 2012 11:10:19 +0100
In-Reply-To: <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> (Thomas
	Gummerer's message of "Thu, 22 Mar 2012 23:51:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193749>

Hi Thomas,

Thomas Gummerer <t.gummerer@gmail.com> writes:

> 24/04 - 12/05: Getting familiar with the old index

I am aware that this falls into the period for "getting up to speed",
however I think if you spend a day or so *now* reading through
read_index, write_index and the relevant docs.  We can then give you the
brief rundown on cache_tree, and you'll have a much clearer picture of
how things fall together.

I think that should lead to a lot of enlightenment and a greatly
improved proposal.

- Thomas

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
