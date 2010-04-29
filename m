From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Thu, 29 Apr 2010 10:50:44 +0000
Message-ID: <20100429105044.GB40206@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <4BD7032D.9050508@drmicha.warpmail.net>
 <4BD94599.5090309@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat May 01 04:54:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O82qT-0007e0-H2
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 04:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491Ab0EACqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 22:46:23 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:60863 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab0EACqX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 22:46:23 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 4226F5CAE;
	Thu, 29 Apr 2010 11:11:57 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 4226F5CAE
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id CA033B32;
	Thu, 29 Apr 2010 10:50:44 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id BC41ABAB3; Thu, 29 Apr 2010 10:50:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4BD94599.5090309@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146074>

Hi Michael,

On Thu, Apr 29, 2010 at 10:38:49AM +0200, Michael J Gruber wrote:
> Michael J Gruber venit, vidit, dixit 27.04.2010 17:30:
> > I can't test your target platform, but I would test the impact of the
> > code and test changes on mine. Do you have your series somewhere to pull
> > from?
> 
> OK, unsurprsingly, tests still pass on Linux (Fedora 12 x86_64).
> If anyone wants to try, the series can be found at
> 
> git://repo.or.cz/git/mjg.git
> 
> in branch
> 
> gvv/platform-compatibility
> 
> applied cleanly on current master.

Thank you for taking care of that.  Much appreciated.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
