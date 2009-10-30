From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 20:30:40 -0200
Message-ID: <55bacdd30910301530n5ce39e03la417685bf02ad50@mail.gmail.com>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com> 
	<7vljisk1m7.fsf@alter.siamese.dyndns.org> <55bacdd30910301505xe712b74m837dc862a6ee953@mail.gmail.com> 
	<55bacdd30910301513u6ba6a575w2c65358ff368aeab@mail.gmail.com> 
	<7v8wesh61b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:31:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zzu-0008LH-4R
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbZJ3Waz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 18:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932906AbZJ3Waz
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:30:55 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47048 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140AbZJ3Waz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 18:30:55 -0400
Received: by yxe17 with SMTP id 17so3136769yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xyyhiB0GR7sOoc1hyLGJGk1Sifa/V9cJDy0wbaula3g=;
        b=BFd6/jIkLN+z12zC3CHCgCdwEtnGV6Xhbpw0pVvc1zuWc91avoKigBorHBJKNYE6+N
         h86T/X1IRLsYbP/jYQM6/WJ7MVQMqVNdI9oKHwOEDFTP5Vr4tzCoR7rTSFHQLolbKZ+P
         6Dh5nxAF9q5EottXxcbBWKcH2HN/lk6I7HnvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Qqg5zseHmNqGYUEaOczEDaLSeJQr7J+B6VeazhRnQtHgcS34qq7k/V71JQOksZJi04
         Ice1/ISg5C2VMQyP6hah7C30EEOYd04+ifTPJziEbTU/22Tu4D6gcfDoJcg5sAj/nhNQ
         wz5Wey/b8o8qaS9wcvOD5/NxBNByw4jj/NeGE=
Received: by 10.150.172.1 with SMTP id u1mr3994522ybe.300.1256941860126; Fri, 
	30 Oct 2009 15:31:00 -0700 (PDT)
In-Reply-To: <7v8wesh61b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131769>

2009/10/30 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> 2009/10/30 Junio C Hamano <gitster@pobox.com>:
>>
>>>(besides, you write logs as if you are making
>>> an order to the codebase to "do this!").
>>
>> Not a chance! =C2=A0Just trying to help.
>
> Sorry, you misunderstood me. =C2=A0What I meant was:
>
> =C2=A0 =C2=A0It is customery for us to write our log messages as if t=
he author of
> =C2=A0 =C2=A0the patch is giving an order, iow, in imperative mood. =C2=
=A0Your "Changed
> =C2=A0 =C2=A0blah" violates that style.
>
I got it in the opposite way.  :-D

So one should give an "order"!...  :-1
