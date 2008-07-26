From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Sat, 26 Jul 2008 17:34:34 +0200
Message-ID: <200807261734.35239.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <20080723235359.GB12754@leksak.fem-net> <200807241152.29465.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 17:35:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMlo5-0001w0-VC
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYGZPem convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jul 2008 11:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbYGZPem
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:34:42 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:23687 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbYGZPel (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:34:41 -0400
Received: by ik-out-1112.google.com with SMTP id c28so3199464ika.5
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bhX/9jmkHhJoF6llcgolxyQXFRu/f+RPJYbCq6SYsRU=;
        b=w2QccRW3w+ppxA7Kwi3PTZS6WLueEpHpxgINfrk6C5aRDTKCbP3FNlHAgul5bvu3J3
         Sb/tgcNGOW2XL2ysoiKKkflhNzEE88hLsEHS2kWu04lXLE/3bIO0fihaj6UThfPzcaId
         yFMdEBKXzSzjmjrD6xLXc2Iu4Mkm5Vf45YedI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ez/8wDnYIaayRf9sggpg9IrNwKKywF31rMtzncZA4H4vYIlKcZRRTR7qp2V21T/PzI
         MYqiB8TEe08HtTX7N+yXEdQcyUHZ4oM2NDca4u8VSIYg9Zm/EhCjVB9snOQhKruonGUT
         mgfXrLSub0I1I2YgN12kS9twxoS2aRi9hG+NA=
Received: by 10.210.58.13 with SMTP id g13mr3475186eba.54.1217086479602;
        Sat, 26 Jul 2008 08:34:39 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.225.191])
        by mx.google.com with ESMTPS id z33sm17053620ikz.0.2008.07.26.08.34.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 08:34:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200807241152.29465.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90244>

On Thu, 24 July 2008, Jakub Nar=C4=99bski wrote:
> On Thu, 24 July 2008, Stephan Beyer wrote:
>> Jakub Narebski wrote:
>>> Dnia =C5=9Broda 23. lipca 2008 16:54, Robin Rosenberg napisa=C5=82
>>>> onsdagen den 23 juli 2008 15.18.40 skrev Johannes Schindelin:
>>>>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>>>>>> On Wed, 23 Jul 2008, Johannes Schindelin wrote:
>>>>>>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>>>>>>>=20
>>>>>>>>    04. Which programming languages you are proficient with?
>>>>>>>>        (The choices include programming languages used by git)
>>>>>>>>        (zero or more: multiple choice)
>>>>>>>>      - C, shell, Perl, Python, Tcl/Tk
>>>>>>>>      + (should we include other languages, like C++, Java, PHP=
,
>>>>>>>>         Ruby,...?)
>> [...]
> =20
> If we want to provide larger number of programming languages to
> chose from (with "other" as fallback), we could take for example
> top 10 from the TIOBE index, or similar sites:
>   http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html (f=
or July 2008)
>   http://lui.arbingersys.com/index.html (Language Usage Indicators, J=
ul 10, 2008)
>=20
> This would bring 'Visual Basic', and perhaps 'Assembly' and 'Lisp'
> to the list of choices.

Perhaps also consider GitHub's list of most popular languages
  http://github.com/blog/99-popular-languages
(as mentioned in Petr 'Pasky' Baudis somewhere in git-scm.com thread)
to take into account git popularity among web developers.

This would add 'ERB' (or is it just subset of 'Ruby' as eRuby
implementation?), and 'Common Lisp' (if 'Common Lisp', then
probably also 'Scheme'/'Guile').=20

There is always free-form 'other'...
--=20
Jakub Narebski
Poland
