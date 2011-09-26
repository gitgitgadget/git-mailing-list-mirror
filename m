From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Could someone give me a copy of git internal api document?
Date: Mon, 26 Sep 2011 09:23:30 +0200
Message-ID: <4E802872.2010906@elegosoft.com>
References: <CAMocUqREFHdqFGR9c_3hFJy6KxUaXLnaY9R+4K04mL42-KY-Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?R2l0IOmCruS7tuWIl+ihqA==?= <git@vger.kernel.org>
To: =?UTF-8?B?5b6Q6L+q?= <xudifsd@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 09:24:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R85Xz-0007Sv-F5
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 09:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab1IZHYK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 03:24:10 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:51059 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641Ab1IZHYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 03:24:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 191F7DE72C;
	Mon, 26 Sep 2011 09:24:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vLF0sIumopEA; Mon, 26 Sep 2011 09:24:02 +0200 (CEST)
Received: from [192.168.1.101] (g230120021.adsl.alicedsl.de [92.230.120.21])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 29BFADE729;
	Mon, 26 Sep 2011 09:24:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <CAMocUqREFHdqFGR9c_3hFJy6KxUaXLnaY9R+4K04mL42-KY-Kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182092>

On 09/26/2011 09:11 AM, =E5=BE=90=E8=BF=AA wrote:
> I am reading code of git recently, and i want to know some internal
> api in git, so i googled "git internal api", and result is
> http://www.kernel.org/pub/software/scm/git/docs/v1.6.5.9/technical/ap=
i-index.html
> but kernel.org was down for maintenance, and i have no idea when it
> will recover, could someone give me a mirror url or post me a copy of
> it?

If you got the code, you should have Documentation/technical in your
source tree.?

Alternate repository source:

http://repo.or.cz/w/alt-git.git

Documentation/technical on GitHub:

https://github.com/gitster/git/tree/master/Documentation/technical
