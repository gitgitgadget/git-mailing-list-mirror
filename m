From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] git.txt: document GIT_TRACE_PACKET
Date: Sun, 9 Jun 2013 03:20:42 -0400
Message-ID: <CAPig+cRiSqU=yTM05uFp7+bY-Q5Bn5S-dMeibV55Xb3x5j6qdA@mail.gmail.com>
References: <20130609053621.GA1854@sigill.intra.peff.net>
	<1370757210-2994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 09:20:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZvk-0003dO-L6
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 09:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761Ab3FIHUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 03:20:45 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:49345 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab3FIHUo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 03:20:44 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so3371882lab.12
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 00:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aTJFBAeDFTtaL+SAdFd1DvdTF7TEfZ7s4FCBm8eJgdc=;
        b=Y1qDOtdtt/io7hwOUbFl4NvH+XCoglKF8tDTj0OoZE16a+sd5GpCafUP0WBv4VjXFD
         LQhgR/sSBW1cPE1tYxOh7ijqyZ5moBRQ/HnRefxbIC/jTdcWdmRBDVgsGJJiics8Wrb2
         v9I50DbzkLRCYXxQcQP7sIKXqlqLgU9OE9Un/Wn3U4CQdaUUuxKo2UPan6e9ExBN+lFI
         7P1uhPYxc98F9YVljeYhCkrlXorYU8I0HBetCglFn3i2flRPuZqWoVOj8Vs6DnVGuDjb
         6ib1AXeKFKUbEE9aRJLr36WjWKYR2PKEWYCgKvkxJFp80IEAjQimmI4xXnezOILnrom3
         jDDQ==
X-Received: by 10.152.22.199 with SMTP id g7mr2597426laf.20.1370762442871;
 Sun, 09 Jun 2013 00:20:42 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 00:20:42 -0700 (PDT)
In-Reply-To: <1370757210-2994-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: O5P6R5JVkWTqF9A9ZOElb_qbjyo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226940>

On Sun, Jun 9, 2013 at 1:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> "This can help with debugging object negotiation or other protocol
> issues."

s/"//g

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
