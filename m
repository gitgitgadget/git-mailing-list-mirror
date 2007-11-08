From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Deprecate git-lost-found
Date: Wed, 07 Nov 2007 16:19:56 -0800
Message-ID: <7vlk998u6r.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:20:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipv86-00063m-9i
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759722AbXKHAUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759713AbXKHAUE
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:20:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49666 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759720AbXKHAUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:20:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 61B562F0;
	Wed,  7 Nov 2007 19:20:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0520393578;
	Wed,  7 Nov 2007 19:20:19 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711072253580.4362@racer.site> (Johannes
	Schindelin's message of "Wed, 7 Nov 2007 22:54:27 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63909>

Makes sort of sense.  Add deprecation notice to Documentation/
as well, please.
