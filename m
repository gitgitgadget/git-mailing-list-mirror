From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: SoC git projects announced
Date: Sat, 14 Apr 2007 02:03:51 +0200
Message-ID: <200704140203.52385.jnareb@gmail.com>
References: <200704120845.56793.andyparkins@gmail.com> <evostf$6ab$1@sea.gmane.org> <20070413221927.GB944@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 02:00:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcVgg-0000sf-GD
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 02:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbXDNAAO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 20:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030902AbXDNAAO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 20:00:14 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:23302 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030903AbXDNAAM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 20:00:12 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1091221muf
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 17:00:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nV0BrDRJl698H8QQ3XIkckojXVVxDt5JFLkvtO5UWBZnAqwvJiLRKHg4RDpRZ11lAFniwEMCj1YHg5lHt3WrdqjeEK5Ldq8fSZ+ihLfv1Cni9sG9x/a6CUNO4c09VY7X/7lG434JF6MbtCb8PXVJoGP1THtOdsyjel2DIfAYgtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UHnpjvV/BJuKGrC9kuIgWkug7tTVydn7MzMPXLKpWO0HeQF6y+18mLyLkVhs95PRLUoYzzI4imselJ7T64NrdQMRgSZOGX+Ea/XitlFNp4JToQjBfKv5f0rWnRj5wd9PQNVio0+d+59leIycfw5mq8+m3kijcxU+IzMCB+F4QDE=
Received: by 10.82.102.4 with SMTP id z4mr5037383bub.1176508811228;
        Fri, 13 Apr 2007 17:00:11 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id u9sm1626201muf.2007.04.13.17.00.09;
        Fri, 13 Apr 2007 17:00:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070413221927.GB944@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44440>

Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> Could you tell us which projects were applied to (and if there were more
>> than one application per project, how many applicants there were), and
>> which ones of that were good?
> 
> Sure.  The other projects were (and in no particular order except
> the way my brain functions on Fridays):

> - Managed C# implementation of Git for Mono: 1 project.  This student
>   actually submitted this project also to Mono, and Mono actually did
>   pick it up (with Miguel as the mentor).  Since Mono got more spots
>   than we did, and accepted him, I'm happy we didn't accept him.  :-)
> 
>   I've actually gotten in touch with this student, and with Miguel,
>   and offered up what co-mentoring assistance we can provide,
>   since the student is reimplementing Git in C#...

> - EGit enhancements: 1 project submitted.  I wanted to accept this
>   project too, but throw new google.NotEnoughSlotsException().


It's bit a pity that EGit projects was not accpeted as Eclipse project
(perhaps it was not submitted also to Eclipse; but IIRC Eclipse had 
better Git integration as a project).

I have put preliminary version of http://git.or.cz/gitwiki/SoC2007Projects
If I remember correctly one of the requirements was publishing a git
repository, perhaps using repo.or.cz...

-- 
Jakub Narebski
Poland
