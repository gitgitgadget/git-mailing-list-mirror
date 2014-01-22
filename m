From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Wed, 22 Jan 2014 16:49:22 +0100
Message-ID: <52DFE882.2040605@atlas-elektronik.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com> <xmqqha8xt22p.fsf@gitster.dls.corp.google.com> <CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Javier Domingo Cansino <javierdo1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 16:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W602v-00080E-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 16:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004AbaAVPst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 10:48:49 -0500
Received: from mail96.atlas.de ([194.156.172.86]:30940 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755550AbaAVPss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 10:48:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 454A810152;
	Wed, 22 Jan 2014 16:48:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZW_wDjSTzJzR; Wed, 22 Jan 2014 16:48:46 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed, 22 Jan 2014 16:48:46 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id EE58227169;
	Wed, 22 Jan 2014 16:48:45 +0100 (CET)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.5; Wed, 22 Jan
 2014 16:48:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240832>

Am 22.01.2014 13:53, schrieb Javier Domingo Cansino:
> Will there be any change on how tarballs are distributed, taking into
> account that Google will be shutting down Google Code Downloads
> section[1][2]?
> 

Am I missing something or what's wrong with this:

  https://github.com/gitster/git/archive/v1.9-rc0.tar.gz

or any

  https://github.com/gitster/git/archive/$TAG.tar.gz

??

(As long as Junio continues to push to github, of course)

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Folks who think they know it all bug those of us who do
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
