From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [ANNOUNCE] Git v2.1.0-rc1
Date: Tue, 05 Aug 2014 12:51:58 -0400
Message-ID: <53E10BAE.5070600@xiplink.com>
References: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 19:01:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEi7S-0007TE-G9
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 19:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbaHERBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 13:01:44 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:51106 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227AbaHERBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 13:01:42 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Aug 2014 13:01:42 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id DF2761800B1;
	Tue,  5 Aug 2014 12:51:55 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp24.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A8A181801F0;
	Tue,  5 Aug 2014 12:51:55 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Tue, 05 Aug 2014 16:51:55 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254813>

On 14-08-04 06:31 PM, Junio C Hamano wrote:
> 
>  * "git grep" learned grep.fullname configuration variable to force
>    "--full-name" to be default.  This may cause regressions on
>    scripted users that do not expect this new behaviour.

Should this be noted in the backward compatibility notes?

		M.
