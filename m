From: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH] hg-to-git: fix COMMITTER type-o
Date: Tue, 12 Jan 2010 12:16:51 +0100
Message-ID: <20100112111651.GC3463@calypso>
References: <1262998479-24269-1-git-send-email-bart@jukie.net>
Reply-To: Stelian Pop <stelian@popies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 12:25:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUesT-0004KP-Kq
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 12:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352Ab0ALLZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 06:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344Ab0ALLZc
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 06:25:32 -0500
Received: from sd-11162.dedibox.fr ([88.191.70.230]:40001 "EHLO
	sd-11162.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab0ALLZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 06:25:31 -0500
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2010 06:25:31 EST
Received: from sd-11162.dedibox.fr (localhost.localdomain [127.0.0.1])
	by sd-11162.dedibox.fr (Postfix) with ESMTP id 42ABD92D4F;
	Tue, 12 Jan 2010 12:16:52 +0100 (CET)
Received: from calypso (lns-bzn-51f-81-56-134-205.adsl.proxad.net [81.56.134.205])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sd-11162.dedibox.fr (Postfix) with ESMTPSA id 29BBA929BD;
	Tue, 12 Jan 2010 12:16:52 +0100 (CET)
Received: by calypso (Postfix, from userid 1000)
	id DFB891CAEB2; Tue, 12 Jan 2010 12:16:51 +0100 (CET)
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1262998479-24269-1-git-send-email-bart@jukie.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-AV-Checked: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136717>

Hi Bart,

On Fri, Jan 08, 2010 at 07:54:39PM -0500, Bart Trojanowski wrote:

> This script passes the author and committer to git-commit via environment
> variables, but it was missing the seccond T of COMMITTER in a few places.
> 
> Signed-off-by: Bart Trojanowski <bart@jukie.net>

FWIW:
	Acked-by: Stelian Pop <stelian@popies.net>

Thanks!

Stelian.
-- 
Stelian Pop <stelian@popies.net>
