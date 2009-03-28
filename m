From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git svn fails to work
Date: Sat, 28 Mar 2009 23:51:57 +0300
Message-ID: <37fcd2780903281351w6f77a647kd44a9afe4d2ee953@mail.gmail.com>
References: <EA1460555FA0423EB6C233B3B0F4F098@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 21:53:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnfX4-0003xp-Nq
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 21:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbZC1UwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 16:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbZC1UwB
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 16:52:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:27657 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbZC1UwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 16:52:00 -0400
Received: by fg-out-1718.google.com with SMTP id 16so131434fgg.17
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NbyCS3Y3HFTE99gVAYKltemstgmXsY4eDSrmGfe3Lwg=;
        b=Jre8uUnakjwB6UlkqDbNtvdevAbIjOsAcrvHnI8KMyI7lsc/ChlTM81uKPN4Bnzmi9
         f2mZStLuZgEvxhzJLioWvienYhdsWy62gPmXCWOloY6D4wItj1fJzRJDDTXexg7+j6MV
         c3MaN4Hd/ygDolP8I7hIj7NgA8h2TypM3KgBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hTRFm+EG468fDm3bRvnrawNkd0kpGiA844vcJSCZGjj5W01BNPZ/uDCoucoyeGTMaF
         llc2XZ1NV0/1Kg3tF4O+GPzsYZdoOfHH4yQxeZiWKciW/EuI+cXgQlRQG0N3nSER2zUV
         t4cOZ1TnENTZA7ZDlSN1ENoLc4qV0Ao3G5hXk=
Received: by 10.86.4.14 with SMTP id 14mr3104193fgd.8.1238273517767; Sat, 28 
	Mar 2009 13:51:57 -0700 (PDT)
In-Reply-To: <EA1460555FA0423EB6C233B3B0F4F098@HPLAPTOP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114976>

On Sat, Mar 28, 2009 at 8:48 PM, Aaron Gray
<aaronngray.lists@googlemail.com> wrote:
> I have been tying for a week to get git svn to work. If i do a 'git clone'
> and if falls over 'git svn fetch' picks up from where it left off, but on
> completion I can only see the older stuff if at all and a 'git clone rebase'
> eithr shoud up unreconsilable differences or refuses to execute the command
> at all, gust giving uphelpfull help afaics.

I am afraid if you expect anyone to help you with you, you have to spend
a little more time to describe your problem. You have not mentioned what
version of Git you use, what operating system, what is layout of your SVN
repo, what commands and with what options you used and what was their
output. Without that information no one will be able to help you...

> Otherwise I am giving up and either going back to svn or over to mercurial.

Yeah, right... These kind of threats will make people who want to help to
come running....


Dmitry
