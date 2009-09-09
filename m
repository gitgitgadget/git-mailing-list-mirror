From: Wincent Colaiuta <win@wincent.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 00:06:04 +0200
Message-ID: <4C1FB36D-F8A6-4C01-A42A-8AD2355A9961@wincent.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 00:21:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlVX9-0003Ij-Tu
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 00:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbZIIWUu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2009 18:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbZIIWUu
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 18:20:50 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:43486 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbZIIWUt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2009 18:20:49 -0400
X-Greylist: delayed 882 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2009 18:20:49 EDT
Received: from [192.168.1.2] (231.Red-83-59-195.dynamicIP.rima-tde.net [83.59.195.231])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n89M647q021405
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 9 Sep 2009 18:06:06 -0400
In-Reply-To: <m3fxavvl5k.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.1075.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128088>

El 09/09/2009, a las 23:54, Jakub Narebski escribi=F3:

> Brendan Miller <catphive@catphive.net> writes:
>
>> 5. Most commands require lots of flags, and don't have reasonable
>> defaults. e.g. archive.
>>
>> git archive --format=3Dtar --prefix=3Dmyproject/ HEAD | gzip =20
>> >myproject.tar.gz
>>
>> Should just be:
>> git archive
>> run from the root of the repo.
>
> I'd rather not have "git archive" work without specifying tree-ish.

Why, out of interest? I would've thought that HEAD would be a pretty =20
good default, although I confess that I have never used "git archive" =20
without specifying a particular signed tag.

Cheers,
Wincent
