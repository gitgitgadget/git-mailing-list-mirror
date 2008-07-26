From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mailing lists, was Re: [RFC] Git User's Survey 2008
Date: Sat, 26 Jul 2008 12:54:52 +0200
Message-ID: <200807261254.53939.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <7vabg5r4vy.fsf@gitster.siamese.dyndns.org> <20080725221331.GE23202@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 12:56:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMhRU-0003Vk-No
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 12:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbYGZKzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 06:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbYGZKzD
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 06:55:03 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:58131 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYGZKzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 06:55:00 -0400
Received: by ik-out-1112.google.com with SMTP id c28so3113348ika.5
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 03:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=v7tNrjQBh6aNCsMLVMD17yhNZsg0d3rMnfd4P/cBMnk=;
        b=qGHrBNc6ivO4oAIzBH4PqPSgzFkV+1uwucQcnYiJYuFGyBodHFJFfLbGGc4zBnNpzN
         ZTgvKQnGySIi2cD3andV/VN30KMok7OLDCeRVT645Mk00PcpQvHKDZcRuyDDzApBtBvt
         qa61GftNJytgV538jYFuK43Zs1p1eY2OYUkUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=L19p27X8gd5yWDnFeAZB05JtmyjynZsSpbE5hDpic8MQHuWdVkqy0uycGYBRKZxl7L
         sxm2cQyhYzkH6soxVz08ef2RnDGbLFcRDDOeuXqQCe1yrxQXJ5qv6a9RJcrNqxuFzLyz
         ISivC2NcH8v8DHjH1+M4zlZthxHihCt1ftByc=
Received: by 10.210.91.17 with SMTP id o17mr3163104ebb.172.1217069698363;
        Sat, 26 Jul 2008 03:54:58 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.225.191])
        by mx.google.com with ESMTPS id b36sm8019279ika.5.2008.07.26.03.54.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 03:54:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080725221331.GE23202@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90205>

On Sat, 26 July 2008, Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>>> Jakub Narebski <jnareb@gmail.com> wrote:
>>>
>>>>    27. Which of the following features do you use?
>>>>        (zero or more: multiple choice)
>>>>      - Integration with IDE/editor (Eclipse, Emacs, TextMate,...)
>>>>        ...
>>>> 
>>>> What question about egit/jgit would you like to have in the survey?
>>>
>>> I'm not certain what else I would want to ask that is egit/jgit
>>> specific.
>> 
>> If you do not have any specific questions you would want to see answers
>> to, then my point was moot, which is fine.
> 
> Actually I'd like the editor integration to be broken out (if
> it isn't already) so we can see which editors (and thus which
> integrations) are popular among users.  I think it would help all
> of the integration authors, as well as make it clear to end-users
> where we have integration available/under development, in case they
> were not aware of it previously.

So you would like to see something like the following question in the
upcoming Git User's Survey?

   xx. Which editors/IDEs/RADs do you use?
       (zero or more; multiple choice with 'other')
    -  Emacs, Vim, Eclipse, KDevelop, Anjuta, TextMate, Notepad++,
       Visual Studio, other
    +  what choices should be in the list of editors and IDE;
       or should perhaps this question be free-form?

-- 
Jakub Narebski
Poland
