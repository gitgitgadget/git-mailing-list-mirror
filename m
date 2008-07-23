From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 01:30:30 +0200
Message-ID: <200807240130.31649.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <alpine.DEB.1.00.0807231414480.8986@racer> <200807231654.18019.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:31:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLno5-0005ta-FH
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457AbYGWXam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 19:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754601AbYGWXal
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:30:41 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:29849 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbYGWXal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:30:41 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1881628ika.5
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FwU6h5pD+gljQ8+w0aUHYjCAtkeptO2qpBS6ATWF2QM=;
        b=ncQmj57tMEQ6KzUZ0Q1vuK0bwhE7TvFDTGi3nwG3C1MpA/l2gdH3ocHdJCPBGkDeZr
         GiPjgTijyk8RGcltI31q4urmH6asGPfapwTDPaP4qDIM+6FpbCzNAmRrNWbBXkohxE7v
         OZpSTsmqNVoQ+BJP4gNIL0GvtamArc1XNFkfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=azfiW7d0C43bZzQjg39F0zGaiIe1vPtComNPMKYc7oVGT2g4VUDtpjSkHjIx8eNcsR
         jcaPTcdAL/8grZmsBqf3kyQU3xjdRZSUfJNBnjvoIHOuttIFeEAkTT17VWps8qm1V9BP
         QE7S1lGB59rCpccIgWrdMfdlzdSW/d7j3n7kc=
Received: by 10.210.142.6 with SMTP id p6mr431988ebd.102.1216855839335;
        Wed, 23 Jul 2008 16:30:39 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.1])
        by mx.google.com with ESMTPS id 6sm26170431nfv.21.2008.07.23.16.30.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 16:30:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200807231654.18019.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89805>

Dnia =B6roda 23. lipca 2008 16:54, Robin Rosenberg napisa=B3:
> onsdagen den 23 juli 2008 15.18.40 skrev Johannes Schindelin:
>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>>> On Wed, 23 Jul 2008, Johannes Schindelin wrote:
>>>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>>>>=20
>>>>>    04. Which programming languages you are proficient with?
>>>>>        (The choices include programming languages used by git)
>>>>>        (zero or more: multiple choice)
>>>>>      - C, shell, Perl, Python, Tcl/Tk
>>>>>      + (should we include other languages, like C++, Java, PHP,
>>>>>         Ruby,...?)
>>>>=20
>>>> Yes, I think this should be a long list.
>>>=20
>>> I'd rather not have a "laundry list" of languages.  I have put C++
>>> because QGit uses it, Java because of egit/jgit, PHP for web
>>> interfaces, Ruby because of GitHub and because of Ruby comminity
>>> choosing Git.  I should perhaps add Emacs Lisp, HTML+CSS and
>>> JavaScript here.  What other languages should be considered?
>>=20
>> C# at least, since we had one (pretty unsuccessful) attempt at=20
>> reimplementing Git in it.
>=20
> What is the reason for the question? Do we want to know what language=
s
> people would like to contribute to Git in or do we want to know what =
"kind"
> of programmers are attracted by Git?  Making it a long list should ma=
ke
> it easier to tabulate the responses.

The idea is, I think, to know what languages people could contribute
to Git; see analysis of this question at GitSurvey2007 page on git wiki=
:
  http://git.or.cz/gitwiki/GitSurvey2007#head-ecb5564d71e4093e2e93e5083=
80407a26dbcbdea

C++ is for QGit, Java for egit/jgit, C# for git#/widgit and perhaps
Git-Cheetah, PHP for web interfaces, Ruby because of GitHub, Python
because some contrib is in Python, Emacs Lisp for git.el, HTML+CSS
and JavaScript for web interfaces; perhaps we should also add AsciiDoc
for documentation.  And of course "I am not programmer" response...

But I'm not too tied to this question; I guess it can be simply
removed if it doesn't offer some important (for us) information.

--=20
Jakub Narebski
Poland
