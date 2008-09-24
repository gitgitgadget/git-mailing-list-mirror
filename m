From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [GIT-GUI PATCH] call prepare-commit-msg hook
Date: Wed, 24 Sep 2008 12:46:22 -0700
Message-ID: <20080924194622.GF3669@spearce.org>
References: <48D02144.8030409@qlogic.com> <48D02D99.9090102@qlogic.com> <20080924170434.GW3669@spearce.org> <48DA90F9.8070606@qlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Jay Blakeborough <jay.blakeborough@qlogic.com>,
	Bill Lohse <bill.lohse@qlogic.com>
To: Joshua Williams <joshua.williams@qlogic.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 21:47:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiaKn-0000as-Og
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 21:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbYIXTqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 15:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbYIXTqX
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 15:46:23 -0400
Received: from george.spearce.org ([209.20.77.23]:56289 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbYIXTqW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 15:46:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 555953835F; Wed, 24 Sep 2008 19:46:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48DA90F9.8070606@qlogic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96684>

Joshua Williams <joshua.williams@qlogic.com> wrote:
>>
>> Can you please try to put this onto my current git-gui tree?
>> I don't have the base 10d8a44 object so I can't 3-way merge
>> this in, and the patch doesn't apply cleanly anymore.
>
> Absolutely.  Here it is:

I'm not sure what happened, but any line of context got an extra
space inserted at the front of it.  I had to go rip out the extra
spaces from every line of context to get git-apply to process the
patch.

Anyway, its applied now.  Thanks.

-- 
Shawn.
