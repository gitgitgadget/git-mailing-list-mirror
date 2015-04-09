From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: A good time to pull from your gitk tree?
Date: Thu, 09 Apr 2015 09:51:35 -0400
Message-ID: <552683E7.2000507@xiplink.com>
References: <xmqqegofa646.fsf@gitster.dls.corp.google.com> <20150324230605.GB12410@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 15:51:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgCrS-0007Of-5N
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 15:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbbDINvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 09:51:10 -0400
Received: from smtp122.ord1c.emailsrvr.com ([108.166.43.122]:50967 "EHLO
	smtp122.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445AbbDINvI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2015 09:51:08 -0400
Received: from smtp24.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 0CF1A8070F;
	Thu,  9 Apr 2015 09:51:07 -0400 (EDT)
Received: by smtp24.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 999B68079B;
	Thu,  9 Apr 2015 09:51:07 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.4.2);
	Thu, 09 Apr 2015 13:51:07 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150324230605.GB12410@iris.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266995>

On 15-03-24 07:06 PM, Paul Mackerras wrote:
> On Mon, Mar 23, 2015 at 12:03:37PM -0700, Junio C Hamano wrote:
>>
>> Is it a good time for me to pull from you, or do you recommend me to
>> wait for a bit, expecting more?  We'll go in the pre-release freeze
>> soon-ish, so I thought I should ping.
> 
> Now is a good time to pull from the usual place, thanks.

Hi Paul,

Is the usual place still
	git://ozlabs.org/~paulus/gitk
?

The latest commit I get from there is

	commit c846920f23704ece225cc5b6c7566777fb561502
	Author: Paul Mackerras <paulus@samba.org>
	Date:   Sun Mar 15 17:25:02 2015 +1100

	    gitk: Update .po files

	    Signed-off-by: Paul Mackerras <paulus@samba.org>

It seems to be missing some of the changes you accepted earlier this week.

Thanks!

		M.
