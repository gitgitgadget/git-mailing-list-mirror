From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH 3/14] Generic ioremap_page_range: alpha conversion
Date: Thu, 10 Aug 2006 18:09:02 +0200
Organization: Atmel Norway
Message-ID: <20060810180902.0e9523da@cad-250-152.norway.atmel.com>
References: <1155225826761-git-send-email-hskinnemoen@atmel.com>
	<1155225827754-git-send-email-hskinnemoen@atmel.com>
	<11552258271630-git-send-email-hskinnemoen@atmel.com>
	<115522582724-git-send-email-hskinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161410AbWHJQJH@vger.kernel.org Thu Aug 10 18:10:34 2006
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161410AbWHJQJH@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBD76-0006Ft-IG
	for glk-linux-kernel-3@gmane.org; Thu, 10 Aug 2006 18:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161410AbWHJQJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 10 Aug 2006 12:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161418AbWHJQJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:09:07 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:2026 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161414AbWHJQJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:09:04 -0400
Received: from cad-250-152.norway.atmel.com (cad-250-152.norway.atmel.com [10.191.250.152])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id k7AG92j1022637;
	Thu, 10 Aug 2006 18:09:02 +0200 (CEST)
	(envelope-from hskinnemoen@atmel.com)
To: linux-kernel@vger.kernel.org
In-Reply-To: <115522582724-git-send-email-hskinnemoen@atmel.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25197>

On Thu, 10 Aug 2006 18:03:35 +0200
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> From: Richard Henderson <rth@twiddle.net>

Uh...does anyone have an idea why git-send-email added this line for
me? All I did was add a Cc line to the mbox like this:

Cc: Richard Henderson <rth@twiddle.net>

> Convert Alpha to use generic ioremap_page_range() by turning
> __alpha_remap_area_pages() into an inline wrapper around
> ioremap_page_range().
>=20
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

H=C3=A5vard
