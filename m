From: "Marcello Henrique" <faraohh@gmail.com>
Subject: Re: Change checkout remotely.
Date: Mon, 8 Sep 2008 12:53:43 -0300
Message-ID: <f5cc88f60809080853p43f723ffi3ea4bdc826e168f4@mail.gmail.com>
References: <f5cc88f60809080842l34760997r4b821a79e7727d91@mail.gmail.com>
	 <20080908154539.GF10252@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 17:55:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcj5F-0007m6-99
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 17:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbYIHPxq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2008 11:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYIHPxq
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 11:53:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:58651 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbYIHPxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2008 11:53:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so427868nfc.21
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8WunX1ITr4ZLF5kEadDPuWTVckKFU4dBrkGr9M1PLTY=;
        b=nQb5hjR5eTDUxYY/4OSZmLX168BnqdT/AhD+b6ExpfnSRHxWaFshCsko4INyoK7I/t
         IgptxGxapNby8YhxUYUsfCGf9/HQeuWr/Qk91l+7s77GogETH2WLKXcRlZXeRex8yJeY
         L2PJO01U7Zl2UxZbu0+Lb4A17qhgBFIZsCeL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xCoe7me1Bx0uNDmRwTwqYwe4trLN2PlP4WY52sdwxNm2ft4CngRQ0F/x5xosf+blTc
         qqzpJo887X3jScbBPekSCVoKqHZOgWcvdiZbGC875g6Lo+oGhLpjt+CMQ0tODAaQI+ZH
         KThMrY0rbLgif4xP6sn2a0MAH0EXZwTFDeAG8=
Received: by 10.210.48.14 with SMTP id v14mr18993154ebv.71.1220889223968;
        Mon, 08 Sep 2008 08:53:43 -0700 (PDT)
Received: by 10.210.87.5 with HTTP; Mon, 8 Sep 2008 08:53:43 -0700 (PDT)
In-Reply-To: <20080908154539.GF10252@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95266>

On Mon, Sep 8, 2008 at 12:45, Shawn O. Pearce <spearce@spearce.org> wro=
te:
> Marcello Henrique <faraohh@gmail.com> wrote:
>>
>> Is it possible change checkout another work tree remotely and refres=
h all files?
>>
>> For example: git remote other checkout other-branch-x
>
> ssh otherhost cd otherdir '&&' git checkout other-branch-x

This form is over ssh and over http?

Thank for quickly!
--=20
Marcello Henrique
Associa=E7=E3o Software Livre de Goi=E1s (www.aslgo.org.br)
Cercomp - UFG (www.cercomp.ufg.br)
