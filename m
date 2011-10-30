From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: What's cooking in git.git (Oct 2011, #11; Fri,
 28)
Date: Sun, 30 Oct 2011 22:43:14 +0100
Message-ID: <4EADC4F2.9040008@kdbg.org>
References: <7vzkglrnmc.fsf@alter.siamese.dyndns.org> <CABPQNSYi7gJKbUb7y2hNvF9KXXyt8ShgJD8AoBhryGwAxp6ejw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 30 22:43:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKdAR-000077-9M
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 22:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab1J3Vng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 17:43:36 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:10483 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752276Ab1J3Vnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 17:43:35 -0400
Received: from bsmtp.bon.at (unknown [10.232.130.106])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 7BB6ACDF86
	for <git@vger.kernel.org>; Sun, 30 Oct 2011 22:43:42 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E87D910013;
	Sun, 30 Oct 2011 22:42:58 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 80FAC19F4AA;
	Sun, 30 Oct 2011 22:43:14 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <CABPQNSYi7gJKbUb7y2hNvF9KXXyt8ShgJD8AoBhryGwAxp6ejw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184478>

Am 29.10.2011 17:42, schrieb Erik Faye-Lund:
> On Fri, Oct 28, 2011 at 8:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * ef/mingw-upload-archive (2011-10-26) 3 commits
>>  - upload-archive: use start_command instead of fork
>>  - compat/win32/poll.c: upgrade from upstream
>>  - mingw: move poll out of sys-folder
>>
>> Are msysgit folks OK with this series (I didn't see msysgit list Cc'ed on
>> these patches)? If so let's move this forward, as the changes to the core
>> part seem solid.
> 
> The msysgit list not being Cc'ed on the patches was a slip-up on my
> behalf. I believe the changes are relatively uncontroversial from an
> msysgit point of view, though. However, an ack/nack would be
> appreciated ;)

The patch series looks good and passes my tests. Therefore:

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
