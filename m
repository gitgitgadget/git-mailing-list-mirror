From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 4/5] git.el: Added support for Signed-off-by.
Date: Sat, 09 May 2009 15:25:10 +0100
Message-ID: <1241879110.2910.89.camel@macbook.infradead.org>
References: <877j7akvvy.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sat May 09 16:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2nUR-0006Ab-Ek
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 16:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbZEIOZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 10:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZEIOZN
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 10:25:13 -0400
Received: from casper.infradead.org ([85.118.1.10]:36811 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZEIOZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 10:25:12 -0400
Received: from macbook.infradead.org ([2001:8b0:10b:1:216:eaff:fe05:bbb8])
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1M2nUF-0004Yf-Q2; Sat, 09 May 2009 14:25:12 +0000
In-Reply-To: <877j7akvvy.fsf@wine.dyndns.org>
X-Mailer: Evolution 2.26.1 (2.26.1-2.fc11) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118657>

On Sat, 2006-03-04 at 17:38 +0100, Alexandre Julliard wrote:
> If `git-append-signed-off-by' is non-nil, automatically append a
> sign-off line to the log message when editing it.

This doesn't seem to work when I hit C-v v to commit. I just get an
empty *VC-log* buffer.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
