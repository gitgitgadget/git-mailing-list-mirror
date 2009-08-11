From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Change mentions of "git programs" to "git commands"
Date: Wed, 12 Aug 2009 07:59:46 +0900
Message-ID: <20090812075946.6117@nanako3.lavabit.com>
References: <4a7c3971.170d660a.3caa.20b3@mx.google.com>
	<20090811125813.6117@nanako3.lavabit.com>
	<4A815AAC.2030601@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Wed Aug 12 01:00:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0KT-0002cH-Sp
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbZHKXAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 19:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754418AbZHKXAU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:00:20 -0400
Received: from karen.lavabit.com ([72.249.41.33]:37600 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327AbZHKXAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 19:00:19 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 4F13A11B8F4;
	Tue, 11 Aug 2009 18:00:20 -0500 (CDT)
Received: from 1247.lavabit.com (221.204.253.154)
	by lavabit.com with ESMTP id 7SMB268FT8EE; Tue, 11 Aug 2009 18:00:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Atu8j47EOWNavSG1/BSKBlcJU9K8GlWq8bX4pCL3cnhuw/CEFfh9MpdCeAFqnysctkNBrku0tNfurYQifUi1wBPhjDtIyBElG30nOaZWpbBQl01C7Mjjp0Mnb7U9QwgK0a0rNrWvTygc7fTbYZA4ew+iiDqEQN97W7NyoqMS/zg=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4A815AAC.2030601@avtalion.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125614>

Quoting Ori Avtalion <ori@avtalion.name>

> On 08/11/2009 06:58 AM, Nanako Shiraishi wrote:
>> From: Ori Avtalion<ori@avtalion.name>
>> Date: Fri, 7 Aug 2009 17:24:21 +0300
>> Subject: [PATCH] Change mentions of "git programs" to "git commands"
>>
>> Most of the docs and printouts refer to "commands" when discussing what
>> the end users call via the "git" top-level program. We should refer them
>> as "git programs" when we discuss the fact that the commands are
>> implemented as separate programs, but in other contexts, it is better to
>> use the term "git commands" consistently.
>>
>> Signed-off-by: Ori Avtalion<ori@avtalion.name>
>> Signed-off-by: Nanako Shiraishi<nanako3@lavabit.com>
>> ---
>>
>
> Thanks Nanako!

You're welcome, and sorry if I sounded as if I was accusing that you were 
wasting other's time by not re-submitting sooner. I only wanted to see a 
good patch go in.

> You might want to consider this patch too:
>
> diff --git a/Documentation/git-mailsplit.txt
> b/Documentation/git-mailsplit.txt
> index 5cc94ec..8f1b99b 100644
> --- a/Documentation/git-mailsplit.txt
> +++ b/Documentation/git-mailsplit.txt
> @@ -3,7 +3,7 @@ git-mailsplit(1)
>
>  NAME
>  ----
> -git-mailsplit - Simple UNIX mbox splitter program
> +git-mailsplit - Simple UNIX mbox splitter
>
>  SYNOPSIS
>  --------

Sorry, but I don't understand why it is necessary.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
