From: Thierry Parmentelat <thierry.parmentelat@sophia.inria.fr>
Subject: Re: [PATCH/RFH] Mark user-manual as UTF-8
Date: Tue, 24 Jul 2007 12:45:05 +0200
Message-ID: <46A5D831.6090608@sophia.inria.fr>
References: <7vwswqgs6c.fsf@assigned-by-dhcp.cox.net> <4753DAE3-2F1F-49C0-906A-09CBAF240C87@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 12:44:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHsh-00013P-Bz
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbXGXKok convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Jul 2007 06:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764268AbXGXKok
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:44:40 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:55854 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760066AbXGXKoj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 06:44:39 -0400
X-IronPort-AV: E=Sophos;i="4.16,574,1175464800"; 
   d="scan'208";a="621243"
Received: from muck.inria.fr ([138.96.250.111])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Jul 2007 12:44:38 +0200
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <4753DAE3-2F1F-49C0-906A-09CBAF240C87@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53562>

Hi there - I'm the wierd guy :-)

I've just reloaded the page and the weird stuff has gone.


Wincent Colaiuta wrote:
> El 24/7/2007, a las 9:46, Junio C Hamano escribi=F3:
>
>> There have been several complaints against k.org's user-manual
>> page.  The document is generated in ISO-8859-1 by the xsltproc
>> toolchain (I suspect this is because released docbook.xsl we use
>> has xsl:output element that says the output is ISO-8859-1) but
>> server delivers it with "charset=3DUTF-8", and all h*ll breaks
>> loose.
>>
>> This attempts to force UTF-8 on the generating end.
>
> Thanks for doing this, Junio. I was one of the people who reported=20
> this (although never saw my mail get through to the list).
>
> Funnily, enough, about an hour after you posted your patch another=20
> email ("git documentation - user manual html version has wierd [sic]=20
> characters all over the place") was posted to the list...
>
> Cheers,
> Wincent
