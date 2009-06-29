From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - trial run
Date: Tue, 30 Jun 2009 01:21:44 +0200
Message-ID: <200906300121.44903.jnareb@gmail.com>
References: <200906252122.51737.jnareb@gmail.com> <200906261744.04610.jnareb@gmail.com> <94a0d4530906261205o6e4195dub4e38e8dccbd9258@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 01:21:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLQAa-0005Y5-Dd
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 01:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759403AbZF2XVn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2009 19:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758185AbZF2XVm
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 19:21:42 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:55724 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756879AbZF2XVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 19:21:42 -0400
Received: by bwz9 with SMTP id 9so3578633bwz.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bqILlDr7EJ2FTClkkFl8cJX+sjDn7tM1M9c2Pj0oCbU=;
        b=xPjMf0En+RcaB8b6rP149xxgyWeCf2m24ISX4VX2Lz3XvbSI9cJr/dA0YwcZrKkuYX
         SRa9Kkp7yBCDH0jSlOQJLvU/PJUd5pczQXLjIZPJYzu04dsef36RYzmR82HFnTpWy5Vo
         2RU/Y7fhmI0QbQmV48KWuYMloqDkj1LNqlC5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CfOb2er6fTZGH+FeCFgzldAegvfOOUEUhRnPdkMtOWTIU16T66r1R497piNbMP1Kc/
         c0+73SH2HntZyFV5KMYJuPbXyS583WQYOQOioP/dfmK+NQJXEecDhB2l6ajr0zHK8jvH
         BgIiIweVsdUPU7g5gDn4HONTx0YA+Jq1fzrc4=
Received: by 10.103.167.14 with SMTP id u14mr4444698muo.81.1246317704154;
        Mon, 29 Jun 2009 16:21:44 -0700 (PDT)
Received: from ?192.168.1.13? (abwp215.neoplus.adsl.tpnet.pl [83.8.239.215])
        by mx.google.com with ESMTPS id t10sm20552981muh.30.2009.06.29.16.21.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 16:21:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <94a0d4530906261205o6e4195dub4e38e8dccbd9258@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122476>

On Fri, 26 Jun 2009, Felipe Contreras wrote:
> On Fri, Jun 26, 2009 at 6:44 PM, Jakub Narebski<jnareb@gmail.com> wro=
te:
>> On Fri, 26 June 2009, Felipe Contreras wrote:
>>> 2009/6/25 Jakub Narebski <jnareb@gmail.com>:

[...]
>> =C2=A0+8. How did/do you obtain Git?
>>
>> It is IMHO more interesting how people upgrade Git, than just how
>> they installed it.
>=20
> Sure, but it can be assumed from how it was installed:
>  * Some kind of package management (automatically updated)
>  * In other binary form (manually)
>  * From a source tarball (manually)
>  * From git.git repository (manually)

Hmmm... I'd have to think about it a bit.  On one hand side original=20
version has the advantage of being similar to questions in previous
surveys, making comparison easier.  On the other hand side it is more
interesting to ask about how people update git.

BTW. you list does not include my example: I download src.rpm and
rebuild (recompile) it, then install created packages.  So it is from
source form, but compiled and installed automatically.

>>> Also, I would like to see a list of areas users would like improvem=
ents:
>>> XX. In you opinion, which areas need improvement?
>>> =C2=A0* user-interface
>>> =C2=A0* documentation
>>> =C2=A0* performance
>>> =C2=A0* more features
>>> =C2=A0* other
>>>
>>> Is there a way for users to assign points? eg. user-interface: 2,
>>> documentation: 1, more features: 1
>>
>> We can always use 'matrix' form, with columns corresponding to impor=
tance
>> of a given area for improvement (1-3, or 1-5 numeric range). =C2=A0B=
ecause
>> asking user to order from most important to least important (one can
>> enforce this on Survs.com by requiring only one answer with given co=
lumn
>> selected) would be too difficult and confusing.
>=20
> I see, in that case I think a matrix form would do.

I would replace then question "21. How does Git compare to other SCM
tools you have used?" which is not good question, especially now that
we don't have the whole "Other SCMs" section with this one to keep
within self-imposed 30 questions limit.

Thanks again for taking your time to review and test=20
"Git User's Survey 2009"!

--=20
Jakub Narebski
Poland
