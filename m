From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: ANNOUNCE: Git Forum
Date: Tue, 08 Apr 2008 15:55:23 -0700 (PDT)
Message-ID: <m34pact0ru.fsf@localhost.localdomain>
References: <60646ee10804081451i4e6aa23ek44280e5d367d8814@mail.gmail.com>
	<20080408222501.GV11574@genesis.frugalware.org>
	<46a038f90804081536h7a19803apb401ed60593d9802@mail.gmail.com>
	<60646ee10804081545k6031578dxbae4c644fb7d2833@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dill <sarpulhu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 00:56:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjMjl-0003Fy-8X
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 00:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbYDHWzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 18:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbYDHWzb
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 18:55:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:36836 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYDHWz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 18:55:28 -0400
Received: by ug-out-1314.google.com with SMTP id z38so905108ugc.16
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=l+2M2mvwMIxoLOYWymtbiovcH/DkMT+g9zvd4/pyrDo=;
        b=OSvZvblXAmiIh7Ahc/0enrzTms3pc3TXsvK1x2Al2GDaFgmdyXWjbfcWBCFD02WAS9ApQGYLvcSuZ9x7+9w0C1rF4dcAsETCAW/VzFvLsof+M4C8KcHtZHF9elx58B8g3C/ul0uO/sV7+Z32dBmbK9Odz8hwtNa6bdcbQ+Ayhl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=lPRKf4RsxTZnAYLX+w+t5R6QQPxSe8mGC0xilsiARlgN1agkUZrXzJ9ju0k+9JlKQxlY3gkg7ZgTmgpWRvm5XhOC0TKA/x0J07HDKI3Kt8dr8DItisAf3IH0l/nJJKLj1bzL4eIKNFk7btvTmfmFKjD1ApE0VnHSNITc+QyF1QQ=
Received: by 10.67.116.4 with SMTP id t4mr3658651ugm.68.1207695326483;
        Tue, 08 Apr 2008 15:55:26 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.252.83])
        by mx.google.com with ESMTPS id 25sm3295109ugn.23.2008.04.08.15.55.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Apr 2008 15:55:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m38MtSsv018142;
	Wed, 9 Apr 2008 00:55:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m38MtHdB018138;
	Wed, 9 Apr 2008 00:55:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <60646ee10804081545k6031578dxbae4c644fb7d2833@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79047>

Dill <sarpulhu@gmail.com> writes:

> On Tue, Apr 8, 2008 at 4:36 PM, Martin Langhoff
> <martin.langhoff@gmail.com> wrote:
>> On Tue, Apr 8, 2008 at 7:25 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
>>> On Tue, Apr 08, 2008 at 03:51:59PM -0600, Dill <sarpulhu@gmail.com> wrote:
>>>>
>>>> I think a lot of users not only look at mailing lists but also seek
>>>> out forums for help.
>>>
>>> i never understood why this is good. maybe because there are no ads on
>>> this mailing list?
>>>
>>> yes, there are users who can't use a mail client so they use forums, but
>>> how one expects a user to learn git when he/she is not able to use a
>>> mail client? :)
>>
>>  Specially with gmane and their ilk, which provide forum-like views,
>>  including ads ;-)
>>
>>  One thing we have had discussions about in the past is that we don't
>>  want to split users from developers. Developers are here, so let's
>>  make sure users are guided here too. The approach of not splitting
>>  user/dev lists is a very good one - even if controversial at times.
>>
>>  Make sure you read up on earlier discussions on a "git-users" list -
>>  most of the considerations that apply against it also apply against a
>>  forum.
> 
> I have but as git grows more popular so will the users who wish to
> create communities that can help each other. IMHO this list will
> probably tend to be about development and bugs etc while other sites
> will sprout up geared more towards users. Could be wrong though.

First, Git is and I think would be mainly developers tool.  Developers
should know how to use mailing list, either using mail client
(subscribing or not) or news reader (via GMane NNTP interface).

Second, there are many ways to read git mailing list (various mailing
list archives, NNTP interface, IIRC also RSS interface).

Third, we have #git channel on FreeNode for quick response (if
possible), we have Git Homepage (and maintainer welcomes patches; the
git homepage itself is maintained using git), we have Git Wiki where
one can find and put information (contribute!)...

Do we really need web forum?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
