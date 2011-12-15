From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: Re: How to commit incomplete changes?
Date: Thu, 15 Dec 2011 12:39:07 +0400
Message-ID: <20111215123907.51b2dc69@ashu.dyn1.rarus.ru>
References: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
	<20111215104444.783303cf@ashu.dyn1.rarus.ru>
	<7e1ccfac8c47e8877c0438086bd1d91b@ulrik.uio.no>
	<20111215122252.584d1003@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Thu Dec 15 09:39:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb6qS-0000BX-OO
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 09:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757884Ab1LOIjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 03:39:12 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43360 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab1LOIjM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 03:39:12 -0500
Received: by eekc4 with SMTP id c4so1807253eek.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 00:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=7yuLvTRTOJeSykbjab2juqL8kuCghFg4/ubk8YdgS6Y=;
        b=aV0ZD/jynqpUIlaUpjFkeSFycWmX1euQ2/XwqQ2q055pEwi5BXltTtVekOb73iKlZx
         xz8sop+0geN8Kq90fo0Al3UzvF88sZhkiPUaaQcmFr+jsKwQ1g7Beqy4nCwaiYYt07A6
         8jiz1QI/uTeLu1r8pLKBK5N4+ytrnezJdzwL8=
Received: by 10.14.97.133 with SMTP id t5mr936183eef.112.1323938350404;
        Thu, 15 Dec 2011 00:39:10 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id q28sm21400008eea.6.2011.12.15.00.39.08
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 00:39:09 -0800 (PST)
In-Reply-To: <20111215122252.584d1003@ashu.dyn1.rarus.ru>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187200>

> Do your own decision. 
* "Make your own decision", of course :)
