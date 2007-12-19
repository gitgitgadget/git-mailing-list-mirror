From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH] Fix interactive rebase to preserve author email address
Date: Wed, 19 Dec 2007 23:11:55 +0100
Organization: Atmel
Message-ID: <20071219231155.258f8d80@siona>
References: <1197997575-13292-1-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-2-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-3-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-4-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-5-git-send-email-hskinnemoen@atmel.com>
	<20071218181019.2af46418@dhcp-252-066.norway.atmel.com>
	<alpine.LFD.0.9999.0712181318300.27475@localhost.localdomain>
	<20071219124008.4945e592@dhcp-252-066.norway.atmel.com>
	<20071219150734.50b1f847@dhcp-252-066.norway.atmel.com>
	<BAYC1-PASMTP13613FE244FF93DC2BF613AE5C0@CEZ.ICE>
	<20071219220223.7c5b3887@siona>
	<BAYC1-PASMTP022BE21217030117EF2156AE5C0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:12:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J579M-0007Zr-8r
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 23:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbXLSWMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 17:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbXLSWMA
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 17:12:00 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:63370 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754438AbXLSWL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 17:11:59 -0500
Received: from siona (vpn-000-018.norway.atmel.com [172.21.0.18])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id lBJMBqHd023212;
	Wed, 19 Dec 2007 23:11:52 +0100 (CET)
	(envelope-from hskinnemoen@atmel.com)
In-Reply-To: <BAYC1-PASMTP022BE21217030117EF2156AE5C0@CEZ.ICE>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.12.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68943>

On Wed, 19 Dec 2007 16:34:27 -0500
Sean <seanlkml@sympatico.ca> wrote:

> This simple typo fix should hopefully make it work for you Haavard.

It does indeed. Thanks!

Haavard
