From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mailing lists, was Re: [RFC] Git User's Survey 2008
Date: Fri, 25 Jul 2008 23:52:08 +0200
Message-ID: <200807252352.09751.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <20080725172313.GE21117@spearce.org> <7vr69hsss1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:53:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMVDz-0002PW-QP
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbYGYVwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 17:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbYGYVwU
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:52:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:63310 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbYGYVwT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 17:52:19 -0400
Received: by ug-out-1314.google.com with SMTP id h2so34280ugf.16
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=f6MeSCViERd4udTAsnd4uX8wZp4qvxxl9NHJn8q1Y/I=;
        b=eq085udcD3Nad10sLPCd2WM6+s0CU+j4Mv1dGZD7AqzZ8rtMjsxOqZM50kAZDBmAiO
         Vr2+Vna37ATH193zayEdUw19lYbHx47G0OjUTCWuo3nxX66h3VCd6JsCdYF7nNN/2y+m
         WCb3MFSuUsOiLXTQAracRAISYiR02c0S21RCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FFxsyoeSwa19JDpoPI4whJyprsZxfOH1zzfNfwDs0FgSFysXW65061PLUBbTidQING
         /aL7qjMC7VGgILOjs97eWTZ+Oqkzoqylxc7ESzFM2duAwoGs+mkbYOodZFSfV3IFIWy0
         Q0UJqtGnDZXewwZZ6wqEv3LFvTfHquXwELj2U=
Received: by 10.67.102.6 with SMTP id e6mr315411ugm.82.1217022737669;
        Fri, 25 Jul 2008 14:52:17 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.225.191])
        by mx.google.com with ESMTPS id 19sm1506142ugl.66.2008.07.25.14.52.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Jul 2008 14:52:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr69hsss1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90125>

On Fri, 25 Jul 2008, Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>> On Thu, 24 Jul 2008, Marek Zawirski wrote:
>>>> Junio C Hamano wrote:
>>> 
>>>>> I am not sure how and where, but I think j/egit should also be 
>>>>> mentioned and/or asked about.
>>>>
>>>> There is no separate mailing list for j/egit, we just used private mails 
>>>> for some discussions/less important notifications.

[cut]

> 
> Sorry for causing confusion in the discussion, but I was not talking about
> "mailing list on e/jgit".
> 
> What I meant was that we might want to have a few more questions about
> e/jgit as an independent entity in the survey, as it is a completely
> different re-implementation of the same git theme.

There are two questions about egit/jgit planned for the survey:

   16. Which porcelains / interfaces / implementations do you use?
       (zero or more: multiple choice)
     - core-git, Cogito (deprecated), StGIT, Guilt, pg (deprecated),
       Pyrite, Easy Git, IsiSetup, _jgit_, my own scripts, other(*)

   27. Which of the following features do you use?
       (zero or more: multiple choice)
     - Integration with IDE/editor (Eclipse, Emacs, TextMate,...)
       ...

What question about egit/jgit would you like to have in the survey?

-- 
Jakub Narebski
Poland
