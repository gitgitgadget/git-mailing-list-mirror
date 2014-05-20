From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH] RelNotes/2.0.0.txt: Fix several grammar issues, notably
 a lack of hyphens, double quotes, or articles
Date: Tue, 20 May 2014 00:14:17 -0400
Message-ID: <537AD699.8070503@bbn.com>
References: <1400297434-30254-1-git-send-email-jstjohn@purdue.edu> <xmqq1tvpuyas.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Tue May 20 10:25:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmbRb-0006fz-9v
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 06:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbaETEOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 00:14:22 -0400
Received: from smtp.bbn.com ([128.33.1.81]:55633 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbaETEOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 00:14:21 -0400
Received: from socket.bbn.com ([192.1.120.102]:57713)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WmbRd-000H40-Sn; Tue, 20 May 2014 00:14:30 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 7A886401DD
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqq1tvpuyas.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249651>

On 2014-05-19 19:46, Junio C Hamano wrote:
> "Jason St. John" <jstjohn@purdue.edu> writes:
>> @@ -53,7 +53,7 @@ Updates since v1.9 series
>>  UI, Workflows & Features
>>  
>>   * The "multi-mail" post-receive hook (in contrib/) has been updated
>> -   to a more recent version from the upstream.
>> +   to a more recent version from upstream.
> 
> Hmph, I have only one multi-mail upstream; shouldn't I call it "the"
> upstream from my point of view?

Plain "upstream" (without "the") is correct because it's an adverb, not
a noun.  (Alternatively, this could be written "from the upstream
repository" or "from the upstream project".)

>> @@ -217,7 +218,7 @@ notes for details).
>>   * "git diff --no-index -Mq a b" fell into an infinite loop.
>>     (merge ad1c3fb jc/fix-diff-no-index-diff-opt-parse later to maint).
>>  
>> - * "git fetch --prune", when the right-hand-side of multiple fetch
>> + * "git fetch --prune", when the right-hand side of multiple fetch
>>     refspecs overlap (e.g. storing "refs/heads/*" to
> 
> Hmph, I read this as a "right-hand", a multi-word adjective, is used
> to describe one "side" (the other side being the "left-hand side").
> Otherwise, you would be writing command-line-option, no?

Are you reading the diff backwards?  (The second hyphen is being
removed, not added.)

-Richard
