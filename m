From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] l10: de.po: grammar fix
Date: Wed, 20 May 2015 10:55:48 +0200
Message-ID: <555C4C14.4040305@drmicha.warpmail.net>
References: <cover.1432025365.git.git@drmicha.warpmail.net>	<2b4460dbf6abb15c4cd94d4c5c335cc9e8059ee7.1432025365.git.git@drmicha.warpmail.net> <CAGZ79kYPhTK=tymEcB_YsYdNZvt0=sA4-Hon1SLwujV39W7fmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 20 11:03:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuzuX-0001AW-Hi
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 11:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbbETJDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 05:03:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37380 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752649AbbETJDP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2015 05:03:15 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2015 05:03:15 EDT
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id CD64020C12
	for <git@vger.kernel.org>; Wed, 20 May 2015 04:55:49 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 20 May 2015 04:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=/3WsWkUD0nKr+DZNAuZ85Fe8WUs=; b=VKYusF
	MJloueQmt5wCNpyPvVDgxxIFEdWCDKnKhfFILhLRjgE0+GllPmc7QyJB6mEtOTd0
	Y3zFahPwbOZeB7sKnhnMmREoYvHhwxkFr96LuH5ArTLWR5OGi72q0zDWzOo6/YC3
	sb4leoxOxp9xT6nQpw4uMDAa9rtD+OLWn+cPo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=/3WsWkUD0nKr+DZ
	NAuZ85Fe8WUs=; b=cgu505nCUFsyVGi3LBqwdp5lyUC8SE1CHzRFYK4hevxoAMw
	e3TzbwVLiF+kwqAbuTaU4uGbXCU/Ulx0ffcHQ38shm4dDPAvcWhPd1Ej2NNWw6Xz
	fuuTr0Trx0IkpL0LDdUnLJopj2uNTFYvRh3Xr0fUglhK6kxpbtw0iI1ov8ac=
X-Sasl-enc: vE9hv1pme55qSA0EJTPbflz4ZVtmPNPlXn6HziwoaJev 1432112149
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3EF5B68019D;
	Wed, 20 May 2015 04:55:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAGZ79kYPhTK=tymEcB_YsYdNZvt0=sA4-Hon1SLwujV39W7fmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269454>

Stefan Beller venit, vidit, dixit 19.05.2015 23:46:
> On Tue, May 19, 2015 at 1:51 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  po/de.po | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/po/de.po b/po/de.po
>> index 2feaec1..25258e3 100644
>> --- a/po/de.po
>> +++ b/po/de.po
>> @@ -10478,7 +10478,7 @@ msgstr ""
>>  #: git-am.sh:142
>>  msgid "Using index info to reconstruct a base tree..."
>>  msgstr ""
>> -"Verwende Informationen aus der Staging-Area, um einen Basisverzeichnis "
>> +"Verwende Informationen aus der Staging-Area, um ein Basisverzeichnis "
>>  "nachzustellen"
> 
> Waere es sinnvoll Staging-Area in Staging-Bereich umzubenennen?
> "Staging" ist wohl ein eher fester Term mit dem man den index/staging area
> assoziert, aber "Area" 'doesn't ring a bell for me'.

Staging-Bereich would be Denglish - half German and halb Englisch.

In any case, the term staging area is highly confusing in this context:
It really is the index, and in this case the user has not "staged
anything for commit" in the index. The index is used for storing
information during the 3way merge. This is why we refused to replace
"index/cache" by "staging area" in the original git documentation.

The de l10n team decided to use "Staging-Area" as the translation for
"index" (as far as I can see), and therefore I kept this term: It is
important to translate the same concept in the same way consistently in
all places. Changing the translation of "index" would be a major
decision and a major patch. (I'd vote for "Index".)

Michael
