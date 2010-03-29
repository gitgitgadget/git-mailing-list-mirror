From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 4/5] convert: Inhibit contraction of foreign $Id$
 during stats.
Date: Mon, 29 Mar 2010 14:51:08 +0200
Message-ID: <20100329125108.GG22480@cuci.nl>
References: <cover.1269860022.git.grubba@grubba.org>
 <81e71814080d0eca72809a751e4e90026f8fe0ea.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Henrik Grubbstr??m (Grubba)" <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 15:01:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwEb8-0004WR-8H
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 15:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab0C2NBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 09:01:37 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:55281 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab0C2NBg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 09:01:36 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id AC3305448; Mon, 29 Mar 2010 14:51:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81e71814080d0eca72809a751e4e90026f8fe0ea.1269860022.git.grubba@grubba.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143468>

Henrik Grubbstr??m (Grubba) wrote:
>Files containing foreign $Id$'s were reported as modified directly
>on checkout, which ment that it was difficult to keep a clean working
>tree when handling commits with files containing such. convert_to_git()
>now takes one more mode parameter for controlling this.

>Signed-off-by: Henrik Grubbstr??m <grubba@grubba.org>

Looks good.

Acked-By: Stephen R. van den Berg <srb@cuci.nl>
-- 
Stephen.
