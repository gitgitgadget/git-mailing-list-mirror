From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: Fix listing stashes
Date: Wed, 07 Nov 2007 14:03:10 -0800
Message-ID: <7v3avhaf35.fsf@gitster.siamese.dyndns.org>
References: <1194469827-17037-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@bluebottle.com, git@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipt0t-0007r3-V9
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758860AbXKGWDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755492AbXKGWDe
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:03:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35855 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757982AbXKGWDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:03:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 91C482EF;
	Wed,  7 Nov 2007 17:03:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A0719326A;
	Wed,  7 Nov 2007 17:03:41 -0500 (EST)
In-Reply-To: <1194469827-17037-1-git-send-email-Emilian.Medve@Freescale.com>
	(Emil Medve's message of "Wed, 7 Nov 2007 15:10:27 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63871>

Oops, indeed.  Thanks.
