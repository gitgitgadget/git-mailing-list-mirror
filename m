From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] checkout: add 'pre-checkout' hook
Date: Wed, 14 Oct 2009 19:50:50 +1300
Organization: Catalyst IT (NZ) Ltd
Message-ID: <4AD574CA.8010900@catalyst.net.nz>
References: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz> <36ca99e90910132349o25322021l266124bd8b0d30b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, elliot@catalyst.net.nz
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 08:55:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxxlZ-0007wB-Tn
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 08:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbZJNGv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 02:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbZJNGv2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 02:51:28 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:51592 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbZJNGv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 02:51:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id AA05532396;
	Wed, 14 Oct 2009 19:50:50 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRSvC+u651QN; Wed, 14 Oct 2009 19:50:50 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 4615332214;
	Wed, 14 Oct 2009 19:50:50 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <36ca99e90910132349o25322021l266124bd8b0d30b3@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130262>

Bert Wesarg wrote:
>> +pre-checkout
>> +-----------
>>
>> -post-checkout
>> -~~~~~~~~~~~~~
>> -
> Why do you change the caption from subsection (Ie. ~~~) to section (Ie. ---)?

Possibly the headings changed from the version I originally patched to
the current 'master'.  More likely, I just made a simple mistake :-}
-- 
Sam Vilain, Perl Hacker, Catalyst IT (NZ) Ltd.
phone: +64 4 499 2267        PGP ID: 0x66B25843
