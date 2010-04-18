From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Sun, 18 Apr 2010 02:46:16 +0200
Message-ID: <201004180246.18263.jnareb@gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Sam Vilain <sam@vilain.net>, catalyst@lists.scsys.co.uk
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 02:46:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Ieq-0000s5-5p
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 02:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980Ab0DRAq0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Apr 2010 20:46:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:31357 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393Ab0DRAqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 20:46:25 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1136694fga.1
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 17:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dMv0s3bIhWGa+xOEuTsUBYmpDfRm7iJ2G/oQeD3ajzg=;
        b=XnyTcnKGOSsfP6fXn/1I49j+PwgI/f78LpBzoxxXjZzOxLvRApdA6s3EDm8mSRE0hn
         kMzaa5EnGTOzS7ehKVKsBDihcdR76AaW+CCsoE19Qqm8Oyh1JZo8rHf027YN4Ar3HFQe
         7lF3BkwuRcJfCmBvtcOgrqrAPY3SpZHE9066Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bwkSDBn6fzSR2QBhQbodtKb+9Qgu1evkirNs+scloH+CC5mw8tHSdQtsR5wsiXH/D9
         VtVvZ57O3LIsyiBZr//ORjgiWPR5n3rswLPAiZNSfOBPMXCupyWsXobYHyIGkmaBzlVA
         A35+wu+vT+4dSZowdiRAPZofHRRkgsw8gIHjc=
Received: by 10.86.124.8 with SMTP id w8mr2727656fgc.8.1271551582819;
        Sat, 17 Apr 2010 17:46:22 -0700 (PDT)
Received: from [192.168.1.13] (abvc197.neoplus.adsl.tpnet.pl [83.8.200.197])
        by mx.google.com with ESMTPS id 3sm2561748fge.0.2010.04.17.17.46.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 17:46:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201004150630.44300.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145193>

Dnia czwartek 15. kwietnia 2010 06:30, Christian Couder napisa=B3:
> Hi!
>=20
> Pavan Kumar Sunkara sent an email on the git mailing list a few days =
ago about=20
> his GSoC proposal:
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/144658/

I would really prefer if Pavan just *wrote* the text of his "Integrated
Web Client for git" proposal for GSoC 2010 in email, instead of providi=
ng
link to it; link that requires signing-in.

  This proposal aims at creating a multi-purpose HTML based GUI client
  for git. This client intends in reducing the work needed to be done
  by a developer while working on a git repository. This is not another
  gitweb or gitorious but it also contains their functionalities as
  submodules.
=20
  The project goal is to try and implement a integrated multi-purpose
  HTML based GUI client for git. It contains two parts which are
  crucial while working on a git repository, Read and Write.

    * Read means browse through the code and repository
    * Write means working on the code and repository

  Also, in the future others will be able to develop more functionaliti=
es
  for this client with the help of the framework like structure of this
  project.

It is not entirely sure what this "Web Client" is meant to do.  Is it
mainly meant as web interface to managing repositories (webmin for git)=
,
something that GitHub, Gitorious, InDefero, Girocco all include?  This
could mean web interface to configuring gitosis / gitolite.  Or is it
meant as web analogue of git-gui: a committool, with ability to create
new commits, perhaps to edit files (and add them, delete them, move the=
m
around), a bit like ikiwiki with Git backend, or other Git based wikis
and blogs?  Or is it something else?

> His proposal is based on the project he already started:
>=20
> http://github.com/pkumar/gittor
>=20
> There have been discussions about it on the GSoC web app and in some =
private=20
> emails.
>=20
> Possible GSoC mentors for this proposal don't want yet another web in=
terface,=20
> they want an existing interface to be improved on. As the obvious cho=
ice is to=20
> improve gitweb, the current result from the discussions is that the p=
roposal=20
> should be changed so that the integrated web client is developed in P=
erl into=20
> or alongside gitweb.

It could be a waste to duplicate functionality that is already present
in gitweb, at least for GSoC (having yet another web interface for git,
this time in Python, could be a good thing... if the web interface woul=
d
be developed further).=20

As to integrating "Web Client for Git" with gitweb, there exists at lea=
st
a few possible ways to do this:

1. Keep "Web Client" separate for gitweb, and make use of gitweb=20
   hooks/plugin system like $feature{'actions'}.  This might require
   adding new "hooks" to gitweb.

   The advantage is that "Web Client" can be written in any language,
   not necessary Perl.  The disadvantage that if it is written in Perl,
   some code might be duplicated.  It might be hard to write generic
   hooks - the "Web Client" could be not as well integrated with gitweb=
=2E

2. Write "Web Client" as a Perl module, like 'gitweb/cache.pm' in the
   http://repo.or.cz/w/git/jnareb-git.git/log/refs/heads/gitweb/cache-k=
ernel-pu
   and 'require' this file as needed, guarded by global variable or
   %feature.

   The advantage is possible tighter integration.  I am not sure about
   being able to use code from gitweb in "Web Client".  It also require=
s
   using Perl, and might require using some contortions if the problem
   would be naturally split into multiple modules: there can be multipl=
e
   modules, but it could be better to have them in one file.

3. Split Gitweb, add "Web Client" as one of modules.  Might be best
   from the purity point of view, but is practical only if it is
   integrated in gitweb.  That would require getting gitweb maintainer
   out of GSoC.   Also I am not sure how feaible this approach would be=
=2E

>=20
> Pavan agreed to rewrite his proposal according to that and Petr and m=
yself=20
> volunteered to co-mentor him.
>=20
> It was suggested that improving Gitalist=20
> (http://wiki.catalystframework.org/wiki/gitalist) would be a better c=
hoice.=20
> But this was rejected because Gitalist is too much different from git=
web so it=20
> could not replace it for many people now using gitweb.

True, I don't think that e.g. git.kernel.org or repo.or.cz could instal=
l
Catalyst and Git::PurePerl and use Gitalist instead of gitweb...

P.S. If I remember correctly Gitalist was based out of last gitweb vers=
ion
     before it got bundled with git.  I wonder if they caught up to the
     modern gitweb features (snapshots, Atom/RSS feeds, basic submodule
     support, handling images, incremental blame, grep and pickaxe sear=
ch,
     etc.).

--=20
Jakub Narebski
Poland
