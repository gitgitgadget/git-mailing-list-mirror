From: Joel Reed <jreed@lantekcs.com>
Subject: RE: git branch descriptions
Date: Tue, 11 May 2010 08:38:47 -0400
Message-ID: <657A681BEF27534399890012B8C8E50E1AD63D2241@lcs-exchange01.Lantekcs.com>
References: <657A681BEF27534399890012B8C8E50E1AD63D1FEA@lcs-exchange01.Lantekcs.com>
 <20100510232612.GA6890@progeny.tock>
 <F658FEF6-8957-4815-8917-8545E166F6CC@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Geert Bosch <bosch@adacore.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 14:39:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBojj-0007Gr-FX
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 14:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508Ab0EKMiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 08:38:54 -0400
Received: from [173.225.48.98] ([173.225.48.98]:49673 "EHLO mail.lantekcs.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754540Ab0EKMix convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 08:38:53 -0400
X-ASG-Debug-ID: 1273581529-2afd5dc70001-QuoKaX
Received: from exchange.lantekcs.com (lcs-exchange01.lantekcs.com [192.168.0.26]) by mail.lantekcs.com with ESMTP id Znsfcca2pfBfbPbE; Tue, 11 May 2010 08:38:49 -0400 (EDT)
X-Barracuda-Envelope-From: jreed@lantekcs.com
Received: from lcs-exchange01.Lantekcs.com ([fe80::b4fc:249:9bbc:9298]) by
 lcs-exchange01.Lantekcs.com ([fe80::18c5:3222:7819:3ef6%19]) with mapi; Tue,
 11 May 2010 08:38:49 -0400
X-ASG-Orig-Subj: RE: git branch descriptions
Thread-Topic: git branch descriptions
Thread-Index: Acrwp5TbnFsjVg0ISfuVOW0wVcibBgAXsSSw
In-Reply-To: <F658FEF6-8957-4815-8917-8545E166F6CC@adacore.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Barracuda-Connect: lcs-exchange01.lantekcs.com[192.168.0.26]
X-Barracuda-Start-Time: 1273581529
X-Barracuda-URL: http://192.168.0.2:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at lantekcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146889>

Geert Bosch wrote:

<snip>

> It seems if we'd do branch descriptions at all, their main use
> would be fore remote repositories. When you publish a branch,
> you'd typically not rewrite it on a whim, so attaching a description
> makes sense. Similarly, if you're tracking a remote repository,
> it would be helpful to get some information for the branch.

For my usage, I have to strongly disagree! I _primarily_ wish I could add a description to LOCAL branches.

jr
