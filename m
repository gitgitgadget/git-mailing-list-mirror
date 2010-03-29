From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 3/5] convert: Use the enum constant SAFE_CRLF_FALSE.
Date: Mon, 29 Mar 2010 14:49:29 +0200
Message-ID: <20100329124929.GF22480@cuci.nl>
References: <cover.1269860022.git.grubba@grubba.org>
 <74ce7980eb1fe629a651433ca9f1662f26495ce9.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Henrik Grubbstr??m (Grubba)" <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 14:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwEWN-00023W-8U
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 14:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0C2M4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 08:56:39 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:59511 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab0C2M4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 08:56:36 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B6FDC5447; Mon, 29 Mar 2010 14:49:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74ce7980eb1fe629a651433ca9f1662f26495ce9.1269860022.git.grubba@grubba.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143467>

Henrik Grubbstr??m (Grubba) wrote:
>A few places used plain zeros as the last argument to convert_to_git,
>instead of the corresponding enum constant.

>Signed-off-by: Henrik Grubbstr??m <grubba@grubba.org>

Trivial.

Acked-By: Stephen R. van den Berg <srb@cuci.nl>
-- 
Stephen.
