From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Add menu item for reverting commits
Date: Sat, 11 May 2013 19:43:56 +1000
Message-ID: <20130511094356.GD6196@iris.ozlabs.ibm.com>
References: <1367073373.12513.3.camel@Vger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Knut Franke <Knut.Franke@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 11 12:13:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub6o5-0004MU-AJ
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 12:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab3EKKNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 06:13:31 -0400
Received: from ozlabs.org ([203.10.76.45]:43685 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583Ab3EKKNb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 06:13:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7587E2C00DD; Sat, 11 May 2013 20:13:28 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1367073373.12513.3.camel@Vger>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223954>

On Sat, Apr 27, 2013 at 04:36:13PM +0200, Knut Franke wrote:
> Sometimes it's helpful (at least psychologically) to have this feature
> easily accessible. Code borrows heavily from cherrypick.
> 
> Signed-off-by: Knut Franke <Knut.Franke@gmx.de>

Thanks, applied, after undoing the linewrapping (done by your mailer?).

Paul.
