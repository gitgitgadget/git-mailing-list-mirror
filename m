From: Manos Pitsidianakis <epilys@norn.io>
Subject: Re: [PATCH v3] log: forbid log --graph --no-walk
Date: Mon, 16 Mar 2015 21:15:59 +0200
Message-ID: <55072BEF.5040608@norn.io>
References: <5504D5A2.2070405@norn.io> <CABwkPcpdpsVUFa_GSr=qYazYQDBr_ygQTctFXmYQf2ZsRt5bpA@mail.gmail.com> <5504DF62.4050104@norn.io> <CABwkPcpRG0d23OCuoktRdXt9nyA3RtmxGkqkoQ-wApzZvtfYDQ@mail.gmail.com> <55072856.5090308@norn.io> <xmqq7fugrc9m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 20:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXaTN-0002Ct-FJ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 20:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbbCPTOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 15:14:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38868 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259AbbCPTOk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 15:14:40 -0400
Received: from mfilter8-d.gandi.net (mfilter8-d.gandi.net [217.70.178.137])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id AD0F8A80BC;
	Mon, 16 Mar 2015 20:14:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter8-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter8-d.gandi.net (mfilter8-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id cSWRT9MORwTc; Mon, 16 Mar 2015 20:14:37 +0100 (CET)
X-Originating-IP: 5.54.110.208
Received: from [192.168.2.2] (ppp005054110208.access.hol.gr [5.54.110.208])
	(Authenticated sender: epilys@norn.io)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D0F42A80B4;
	Mon, 16 Mar 2015 20:14:36 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqq7fugrc9m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265589>

On 03/16/2015 09:08 PM, Junio C Hamano wrote:
> Perhaps 13b25381 (revision: forbid combining --graph and --no-walk,
> 2015-03-11) that is queued on 'pu' would be a good answer to this
> question?

Didn't notice a patch was queued on 'pu', thanks.
