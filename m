From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Wed, 12 Aug 2009 21:10:36 +0530
Message-ID: <87ljlpvy4r.fsf@hariville.hurrynot.org>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
	<1250005446-12047-2-git-send-email-pclouds@gmail.com>
	<1250005446-12047-3-git-send-email-pclouds@gmail.com>
	<1250005446-12047-4-git-send-email-pclouds@gmail.com>
	<1250005446-12047-5-git-send-email-pclouds@gmail.com>
	<1250005446-12047-6-git-send-email-pclouds@gmail.com>
	<1250005446-12047-7-git-send-email-pclouds@gmail.com>
	<1250005446-12047-8-git-send-email-pclouds@gmail.com>
	<1250005446-12047-9-git-send-email-pclouds@gmail.com>
	<4A826FD4.5080201@viscovery.net>
	<fcaeb9bf0908120253p192125a4mbb6a0838fc90f10e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 17:56:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbGBv-0001uq-CQ
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 17:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbZHLP4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 11:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753896AbZHLP4H
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 11:56:07 -0400
Received: from main.gmane.org ([80.91.229.2]:41069 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725AbZHLP4G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 11:56:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MbGBI-0003Bt-QS
	for git@vger.kernel.org; Wed, 12 Aug 2009 15:56:04 +0000
Received: from 59.92.155.77 ([59.92.155.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 15:56:04 +0000
Received: from harinath by 59.92.155.77 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 15:56:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.155.77
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Cancel-Lock: sha1:9oaaLklNs4mOzmdJ+yo1vz1Jhls=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125714>

Hi,

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2009/8/12 Johannes Sixt <j.sixt@viscovery.net>:
>> BTW, the name .git/info/sparse is perhaps a bit too technical in the=
 sense
>> that only git developers know that this feature runs under the name
>> "sparse checkout". Perhaps it should be named
>>
>> =C2=A0 .git/info/indexonly
>> =C2=A0 .git/info/nocheckout
>>
>> or so.
>
> I did not like the name "sparse" either. Another option is
> .git/info/assume-unchanged.

Or .git/info/doppelgangers, or even .git/info/doppelg=C3=A4ngers :-)

- Hari
