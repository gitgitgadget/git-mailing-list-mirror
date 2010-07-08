From: Jakub Narebski <jnareb@gmail.com>
Subject: Git Chronicles, updated?
Date: Thu, 8 Jul 2010 10:57:48 +0200
Message-ID: <201007081057.51946.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 10:58:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWmvt-0006co-J5
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 10:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab0GHI6H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 04:58:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50116 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab0GHI6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 04:58:06 -0400
Received: by fxm14 with SMTP id 14so244338fxm.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 01:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=NbyfofUxnpLKiA5ESe77bfWErGHrIX8sdUeY77bFC/4=;
        b=vZ6bQg5Cknxqma7fTd39kG43QbkE/mJeNmWswDaSFjADqsb25HqSt+Jf51qOjghmoR
         4XRSOrHhUgnNd/iWNa5eCha8YgOOLdaPVw2lWRT93hJ9GD/whJfTod4zrh8rQalO1hQo
         WYuMCvqrgRDFdySeFZA3KgYlwyZorToalSypE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=Hres93JYRwEcU8pcuaCDKbHTk751ha/N7VMaabx9odGRxOhCzNuRVscsQiNMJGr44M
         RcKd8PfB9RC8sUI7mR8/3CikYCDqxlehR9FYa4b/jW9cImciiTpkLRU9y8R01nUf56yP
         lvQ1krZnsQFbqiZYPBBgxz5rZiP4GBD2xy03Y=
Received: by 10.223.119.80 with SMTP id y16mr6777350faq.89.1278579481343;
        Thu, 08 Jul 2010 01:58:01 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id h14sm16508557faa.23.2010.07.08.01.58.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 01:58:00 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150550>

At "Git Together '08" Junio C Hamano has delivered "Git Chronicle,=20
Recent Additions to Git" talk[1].  What's more Junio posted slides
for this talk[2] at http://userweb.kernel.org/~junio/200810-Chron.pdf
so that people who were not present at Git Together could read it too.

Now that's Git Together '10 comes near, I wonder if it would be possibl=
e
to have updated "Git Chronicles".  It was two years of development ago.
Hopefuly Junio still has tools he used to generate data for this talk.


One of graphs shown was growth of git codebase and of git contributors.
Did git development stabilized during those two years since 2008, or
does it still reads as active rather than stable development?

Another interesting graphs was plot showing number of surviving lines=20
added in a give release relative to mumber of all lines added in said=20
release.  This was used to detect which releases were important ones.
Were there any releases between 2008 and 2010 of significant importance=
?

The slides for "Git Chronicles" from 2008 closed with timelines of git=20
features.  Were there any important user-visible features added since=20
2008 (notes, sparse checkout, "smart" HTTP)?


What might be also interesting is a descriotpion of how some important=20
feature came into being, with hint of an idea, discussions, prototypes,=
=20
failed starts, dropped patches, reworkings, accepted version and then
improvements.  If one is not watching git mailing list regularly for a=20
longer time, what one sees is the final product.  One doesn't know what=
=20
it might to take to get a large feature into git...


[1] https://git.wiki.kernel.org/index.php/GitTogether08
[2] http://gitster.livejournal.com/17411.html=20
[3] http://sourceforge.net/projects/ohcount/

--=20
Jakub Nar=C4=99bski
Poland
