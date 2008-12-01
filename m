From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: map / to focus the search box
Date: Tue, 2 Dec 2008 09:33:11 +1100
Message-ID: <18740.26151.55900.953153@cargo.ozlabs.ibm.com>
References: <1227459690-9896-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 23:46:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7HX5-0002nw-Pn
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 23:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbYLAWpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 17:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbYLAWpG
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 17:45:06 -0500
Received: from ozlabs.org ([203.10.76.45]:45915 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbYLAWpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 17:45:05 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 96CF1DDD0B; Tue,  2 Dec 2008 09:45:04 +1100 (EST)
In-Reply-To: <1227459690-9896-1-git-send-email-giuseppe.bilotta@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102081>

Giuseppe Bilotta writes:

> The / key is often used to initiate searches (less, vim, some web
> browsers). We change the binding for the / (slash) key from 'find next'
> to 'focus the search box' to follow this convention.

I think that's reasonable, but the patch needs to update the key
bindings help text as well.

Thanks,
Paul.
