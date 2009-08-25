From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: What IDEs are you using to develop git?
Date: Tue, 25 Aug 2009 15:56:06 +0300
Message-ID: <4A93DF66.4080902@panasas.com>
References: <000001ca257d$b60326c0$22097440$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?RnJhbmsgTcO8bm5pY2g=?= <git@frank-muennich.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 14:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfvZV-0005K3-Ju
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 14:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbZHYM4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2009 08:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZHYM4K
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 08:56:10 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:58610 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbZHYM4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 08:56:09 -0400
Received: by bwz19 with SMTP id 19so2047787bwz.37
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=3rpquBaQUN0NsUPqS9gNhpRPy5UpSGkC2zZq12ooGE4=;
        b=ism+kYNnvyVUKrLwuwyK1WjbQm20PemBqWMZb1J6F5lcxxOwWJ+2bBcJZySenxwX4i
         2mRaUj25V7v14q9vu3Xhkdzen75NIXdPFlLOi+H6/iq9Uer+9iTQYbXn7U9L1ivXKnr/
         I6Q1zOiAgik0vQRopb4AtSgTsv/gQx0KskJ7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=j85GlNYxm15Nz/nKmw+jjIiv2TuTcaHZmCBM1tz6yQEblepUr+JTidR+JNgB+v3Q7r
         Ansi1kXc+mqnuRMS0yNhB9dKWcrJv1vs06dXlDt5Itbpllnw7LFt4lE29Gq2SS/FqbG1
         OyKGyZxIVA2u8bZgvSOb2NFMVfGuofEccsYu8=
Received: by 10.103.81.35 with SMTP id i35mr2682066mul.43.1251204970077;
        Tue, 25 Aug 2009 05:56:10 -0700 (PDT)
Received: from bh-buildlin2.bhalevy.com (bzq-79-178-111-90.red.bezeqint.net [79.178.111.90])
        by mx.google.com with ESMTPS id u9sm1375865muf.37.2009.08.25.05.56.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Aug 2009 05:56:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090722 Remi/fc10 Thunderbird/3.0b3
In-Reply-To: <000001ca257d$b60326c0$22097440$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127022>

On 08/25/2009 03:15 PM, Frank M=C3=BCnnich wrote:
> Hi there,
>=20
> I am interested in helping out and improving git, though I haven't
> programmed in C for quite a while now and thus have to relearn quite =
some
> things.=20
> I understand the different branches (master, next, pu) and so on, and=
 were
> successful in compiling git with my Ubuntu 9.04. [yeea] ;)
>=20
> One thing I would like to ask you: what, if any, IDEs are you working=
 with?
> I tried Anjuta but were unsuccessful in importing the git folder from=
 any
> branch into Anjuta. Eclipse worked a bit better, though I am still ba=
tteling
> with the debugger a bit.
>=20
> Any recommendations, manuals or how-to tips are greatly welcome.
> And one thing: thank you for your effort! Git really caught my attent=
ion and
> I was so much amused by the Google-Techtalk that Linus gave about Git=
, that
> it sparked my interest in relearning how to program again ;)
>=20
> Best regards from lovely Dresden in Germany
> Frank M=C3=BCnnich
>=20

kdevelop rocks. Debugging perfect. Just configure a C external-make pro=
ject
and off you go.

Cheers
Boaz
