From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Thu, 22 Sep 2011 11:14:20 +0200
Message-ID: <4E7AFC6C.7080603@elegosoft.com>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org> <1316680641.11165.2.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Sep 22 11:15:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6fMz-0002T1-SM
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 11:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab1IVJO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 05:14:56 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:38994 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507Ab1IVJO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 05:14:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id E829ADE77E;
	Thu, 22 Sep 2011 11:14:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7HPMTk8wZGQ7; Thu, 22 Sep 2011 11:14:50 +0200 (CEST)
Received: from [192.168.1.101] (g230121242.adsl.alicedsl.de [92.230.121.242])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 02AC9DE73C;
	Thu, 22 Sep 2011 11:14:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <1316680641.11165.2.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181891>

On 09/22/2011 10:37 AM, Carlos Mart=C3=ADn Nieto wrote:
> On Wed, 2011-09-21 at 22:04 -0700, Junio C Hamano wrote:
>> * cn/eradicate-working-copy (2011-09-21) 2 commits
>>  - patch-id.c: use strbuf instead of a fixed buffer
>>  - Remove 'working copy' from the documentation and C code
>=20
> It looks like that first commit sneaked in there. Shouldn't that be i=
ts
> own topic?

It's in pu twice:

On 09/22/2011 07:04 AM, Junio C Hamano wrote:=20
> * cn/eradicate-working-copy (2011-09-21) 2 commits
>  - patch-id.c: use strbuf instead of a fixed buffer
>  - Remove 'working copy' from the documentation and C code

> * ms/patch-id-with-overlong-line (2011-09-21) 1 commit
>  - patch-id.c: use strbuf instead of a fixed buffer

64128da and a6c5c60

There's also a minor typo in the last sentence of the commit message.
Should I resend?
