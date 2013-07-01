From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] t7500: fix flipped actual/expect
Date: Mon, 01 Jul 2013 10:07:22 -0700
Message-ID: <1372698093-sup-9117@pimlott.net>
References: <1372695636-10768-1-git-send-email-andrew@pimlott.net> <1372695636-10768-2-git-send-email-andrew@pimlott.net> <7vwqpagr4a.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 19:07:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UthZa-00069f-4d
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 19:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599Ab3GARH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 13:07:26 -0400
Received: from pimlott.net ([72.249.23.100]:36531 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab3GARHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 13:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Cc:Content-Type; bh=V8SHLxTnL7TwTDO9wCXN9wkQz/EwH6KyPVP8TIORa64=;
	b=GMIc2TFXY8ml6hlhsv4IOIwvIdP7xWHcUgbJmb9ErXm1+aJNuCsRs5nTQnEFm/cbYlKgyJVqXfkn/dDZkRxxiM447t8raNNMzGbLnH/bXnSZBWZF0Jn+yz6TkpFV2yxqhr2NQnoyBIR52pm6hOc1mmqVnqfLzFveEjjx0RzjJWw=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UthZT-0004Oc-2m; Mon, 01 Jul 2013 10:07:23 -0700
In-reply-to: <7vwqpagr4a.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229315>

Excerpts from Junio C Hamano's message of Mon Jul 01 09:52:05 -0700 2013:
> Wow.  How could all of us missed this for a long time?

:-)  I don't know, but little is more frustrating than a misleading
diagnostic.

BTW, I didn't expect git-send-email to send those two messages in a
thread.  I'll keep them separate next time.

Andrew
