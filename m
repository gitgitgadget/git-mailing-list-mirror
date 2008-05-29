From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible with Cygwin (and probably Windows)
Date: Thu, 29 May 2008 18:15:00 +0200
Message-ID: <39D76264-2051-4751-85BC-F79956FE9D57@wincent.com>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com> <alpine.DEB.1.00.0805291422210.13507@racer.site.net> <29FDE86E-5B83-4736-8CC6-9C5697B91B2C@wincent.com> <alpine.DEB.1.00.0805291704280.13507@racer.site.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 18:16:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1knY-0003vo-B2
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 18:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201AbYE2QPV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 May 2008 12:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756008AbYE2QPU
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 12:15:20 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:48796 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434AbYE2QPT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 May 2008 12:15:19 -0400
Received: from cuzco.lan (157.pool85-53-24.dynamic.orange.es [85.53.24.157])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m4TGF0OA006668
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 29 May 2008 12:15:02 -0400
In-Reply-To: <alpine.DEB.1.00.0805291704280.13507@racer.site.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83215>

El 29/5/2008, a las 18:05, Johannes Schindelin escribi=F3:
> Hi,
>
> On Thu, 29 May 2008, Wincent Colaiuta wrote:
>
>> El 29/5/2008, a las 15:22, Johannes Schindelin escribi=F3:
>>
>>> Probably you are not enoyed enough to just go and fix it.
>>
>> No, that's not actually the case. In reality I was pleasantly =20
>> surprised
>> when Junio commented that "perhaps we should remove" that file;
>
> You misunderstood me.  I was not talking about "fixing" it by =20
> removing the
> file, and papering over the UTF-8 issue on HFS+.
>
> I was talking about fixing it by handling UTF-8 in a way that is
> compatible with (maybe stupid, but that cannot be helped) HFS+.

Ah, ok. That's way beyond my skill set and a completely different =20
subject. I was responding to Junio's comment about _removing_ the file.

Wincent
