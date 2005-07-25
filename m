From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Problems Importing a CVS tree into FAUmachine
Date: Mon, 25 Jul 2005 11:20:20 +0200
Message-ID: <20050725092020.GC25825@cip.informatik.uni-erlangen.de>
References: <20050724205601.GD2117@cip.informatik.uni-erlangen.de> <20050725085756.GA25825@cip.informatik.uni-erlangen.de> <20050725090313.GB25825@cip.informatik.uni-erlangen.de> <20050725091505.GA5680@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 25 11:25:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwzCJ-0004IJ-Rx
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 11:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVGYJYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 05:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVGYJYZ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 05:24:25 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:22010 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261159AbVGYJYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 05:24:24 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.11/8.12.11) with ESMTP id j6P9KKAN003872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jul 2005 09:20:20 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.11/8.12.11) id j6P9KKGe003871;
	Mon, 25 Jul 2005 11:20:20 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050725091505.GA5680@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> If there's no lib/pattern-matcher/input/Pic0.ppm,v nor
> lib/pattern-matcher/input/Attic/Pic0.ppm,v file ...

no there isn't.

> ... then, congratulations, you've found a bug in cvsps.  Please talk
> to its author.

yes, it seems so. My currently theory is that cvsps extracts the
information out of the log message of the Pic1.ppm file. However I
wonder why my grep didn't came with something up.

	Thomas
