From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Fix compile warnings with MSys2's compiler
Date: Sat, 16 Jan 2016 18:00:09 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601161759190.2964@virtualbox>
References: <cover.1452864241.git.johannes.schindelin@gmx.de> <xmqqh9iefnj2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 18:01:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKUDl-0000UO-QD
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 18:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbcAPRAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2016 12:00:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:53164 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbcAPRAW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2016 12:00:22 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LcBPV-1ZvYrP3eTN-00jZEV; Sat, 16 Jan 2016 18:00:10
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqh9iefnj2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0FD6RXZqd0Aa7I1Tj2NbF5bKqUyBoQ+3bD2rD70qSh+sHntCVwp
 CKpljqWL53sc+CXSbmE5+Kk3uktgl/89au/eOhtKW1lsQ3tqJlA/VHatDG6wavTL9axMGKz
 oAafT8sC6ZbhUwtjabuH2ZE83/RlhYNky5g/0Hl3PB0mlqaUzTRma3NL5zEAYITyNDrMTs6
 Gp164CV3oZST3KLiwCCDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JZdRUowYCA4=:m6AhRWrn8gH/7Ql6pZRcR8
 L/737C5ipsBVa9Taaz7ao2yILSWK+cFehQOhUXTfY6p6mJ4pcwNudrzZK5ADfjiP88sFjfIl6
 3SEcNmcyLlWU5fCLyC28czM8Llhs/8M0N41QMt4u3EFz0U43ibbEnGC7IN/zbGu9TLSEXoDwC
 qE+PFHbyKPgCP8rPp+TtZynUbGnU5G2veQ1BtpdEUXKFldBpmzVqSEPN760KR7vSgmDWCjVEY
 aetWWX8+4eKlSmDjbcRGlmaV6JkIF+UcCNcyi4BOSxcdjvcFQp5horrdAwDxXJMHQryPlSwmd
 cCcsuYU+hZ/anDfX68/vlDLUtzMy/HsQN7GbAwi1AzopUykffvX01gfWAT3hdqtdFe6sVA7/j
 8SLD0ZE1CZ50sJPFRuksaXCdnf7JQdL9/akcr2AaOqi9QGh5mrpahhAbq3YIqHbE50mscDo+8
 zEfWG9KfpU12BwjFZjlS8l/fI62p9/AGQr1ZvuDnAY3vc8jq0Ylh0JGxpnhn5rNjF1Ec8fEgg
 xKAm99MqkSSgMmBFDNQ9wuRZTecs3TKYNTjBFkBVb7b47IWf4SY9fKWYF8nqjpXGHQofNs7T6
 eLP8Y900U1crOyNnQvEEPGYB/e9szm0RcxJ2BtptajJO0whFWpWa7olZqzZcqkqsbgvmXlYae
 Ppe2Ny/2Pr5A0dhsal63lnaFfkTFhQ2o+INHlWTS7vQaSmY7SfjnYeNfbxO/RGqib9vH/WKKN
 Y2GOZ+WgWERCmXaInsBMkhG9hyhF7isVi/9JTVg69Cyllhuvx/MmVG/gwNkZGBV/1wepH8yK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284245>

Hi Junio,

On Fri, 15 Jan 2016, Junio C Hamano wrote:

> Thanks, queued.

Thank you!

> The last one does look ugly as you said; I do not think of a better
> alternative to offer, though X-<.

It makes me happy that I did not miss any obvious way to make this look
better, and it makes me sad you cannot find a better alternative either
;-)

Ciao,
Dscho
