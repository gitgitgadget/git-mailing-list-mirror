From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/README: document more test helpers
Date: Tue, 6 Jul 2010 20:23:40 +0000
Message-ID: <AANLkTiksA2SYdj85XNd0TQp_1OwLnEGLqmDKbfa14WD6@mail.gmail.com>
References: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
	<20100702192102.GA6585@burratino>
	<AANLkTilI0NZiDk3I850x28pr5I0sYRiPLW7HAST9sduU@mail.gmail.com>
	<m3wrtdm1y9.fsf@localhost.localdomain>
	<20100706200410.GA7606@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nazri Ramliy <ayiehere@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 22:23:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWEgH-0001sM-36
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 22:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab0GFUXn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 16:23:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50569 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab0GFUXm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 16:23:42 -0400
Received: by iwn7 with SMTP id 7so7023162iwn.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BAjvqGmaY5sN1OgOAK7c/y6vTn2CjQ9RV/Duz3KYcZw=;
        b=NAE5UQh9k7fGfeMlPdrUIIqBvPuBLDG4AU+uPXNI8hFCvFbDV3qUYgMssJT2vz8dqP
         W6vBAMSEokFLKYQ3+1ogWbHkGNNB+dbm2PlD7Fb8M6Jt/IUjvAX4/4pXE9EmblklM7JY
         LI0kPeelZ1e3WCWbbYBhtm3mSXW3Tlev7n2ZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g0V/TFwZ2u7KAG/pRKNNx5wykiRWwhjX+Xmi1ESQ5xsIUyGU2lCz/zE4LWAftH50gJ
         ZQxDRRsbJBBOlfg8JTxrWw/HmCqOtjMvugjh9qPPqvB45XcsxfnK6fw/GF3jd7OfPo6x
         SM1wSyDyYynL99KaU6HKQfYxbK9GkqU6+FKmU=
Received: by 10.231.14.194 with SMTP id h2mr5268444iba.67.1278447820943; Tue, 
	06 Jul 2010 13:23:40 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 6 Jul 2010 13:23:40 -0700 (PDT)
In-Reply-To: <20100706200410.GA7606@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150411>

On Tue, Jul 6, 2010 at 20:04, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> There is no documentation in t/README for test_must_fail,
> test_might_fail, test_cmp, or test_when_finished.

Excellent, looks good.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
