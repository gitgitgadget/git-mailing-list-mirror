From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Tue, 24 Feb 2009 10:55:28 +0900
Message-ID: <20090224105528.6117@nanako3.lavabit.com>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
 <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
 <7vljrxveqa.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
 <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
 <7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: felipe.contreras@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 02:57:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbmY9-0007qZ-AA
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbZBXB4G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 20:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbZBXB4F
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:56:05 -0500
Received: from karen.lavabit.com ([72.249.41.33]:45524 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513AbZBXB4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 20:56:04 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id AC37411B943;
	Mon, 23 Feb 2009 19:55:58 -0600 (CST)
Received: from 4016.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id K8ZIP9JYCMDW; Mon, 23 Feb 2009 19:55:58 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=v0UKFrtM4j7tJ8EQ04AO3CczWv1O8uPqER8n02Qsue/oIAMbsIIrCaZpw4EtjXLyLMJ8u0RR8mB3h4R9hlKZNpbaref1kEYY9cJMjvqXcj2rGL9UgZgNJ0yGpkjWiyUzGqjGI95A0RlFz2gQSXzR5fTMuVMvuX4GGYNXFK/ELyk=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111196>

Quoting Junio C Hamano <gitster@pobox.com>:

>
>>>> People already are used to finding the shed in the scenery by look=
ing for
>>>> that original color, however ugly the color might be. =C2=A0The an=
swer to your
>>>> question has to become quite different when you take that into acc=
ount;
>>>> otherwise you are being irresponsible to your users.
>>
>> People somehow got used to the ugly color, they'll get used to the
>> pretty one, in fact, they would probably like it better, and maybe
>> even thought more than once on changing it.
>>
>> If they're the kind of people that don't like new things they'll
>> probably not be using git anyway.
>
> You do not have to send two messages in a row to reaffirm that you ar=
e of
> irresponsible kind.  I heard you enough already.
>
> Go away.

Junio, what got into you?

I've always admired your calm and reasoned way to deal with even the mo=
st obnoxious people, and unlike more abrasive people on this list I've =
never seen you say "Go away" to anybody here.

Especially because I agree with you that calling pretty-printing as "pr=
etty" isn't so broken to make such a big deal out of, it would be bette=
r not to chase a potentially useful contributor away on such a minor is=
sue.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
