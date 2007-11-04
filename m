From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: Add configuration and off switch for --numbered
Date: Sat, 03 Nov 2007 21:40:36 -0700
Message-ID: <7vejf6vd17.fsf@gitster.siamese.dyndns.org>
References: <20071104033824.GA56097@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 05:40:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoXI9-0008M5-53
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 05:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbXKDEkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 00:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbXKDEkl
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 00:40:41 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:34101 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbXKDEkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 00:40:41 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 27A642EF;
	Sun,  4 Nov 2007 00:41:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C804A8F2A3;
	Sun,  4 Nov 2007 00:40:59 -0400 (EDT)
In-Reply-To: <20071104033824.GA56097@Hermes.local> (Brian Gernhardt's message
	of "Sat, 3 Nov 2007 23:38:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63345>

The change looks good.  Tests needed.
