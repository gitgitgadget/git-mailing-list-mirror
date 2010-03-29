From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 5/5] convert: Added core.refilteronadd feature.
Date: Mon, 29 Mar 2010 14:54:26 +0200
Message-ID: <20100329125426.GH22480@cuci.nl>
References: <cover.1269860022.git.grubba@grubba.org>
 <33b5ea46a0534af9dc755ae58e5dd4995525f643.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Henrik Grubbstr??m (Grubba)" <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 14:54:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwEUD-0000mI-7y
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 14:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426Ab0C2My2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 08:54:28 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:59250 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0C2My1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 08:54:27 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2010 08:54:27 EDT
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B281B544A; Mon, 29 Mar 2010 14:54:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <33b5ea46a0534af9dc755ae58e5dd4995525f643.1269860022.git.grubba@grubba.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143464>

Henrik Grubbstr??m (Grubba) wrote:
>When having $Id$ tags in other versioning systems, it is customary
>to recalculate the tags in the source on commit or equvivalent.
>This commit adds a configuration option to git that causes source
>files to pass through a conversion roundtrip when added to the index.

>Signed-off-by: Henrik Grubbstr??m <grubba@grubba.org>

Looks good as well.

Acked-By: Stephen R. van den Berg <srb@cuci.nl>
-- 
Stephen.
