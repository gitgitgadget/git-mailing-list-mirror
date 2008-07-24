From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 11:52:28 +0200
Message-ID: <200807241152.29465.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <200807240130.31649.jnareb@gmail.com> <20080723235359.GB12754@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jul 24 11:54:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLxWJ-0006xW-R2
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 11:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbYGXJwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 05:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbYGXJwv
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 05:52:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:17497 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbYGXJwu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 05:52:50 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1038170nfc.21
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6/oGglxpihQ+X2q62cceGvvioSB8YULB4T2BaMChkcA=;
        b=PWMWYQXeXR3/YMAZJv3uCEyuFEt3lqrKuGrLMBs+GJMtcuiqgdbnWot/MuOowpeTyS
         KOXa4BifyRHJ3HSS0SjrzySA/kUvTj240s6fp9clFEivbghts1CNNpDXQ9XvM2t1pLP6
         8vMd74MmXURXQp+DaCTI0gzSe3I2wLhdj7WTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=F/Q/wsR1+rkGShEha5vHboQ/rH+xMVuezaDzKeHjRUmQnOX7Rgq6Mwrj/E/aK0ZRnU
         hSlR1nja+CChvNJUma6hwZziJrGEzqG3jyEfm+gWSpUm3ZtjS9HIrVfLIcC7qu2tDv7o
         4pNZzmnymJc8UhU5BWDME18kqiMcZv2zDsqjs=
Received: by 10.210.52.9 with SMTP id z9mr104785ebz.12.1216893167172;
        Thu, 24 Jul 2008 02:52:47 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.47])
        by mx.google.com with ESMTPS id c4sm22619395nfi.13.2008.07.24.02.52.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 02:52:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080723235359.GB12754@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89859>

On Tue, 24 July 2008, Stephan Beyer wrote:
> Jakub Narebski wrote:
>> Dnia =C5=9Broda 23. lipca 2008 16:54, Robin Rosenberg napisa=C5=82
>>> onsdagen den 23 juli 2008 15.18.40 skrev Johannes Schindelin:
>>>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>>>>> On Wed, 23 Jul 2008, Johannes Schindelin wrote:
>>>>>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>>>>>>=20
>>>>>>>    04. Which programming languages you are proficient with?
>>>>>>>        (The choices include programming languages used by git)
>>>>>>>        (zero or more: multiple choice)
>>>>>>>      - C, shell, Perl, Python, Tcl/Tk
>>>>>>>      + (should we include other languages, like C++, Java, PHP,
>>>>>>>         Ruby,...?)
> [...]
>>=20
>> The idea is, I think, to know what languages people could contribute
>> to Git; see analysis of this question at GitSurvey2007 page on git w=
iki:
>>   http://git.or.cz/gitwiki/GitSurvey2007#head-ecb5564d71e4093e2e93e5=
08380407a26dbcbdea
>=20
> Oha, is this a Git User's Survey or a Git Potential Contributor's Sur=
vey?
> I thought this is some kind of demographic question about the "progra=
mming
> background" of the user.

Well, truth to be told it is both.  We try here to kill two birds with
one stone: both to have 'programming background' of Git users, and get
to know which parts of code can have many contributors, and which
could have troubles attracting contributors because of the language
they are written in (which is visible in the choice of programming
languages in 2007 survey).
=20
If we want to provide larger number of programming languages to
chose from (with "other" as fallback), we could take for example
top 10 from the TIOBE index, or similar sites:
  http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html (for=
 July 2008)
  http://lui.arbingersys.com/index.html (Language Usage Indicators, Jul=
 10, 2008)

This would bring 'Visual Basic', and perhaps 'Assembly' and 'Lisp'
to the list of choices.

>> And of course "I am not programmer" response...
>=20
> This doesn't make sense, does it?
>
> I know that there are non-programmer's who use git for there
> configuration files and other non-programming track files, but
> this looks somehow wrong in this survey.

You can manage documents and like (especially written in some
formatting language), you can manage web pages, you can also
use git to only _track_ some projects even if you are not
a programmer yourself.

See for example
  http://www.kieranhealy.org/blog/archives/2008/06/29/git-bibs/
  http://journal.code4lib.org/articles/86
  http://www.scienceforums.net/forum/showthread.php?t=3D33830
  http://www.secomputing.co.uk/2008/06/engineering-log-book.html

--=20
Jakub Narebski
Poland
