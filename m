From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 gitk 0/5] gitk -L
Date: Mon, 2 Dec 2013 09:25:26 +1100
Message-ID: <20131201222526.GA12576@iris.ozlabs.ibm.com>
References: <874n7ywpnd.fsf@thomasrast.ch>
 <cover.1384622392.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Dec 01 23:41:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnFi7-0008Jm-IF
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 23:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760Ab3LAWlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 17:41:49 -0500
Received: from ozlabs.org ([203.10.76.45]:50781 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab3LAWlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 17:41:47 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id A89BA2C0092; Mon,  2 Dec 2013 09:41:45 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <cover.1384622392.git.tr@thomasrast.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238598>

On Sat, Nov 16, 2013 at 06:37:39PM +0100, Thomas Rast wrote:
> These patches implement 'gitk -L'.  They are exactly the same as the
> gitk patches from v2 at
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/227151/focus=236903
> 
> except that they apply to the gitk-git tree at
> 
>   git://ozlabs.org/~paulus/gitk

Thanks; applied all 5 (with s/sticked/stuck/g in patch 5).

Paul.
