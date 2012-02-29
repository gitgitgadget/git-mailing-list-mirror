From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: Incremental updates to What's cooking
Date: Wed, 29 Feb 2012 21:19:18 +0100
Message-ID: <4F4E8846.6030203@in.waw.pl>
References: <7vy5rn1mar.fsf@alter.siamese.dyndns.org> <4F4DD5C1.60604@in.waw.pl> <7vbooiuj6z.fsf@alter.siamese.dyndns.org> <4F4E2D32.9030209@in.waw.pl> <7v1updtp57.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 21:19:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2pzn-00053o-Dr
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 21:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab2B2UT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 15:19:26 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55347 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755070Ab2B2UTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 15:19:25 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S2pzg-0002r6-HJ; Wed, 29 Feb 2012 21:19:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7v1updtp57.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191851>

On 02/29/2012 08:28 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>
>> t4052 tests show, log, merge, diff and format-patch with basically t=
he
>> same commands. Separating the tests into different files would requi=
re
>> duplicating a lot of setup code. OTOH, t4014 is only about
>> format-patch, so the other ones don't fit. I thought it would be
>> better to create a new file.
>
> OK, then perhaps we want to move the versions of duplicated one them =
from
> 4014 to 4052?
Do you mean move a version of non-duplicated ones from t4014 to t4052=20
and remove the duplicated ones?

Zbyszek
