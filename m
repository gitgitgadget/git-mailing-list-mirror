From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: The linkgit: Asciidoc macro broken (for some backends)?
Date: Thu, 4 Nov 2010 17:23:18 -0500
Message-ID: <20101104222159.GB18475@burratino>
References: <87wrosg2ox.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 23:28:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE8I0-0006np-Gd
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab0KDWXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 18:23:42 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49437 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab0KDWXl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 18:23:41 -0400
Received: by qyk10 with SMTP id 10so1908995qyk.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=v6AIuGysY2XPh5iRtRld0OrqbF3KNh+32H4pQUMcvcg=;
        b=KYg+25v1+h4StsjJY1a5jDk76PFDb56zOOTrCY61l/IjSrqcNfhRJkdNsDTXdHNSuR
         UkInuBlqrw7vwlvHNdBvicXkNJPTcDtiNk9U/tHp9XFUivqqKdF2UkBUimvZX8Gf72EA
         rw1OZK5CwUXPfsAHBMmiZu29DU2DKaKFFw62o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lSS8tSMR0p88Kc65UyFrMnOM+4uha+LYlZ/M5N13X9o3bv7J8K7iZo9cIrD7TgrYRw
         TxkznLRBnhMmNVS82/5fJFGK+qlSDMU6sfNPpeZSLJt5jxQ9j6lqXczvdge8oLxKh36M
         6oU5Js3HrIR51WjzgXRvFZns2rVTvwa+KGEpQ=
Received: by 10.229.104.204 with SMTP id q12mr1164384qco.228.1288909420588;
        Thu, 04 Nov 2010 15:23:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm480929qcb.15.2010.11.04.15.23.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 15:23:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87wrosg2ox.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160785>

Hi =C5=A0t=C4=9Bp=C3=A1n,

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:

> I noticed that even though all the links to gitrevisions(7) in the
> documentation sources point correctly to manual section 7 (where it
> belongs and is actually installed), the links are rendered in manpage=
s
> as gitrevisions(1)

Probably your copy of the reference manual precedes v1.7.3.2~12 (Docume=
ntation:
gitrevisions is in section 7, 2010-10-11).

Hope that helps,
Jonathan
