From: Eric Raymond <esr@snark.thyrsus.com>
Subject: How can I tell if a file is ignored by git?
Date: Fri,  9 Apr 2010 00:04:34 -0400 (EDT)
Message-ID: <20100409040434.8602620CBBC@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 09 06:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O05SU-0001Yj-Qv
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 06:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889Ab0DIEEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 00:04:36 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:52608
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab0DIEEf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 00:04:35 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 8602620CBBC; Fri,  9 Apr 2010 00:04:34 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144394>

I'm planning some work on Emacs VC mode.

I need a command I can run on a path to tell if it's ignored by git.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

If gun laws in fact worked, the sponsors of this type of legislation
should have no difficulty drawing upon long lists of examples of
criminal acts reduced by such legislation. That they cannot do so
after a century and a half of trying -- that they must sweep under the
rug the southern attempts at gun control in the 1870-1910 period, the
northeastern attempts in the 1920-1939 period, the attempts at both
Federal and State levels in 1965-1976 -- establishes the repeated,
complete and inevitable failure of gun laws to control serious crime.
        -- Senator Orrin Hatch, in a 1982 Senate Report
