From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule
 does not yield complete logs")
Date: Fri, 22 May 2015 15:25:14 +0200
Message-ID: <555F2E3A.1040600@atlas-elektronik.com>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	"emma@gitforteams.com" <emma@gitforteams.com>
To: Roberto Tyley <roberto.tyley@gmail.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 22 15:31:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvn2n-0007Nu-36
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 15:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbbEVNbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 09:31:16 -0400
Received: from mail96.atlas.de ([194.156.172.86]:14530 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422688AbbEVNbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 09:31:15 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2015 09:31:15 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id B4CC710915;
	Fri, 22 May 2015 15:25:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPQ5nodpeHxr; Fri, 22 May 2015 15:25:15 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri, 22 May 2015 15:25:15 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 967ED2716C;
	Fri, 22 May 2015 15:25:14 +0200 (CEST)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server id 8.3.327.1; Fri, 22 May 2015
 15:25:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
OpenPGP: id=2DF5E01B09C37501BCA99666829B49C5922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269713>

Am 22.05.2015 um 10:33 schrieb Roberto Tyley:
> [...]
> Hello, I'm stepping up to do that work :) Or at least, I'm implementing a
> one-way GitHub PR -> Mailing list tool, called submitGit:
> 
> https://submitgit.herokuapp.com/

That looks really promising!
I wonder if that wouldn't make a good addition to github's repository ui
in general ?

Thanks,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: Diplomacy: The patriotic art of lying for one's country.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF
