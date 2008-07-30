From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: Gitweb: Provide Git links in project list?
Date: Wed, 30 Jul 2008 15:02:57 +0200
Message-ID: <20080730130257.GB28566@frsk.net>
References: <20080730125743.GY15356@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Richter <robert.richter@amd.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 15:43:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOBxm-000881-PM
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 15:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbYG3Nme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 09:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYG3Nme
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 09:42:34 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:44240 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbYG3Nme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 09:42:34 -0400
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1KOBKU-0001U2-8U; Wed, 30 Jul 2008 15:02:58 +0200
Received: from fredrik by asterix.frsk.net with local (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1KOBKT-0003R7-UC; Wed, 30 Jul 2008 15:02:57 +0200
Content-Disposition: inline
In-Reply-To: <20080730125743.GY15356@erda.amd.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90785>

On Wed, Jul 30, 2008 at 02:57:43PM +0200, Robert Richter wrote:

> The Gitweb on git.kernel.org povides links to the Git repository for
> each project (git <git://...>). However, I did not find this feature
> in the current implementation of git_project_list_body(). Does
> somebody know if there is a patch available for this and if this could
> be added to gitweb?

Is putting the address in .git/cloneurl giving the behaviour you're looking for?

- F

-- 
Regards,
Fredrik Skolmli
