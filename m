From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] t5551: do not use unportable sed '\+'
Date: Mon, 13 May 2013 17:17:44 +0200
Message-ID: <51910418.2070904@web.de>
References: <201305111525.53130.tboegi@web.de> <7vwqr5wdqm.fsf@alter.siamese.dyndns.org> <7vobchwbax.fsf@alter.siamese.dyndns.org> <518EA351.8000603@web.de> <7v8v3lwa5p.fsf@alter.siamese.dyndns.org> <518EAB7C.3010508@web.de> <7vsj1svqi7.fsf@alter.siamese.dyndns.org> <7vr4hbu818.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 17:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuVe-0000lE-At
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab3EMPRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:17:50 -0400
Received: from mout.web.de ([212.227.15.4]:63975 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab3EMPRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:17:49 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Lz3FM-1UOyCH0ggS-014Pji; Mon, 13 May 2013 17:17:45
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vr4hbu818.fsf_-_@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:/dOGSHthC+CPOCUQVsSc8M8ThIhwG9hojkr47cWTiyC
 2/t3fHGGz3qsoOAQQYKVM8L9WAx7s5/qElni0vvqhowQBKYkkd
 dnEcDCE9IqURRPPs1znIIsNuduS3pjcMSbrGwU4WzYyj8EeVcZ
 AGXoaoDarKoYAdNV/2FqyiSyOkbNCpaQmPwRq5x17RS0TeGLP9
 D3s40AMBKz31tMf/TJxkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224170>

On 2013-05-13 00.50, Junio C Hamano wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t5551-http-fetch.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
Thanks, works like a charm, tested on Mac OS.
/torsten
