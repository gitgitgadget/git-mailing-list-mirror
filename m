From: Tony Finch <dot@dotat.at>
Subject: Re: git-http-backend vs gitweb pathinfo mode
Date: Mon, 5 Aug 2013 16:51:48 +0100
Message-ID: <alpine.LSU.2.00.1308051650090.16837@hermes-2.csi.cam.ac.uk>
References: <alpine.LSU.2.00.1308051624570.16837@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tony Finch <dot@dotat.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 05 17:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6N4b-0004Mf-JI
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab3HEPvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:51:50 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:36611 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab3HEPvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:51:49 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:49457)
	by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1V6N4W-0001nK-1Z (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 05 Aug 2013 16:51:48 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1V6N4W-0007Dm-EO (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 05 Aug 2013 16:51:48 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <alpine.LSU.2.00.1308051624570.16837@hermes-2.csi.cam.ac.uk>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231661>

Tony Finch <dot@dotat.at> wrote:
>
> For example, go to https://git.csx.cam.ac.uk/i/ucs/git/git.git/tree
> and click on the gitweb subdirectory which takes you to
> https://git.csx.cam.ac.uk/i/ucs/git/git.git/tree/HEAD:/gitweb
> then click on [git/git.git] to go back, which takes you to
> https://git.csx.cam.ac.uk/i/ucs/git/git.git/tree/HEAD

Whoops, those are the internal not the external URLs... try:

   https://git.csx.cam.ac.uk/x/ucs/git/git.git/tree
-> https://git.csx.cam.ac.uk/x/ucs/git/git.git/tree/HEAD:/gitweb
-> https://git.csx.cam.ac.uk/x/ucs/git/git.git/tree/HEAD

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first.
Rough, becoming slight or moderate. Showers, rain at first. Moderate or good,
occasionally poor at first.
