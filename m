From: Marc Haber <mh+git@zugschlus.de>
Subject: Re: How to check repository/working tree status from a script
Date: Wed, 20 May 2009 16:29:58 +0200
Message-ID: <20090520142958.GD15453@torres.zugschlus.de>
References: <20090519143537.GA23505@torres.zugschlus.de> <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk> <20090519160031.GB23505@torres.zugschlus.de> <alpine.LFD.2.01.0905190915050.3301@localhost.localdomain> <20090520111028.GA15453@torres.zugschlus.de> <4A13EA4E.9050805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 16:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6mo3-0006px-GO
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 16:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbZETO36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 10:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbZETO35
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 10:29:57 -0400
Received: from torres.zugschlus.de ([85.214.68.41]:45881 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbZETO35 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 10:29:57 -0400
Received: from mh by torres.zugschlus.de with local (Exim 4.69)
	(envelope-from <mh+git@zugschlus.de>)
	id 1M6mnu-0004sM-D6
	for git@vger.kernel.org; Wed, 20 May 2009 16:29:58 +0200
Content-Disposition: inline
In-Reply-To: <4A13EA4E.9050805@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119613>

On Wed, May 20, 2009 at 01:32:30PM +0200, Johannes Sixt wrote:
> See 'man git':
> 
> "Porcelain" commands are *not* for use in scripts; their output may
> change. git diff, git status, git commit, git checkout are in this category.
> 
> "Plumbing" commands are for use in scripts and their output will not
> change. git ls-files, git diff-tree, git diff-files are in this category.

Missed that. Sorry. Thanks.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 3221 2323190
