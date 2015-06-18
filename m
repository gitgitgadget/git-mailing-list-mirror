From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/2] rebase -i: Fix left-behind
 =?UTF-8?Q?CHERRY=5FPICK=5FHEAD?=
Date: Thu, 18 Jun 2015 22:11:01 +0200
Organization: gmx
Message-ID: <f2eff1416fdae8daf003a9c54b314a6b@www.dscho.org>
References: <cover.1434627492.git.johannes.schindelin@gmx.de>
 <cover.1434645436.git.johannes.schindelin@gmx.de>
 <xmqqwpz0er61.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:11:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g9n-0005Mk-6a
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbbFRULX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:11:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:60513 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757071AbbFRULS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:11:18 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lb5nF-1YhJdM2DQv-00kh50; Thu, 18 Jun 2015 22:11:01
 +0200
In-Reply-To: <xmqqwpz0er61.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:JMN66GsxV/HM4gTomecdTFsx1p+NjlQfwRYD3+a/jmRj91ZO34O
 q81vjtTotpqnYdamnz32DOSwoTBjRjD7Sd/xIzNWFAG8kUpi29RD2B0jIpTp8mhd5YoOrZk
 2BcmbA98ObAdQGDGeuUkIde0/JqjdMIX9GuuWi50m1yAblU+ekQCawt31/1D3r96bcrmzHB
 9vYMtTmWDy4uXSZdn5ihA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZIH2DrR2zrE=:N8K6kdrPZZAPnRQk9PARyb
 Jwd7GC+PGc8XEYdldZ0C2fF0U0NARZqh8aO7qhk8SmU/BBrO4qKoYv5gEGilbuvT6n4QnvDqo
 NQnKKMcgiDV7lfGs8ibxP9xu4YEKJL42UC453F+CqzifrBiYKTLVWYCOthpiFyjsGF1zNCwpG
 BrXhaZy/ja19D6Mwu2ow2ymqZiV3tWe52tbt5wTctsffleWIb6hvIoTXmxf6hGuaG83IqWYSL
 HTo/+r6eSYabuNE1kHMHyeoW1rE+9sdK6rlO22gogm/iu9VRfLrJ5R8SuRuUB4R15vEfykneI
 vneKDSGdL9q3mzs5o3hVds/nXRVjEUCpu5AubDLKZDOCKNAb39q7gqxUZCp5H0CNWfAE7PtbJ
 eA09FNB5+8Xj3vNEARpi2wn7sIvQPSutx2QbRIy+NoZ8Jrqr0MslEVI/fYLlNp0tCaiYcs29x
 AhOoBbk7OZiidSxzeDXxcBduK/U/gb1fQvXw9B9VT0fg+HYFn8iH1vAmxfd4pmV1WeM/4wMpQ
 PKNlWuJsQvem5tkA5MMHGAW+isiZHO6at21gKHL9kdWBXVaITPvlfFSCWVLSuLDf7awhaE5Rs
 ikvcxUyny8Li7Z1yjYM3aGuSKvdLBNDFv+B/L7CuD4PSyJceGo8YubNCJLg4dQ/DIOzC6iqBt
 fdyNqJ+Y7XEaMJwY4m37jX5Yjwhhx9s/Jl+jEjtFsusJfAbwomuSYG54covpisvLQK7Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272062>

On 2015-06-18 21:45, Junio C Hamano wrote:

> This round looks good, except one trivial nit (below), which I'll
> locally squash-in a fix for.

Thanks,
Dscho
