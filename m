From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 13/13] Fixup! doc: giteveryday and user-manual man
 format
Date: Sun, 24 Feb 2013 22:32:19 +0000
Message-ID: <512A94F3.9030607@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org> <1361660761-1932-14-git-send-email-philipoakley@iee.org> <20130224150140.GM1361@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:32:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9k7j-0006om-TE
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759492Ab3BXWcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:32:23 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:48575 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758190Ab3BXWcW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2013 17:32:22 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAM+QKlFZ8rke/2dsb2JhbAANOL52glqBJ4MSAQEBAQM4QAEQCxgJFg8JAwIBAgFFBg0BBwEBslKSLY5bMweDQAOqKQ
X-IronPort-AV: E=Sophos;i="4.84,730,1355097600"; 
   d="scan'208";a="566904382"
Received: from host-89-242-185-30.as13285.net (HELO [192.168.0.7]) ([89.242.185.30])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 24 Feb 2013 22:32:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130224150140.GM1361@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217012>

On 24/02/13 15:01, W. Trevor King wrote:
> On Sat, Feb 23, 2013 at 11:06:01PM +0000, Philip Oakley wrote:
>> diff --git a/Documentation/gituser-manual.txt b/Documentation/gituser-manual.txt
>> index a4778d7..e991b11 100644
>> --- a/Documentation/gituser-manual.txt
>> +++ b/Documentation/gituser-manual.txt
>> @@ -1,7 +1,12 @@
>>   Git User's Manual (for version 1.5.3 or newer)
>> -______________________________________________
>> +==============================================
>
> I'd be happy dropping the parenthetical bit here.  It's hard to
> imagine someone still running something earlier than 1.5.3.  It's even
> harder to imagine them installing a modern user manual man page for
> their old Git version ;).
>
Sensible. Will do.

Philip
