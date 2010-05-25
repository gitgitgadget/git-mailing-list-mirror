From: Albert Krawczyk <u4232169@anu.edu.au>
Subject: Re: [GSoC 2010] The 1st week
Date: Tue, 25 May 2010 17:26:31 +1000
Message-ID: <4BFB7BA7.2080004@anu.edu.au>
References: <AANLkTikSafHBj7VwjwjTVeW3ohL60dOp4sKfZW_vZzCM@mail.gmail.com>  <15312_1274768714_4BFB6D49_15312_1749_67_20100525062457.GB10898@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bo Yang <struggleyb.nku@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 25 09:27:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGoXY-0007VC-FZ
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 09:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab0EYH06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 03:26:58 -0400
Received: from anumail9.anu.edu.au ([130.56.64.135]:43525 "EHLO
	anumail9.anu.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab0EYH06 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 03:26:58 -0400
Received: from mailout2.anu.edu.au (mailout2.anu.edu.au [130.56.64.233])
	by anumail9.anu.edu.au (8.14.3/8.14.3) with ESMTP id o4P7QXKr020195;
	Tue, 25 May 2010 17:26:33 +1000 (EST)
Received: from mailout2.anu.edu.au (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 063169E83C1;
	Tue, 25 May 2010 17:26:33 +1000 (EST)
Received: from smtphost.anu.edu.au (ds2.anu.edu.au [130.56.64.54])
	by mailout2.anu.edu.au (Postfix) with ESMTP id B25789E83C0;
	Tue, 25 May 2010 17:26:32 +1000 (EST)
Received: from [192.168.0.150] (burg237222.anu.edu.au [150.203.237.222])
	by smtphost.anu.edu.au (8.14.3/8.14.3) with ESMTP id o4P7QWIS000839;
	Tue, 25 May 2010 17:26:32 +1000 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <15312_1274768714_4BFB6D49_15312_1749_67_20100525062457.GB10898@coredump.intra.peff.net>
X-PMX-Version: 5.5.9.395186, Antispam-Engine: 2.7.2.376379, Antispam-Data: 2010.5.25.71518 internal
X-PMX-Outbound: anu.edu.au
X-PMX-Info: from-anu
X-PerlMx-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_500_599 0, BODY_SIZE_7000_LESS 0, FROM_EDU_TLD 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147676>

On 25/05/2010 4:24 PM, Jeff King wrote:
> Speaking of which, I haven't finished polishing the --follow patches
> from our earlier thread. I was taking a look at making history
> simplification (including --parents) work.
>    
I've been looking at getting --follow --parents to print correctly, 
however the Git code is way over my head. If somebody else smarter then 
me could have a look at that, it would be amazing...

I will keep trying, but I don't know how long it'll take me to get my 
head around the Git diff generation.

Albert
