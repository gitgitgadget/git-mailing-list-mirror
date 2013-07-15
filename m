From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Mon, 15 Jul 2013 22:30:47 +0200
Message-ID: <51E45BF7.5020905@kdbg.org>
References: <7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org> <7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org> <7vy59biih4.fsf@alter.siamese.dyndns.org> <51E0F93A.8050201@kdbg.org> <7vwqougwec.fsf@alter.siamese.dyndns.org> <51E1B5DB.9080904@kdbg.org> <7v61wdgdd1.fsf@alter.siamese.dyndns.org> <51E3084D.2040504@kdbg.org> <20130714203403.GE8564@google.com> <51E31131.3070005@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 22:30:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UypQ5-00071Z-5e
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 22:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab3GOUat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 16:30:49 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:46850 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753423Ab3GOUas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 16:30:48 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1325A130058;
	Mon, 15 Jul 2013 22:30:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A270319F61C;
	Mon, 15 Jul 2013 22:30:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <51E31131.3070005@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230521>

Am 14.07.2013 22:59, schrieb Johannes Sixt:
> ... I wonder how Junio's last
> example with push.default=simple can work today:
> 
>    $ git pull --rebase  # not a merge
>    $ git push
> 
> because it is not a fast-forward.

*blush* I was mostly asleep and and totally off the rails when I wrote
this nonsense.

-- Hannes
