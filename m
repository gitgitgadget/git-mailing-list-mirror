From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 12:44:17 +0200
Message-ID: <200807241244.18034.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <200807231654.18019.robin.rosenberg.lists@dewire.com> <alpine.DEB.1.00.0807231659210.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 12:45:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLyKC-0006Ag-Q9
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 12:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbYGXKob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 06:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbYGXKob
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 06:44:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:10829 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbYGXKo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 06:44:29 -0400
Received: by ug-out-1314.google.com with SMTP id h2so580102ugf.16
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WD3e1r5xqJ4EhEIqSB9jBzlHHpjQM4L53F3BZGlcy/s=;
        b=h7vTY8iri2IcKObygEFsdY0tuTlTbpGhJy/rg+M3ckC5Eop/OnrIsKKXN1e19YEEwm
         kRxul40pwjC7PozkyvJvJKWuhGt5KaPo8UJre/kqBwbCS1S2Ln/lCeUNWk9njFDcTOJZ
         TdKUYnx+Xa86zQ0wJwa2+rPHaeBHHMLpeJMgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=M8Z+UjVbf7dGIAh4jZMrQQjNm+Fcr6ctrQAblCBDSn8fD5NcrPgGKZfX1ENvUMUus3
         s9opkvaadkNCu/asPUCILsQ1N3//ivauCHQGWYaNcwIHulZXKotlqKH2vYQNC+9yVIrf
         PKZIMvwxuxSutELK0Jp8YRAxgxtqhgMNbVGbg=
Received: by 10.67.116.19 with SMTP id t19mr788498ugm.56.1216896267584;
        Thu, 24 Jul 2008 03:44:27 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.47])
        by mx.google.com with ESMTPS id e23sm12351253ugd.47.2008.07.24.03.44.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 03:44:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0807231659210.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89863>

Dnia =C5=9Broda 23. lipca 2008 18:00, Johannes Schindelin napisa=C5=82:
> On Wed, 23 Jul 2008, Robin Rosenberg wrote:
>> onsdagen den 23 juli 2008 15.18.40 skrev Johannes Schindelin:
>>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>>>> On Wed, 23 Jul 2008, Johannes Schindelin wrote:
>>>>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>>>>>=20
>>>>> Some people prefer to stay anonymous, so I think email is out.
>>>>>=20
>>>>>>    04. Which programming languages you are proficient with?
>>>>>>        (The choices include programming languages used by git)
>>>>>>        (zero or more: multiple choice)
>>>>>>      - C, shell, Perl, Python, Tcl/Tk
>>>>>>      + (should we include other languages, like C++, Java, PHP,
>>>>>>         Ruby,...?)
>>>>>=20
>>>>> Yes, I think this should be a long list.
>>>>=20
>>>> I'd rather not have a "laundry list" of languages.  I have put C++=
=20
>>>> because QGit uses it, Java because of egit/jgit, PHP for web=20
>>>> interfaces, Ruby because of GitHub and because of Ruby comminity=20
>>>> choosing Git.  I should perhaps add Emacs Lisp, HTML+CSS and=20
>>>> JavaScript here.  What other languages should be considered?
>>>=20
>>> C# at least, since we had one (pretty unsuccessful) attempt at=20
>>> reimplementing Git in it.
>>=20
>> What is the reason for the question? Do we want to know what languag=
es
>> people would like to contribute to Git in or do we want to know what=
 "kind"
>> of programmers are attracted by Git?  Making it a long list should m=
ake
>> it easier to tabulate the responses.
>=20
> "could contribute" is more appropriate IMHO.  Although you might be r=
ight=20
> to ask "would like to contribute"... ;-)

I think it is both.  We would like to know what kind of programmers
(and non-programmers) are attracted to Git, and also what languages
could people contribute to Git.

--=20
Jakub Narebski
Poland
