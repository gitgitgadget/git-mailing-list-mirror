From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use parseopts in builtin-push
Date: Mon, 05 Nov 2007 13:50:05 -0800
Message-ID: <7v8x5cnz02.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711042235350.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:50:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9q2-0002TG-JO
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbXKEVuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbXKEVuL
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:50:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58934 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbXKEVuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:50:10 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E1AE72EF;
	Mon,  5 Nov 2007 16:50:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 86D8F928DC;
	Mon,  5 Nov 2007 16:50:28 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711042235350.7357@iabervon.org> (Daniel
	Barkalow's message of "Sun, 4 Nov 2007 22:35:37 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63565>

Thanks; will take this one.

The finalized version for builtin-fetch is appreciated.
