From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Split off the pretty print stuff into its own file
Date: Mon, 05 Nov 2007 13:16:56 -0800
Message-ID: <7v3avkpf3r.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
	<Pine.LNX.4.64.0711041914310.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9Jx-0000QN-6O
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbXKEVRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbXKEVRG
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:17:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57780 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbXKEVRD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:17:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E039E2F9;
	Mon,  5 Nov 2007 16:17:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DB83928DF;
	Mon,  5 Nov 2007 16:17:20 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711041914310.4362@racer.site> (Johannes
	Schindelin's message of "Sun, 4 Nov 2007 19:15:06 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63553>

I'll take the [1/3] to 'master'.  I will see how discussion
goes about the rest on the list for now.
