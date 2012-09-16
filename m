From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 7/8] Doc clean: add See Also links
Date: Sun, 16 Sep 2012 21:02:15 +0100
Message-ID: <50563047.5040103@iee.org>
References: <1347793083-4136-8-git-send-email-philipoakley@iee.org> <vpqsjaiyxth.fsf@grenoble-inp.fr> <5056269F.3070708@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitList <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 16 22:02:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDL3C-0004lu-H4
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 22:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab2IPUCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 16:02:34 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:47873 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752064Ab2IPUCd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2012 16:02:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAPIvVlBZ8rU+/2dsb2JhbAANOL85AQEBAQM4QAEQCxgJFg8JAwIBAgFFBg0BBQIBAa54kl+SCQOoag
X-IronPort-AV: E=Sophos;i="4.80,431,1344207600"; 
   d="scan'208";a="403505322"
Received: from host-89-242-181-62.as13285.net (HELO [192.168.0.9]) ([89.242.181.62])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 16 Sep 2012 21:02:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <5056269F.3070708@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205637>

On 16/09/12 20:21, Philip Oakley wrote:
> On 16/09/12 13:08, Matthieu Moy wrote:
>> Philip Oakley <philipoakley@iee.org> writes:
>>
>>> --- a/Documentation/git-clean.txt
>>> +++ b/Documentation/git-clean.txt
>>> @@ -63,6 +63,12 @@ OPTIONS
>>>       Remove only files ignored by git.  This may be useful to rebuild
>>>       everything from scratch, but keep manually created files.
>>>   +SEE ALSO
>>> +--------
>>> +linkgit:gitignore[5]
>>> +linkgit:gitrepository-layout[5]
>>> +The optional configuration variable `core.excludesfile`
>>> linkgit:git-config[1]
>> I think linkgit:gitignore[5] is enough. <snip>
>
> In fact I've lost a patch (a mistaken rebase todo list possibly) to
> make the three git ignore pattern types more obvious in the
> documentation, which would probably cover your point.
False alarm. It was patch 5/8, with the spelling mistake. sorry.
