From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: Re: [PATCH -resend] Add a helper script to send patches with Mozilla Thunderbird
Date: Fri, 20 Jun 2008 10:22:12 +0900
Message-ID: <20080620102212.6117@nanako3.lavabit.com>
References: <7vmylhq6lb.fsf@gitster.siamese.dyndns.org>
	<484D6A40.60002@etek.chalmers.se>
	<485AE9FD.8050508@etek.chalmers.se>
	<7vmylhq6lb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lukas Sandstrm <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 03:24:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9VM7-0003w7-Fi
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 03:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbYFTBWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 21:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754326AbYFTBWv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 21:22:51 -0400
Received: from karen.lavabit.com ([72.249.41.33]:40460 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbYFTBWu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 21:22:50 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 4F46EC7A77;
	Thu, 19 Jun 2008 20:22:42 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 9W6GC8NTCL7L; Thu, 19 Jun 2008 20:22:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=tYosfktuQG5hBONHVTq5PphNAeff/dG3H37NefE2UtLMA8nXZhPz6Br3wtiEedls9bJcVv0ai2UGoBQZfABIpfF7PHynWllHblsYd2Cr29EC58887gK0FByufG0k5b9QZCVUVNBdCQiRLSH0td4fbi5rMe4YcyekMGGlAEimOQ8=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7vmylhq6lb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85585>

Quoting Junio C Hamano <gitster@pobox.com>:

> Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:
>
>> The script appp.sh can be used with the External Editor extension fo=
r
>> Mozilla Thunderbird in order to be able to send inline patches in an
>> easy way.
>>
>> Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
>> ---
>>
>> Resending. It would be nice if this ended up in contrib/
>>
>> /Lukas
>>
>>  Documentation/SubmittingPatches          |    5 +++
>>  contrib/thunderbird-patch-inline/README  |   20 +++++++++++
>>  contrib/thunderbird-patch-inline/appp.sh |   55 +++++++++++++++++++=
++++++++
>
> A silly question.  What does "appp" stand for?  AppendPatch does not =
have
> that many P's in it.

Silly Junio (^_^).  Count them again.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
