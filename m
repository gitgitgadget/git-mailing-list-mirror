From: malc@pulsesoft.com
Subject: Re: [PATCH v2] Change octal literals to be XEmacs friendly
Date: Sat, 24 Jan 2009 17:18:19 +0300
Message-ID: <873af8okic.fsf@linmac.oyster.ru>
References: <Pine.LNX.4.64.0901240219530.19590@linmac.oyster.ru> <874ozp79y4.fsf@Astalo.kon.iki.fi> <878wp1mphq.fsf@linmac.oyster.ru> <7v3af9p9lq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 15:19:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQjMV-0004F1-GU
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 15:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbZAXOS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 09:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbZAXOS1
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 09:18:27 -0500
Received: from main.gmane.org ([80.91.229.2]:57574 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbZAXOS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 09:18:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LQjL4-0001HE-Ii
	for git@vger.kernel.org; Sat, 24 Jan 2009 14:18:22 +0000
Received: from 83.167.112.74 ([83.167.112.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 14:18:22 +0000
Received: from malc by 83.167.112.74 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 14:18:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 83.167.112.74
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.20 (linux)
Cancel-Lock: sha1:X6LwsM8sTaoqYBOvvaVr+VtaLj0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106969>

Junio C Hamano <gitster@pobox.com> writes:

> malc@pulsesoft.com writes:
>
>> Kalle Olavi Niemitalo <kon@iki.fi> writes:
>>
>>> Vassili Karpov <av1474@comtv.ru> writes:
>>>
>>>> #ooctal syntax on the other hand produces integers everywhere.
>>>
>>> GNU Emacs 20.7 doesn't support #o, but neither does it include
>>
>> Bummer
>
> To be portable you could certainly spell them in decimal integers, no?

Sure.

-- 
mailto:av1474@comtv.ru
