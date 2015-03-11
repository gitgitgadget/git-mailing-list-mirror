From: Harsh Bhatt <creative2innovative@yahoo.in>
Subject: Expressing git in form of Mathematics
Date: Wed, 11 Mar 2015 03:26:12 +0000 (UTC)
Message-ID: <2036326753.1509156.1426044372060.JavaMail.yahoo@mail.yahoo.com>
Reply-To: Harsh Bhatt <creative2innovative@yahoo.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 04:34:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVXQ9-000521-OP
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 04:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbbCKDew convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 23:34:52 -0400
Received: from nm44-vm2.bullet.mail.gq1.yahoo.com ([67.195.87.25]:59448 "EHLO
	nm44-vm2.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006AbbCKDeu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 23:34:50 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2015 23:34:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.in; s=s2048; t=1426044551; bh=ppzPm89+c+8AnMQxCI79XC40/UYd5c8J/y+mKAXwr+E=; h=Date:From:Reply-To:To:Subject:From:Subject; b=r3SdslRZHpPfLKqF1XfatqND62j5MQwQ5tVBu4ygJ43qJWXyMoJapwf1xaCq+r9aixM/0fYaFeZMnlWv3qxuI0TFonepxwwbF2ymbH+gvI2Y/8fRTKSOBlXfEQKZSJ2ee210iXkdN9euT0+e7OqqIWno4TE9w/yb/fv08BX9VQsr3xCSfa9Au+6UstU0bMJsvF/3crT0+PzMxYUT5esA3t+ZpkBmttrVRd/BAKjiTskDjTUiKAWbRAvPMVUFC0YShSrloftmRCtf9WJ9uRnMYq6iehGmWnbw9kuS5syTd5ta2ESkMZqwDX1aa6FO2LFQnhTIWnSnePhhepCD2uR9Kw==
Received: from [127.0.0.1] by nm44.bullet.mail.gq1.yahoo.com with NNFMP; 11 Mar 2015 03:29:11 -0000
Received: from [98.137.12.190] by nm44.bullet.mail.gq1.yahoo.com with NNFMP; 11 Mar 2015 03:26:13 -0000
Received: from [106.10.166.62] by tm11.bullet.mail.gq1.yahoo.com with NNFMP; 11 Mar 2015 03:26:13 -0000
Received: from [106.10.151.122] by tm19.bullet.mail.sg3.yahoo.com with NNFMP; 11 Mar 2015 03:26:12 -0000
Received: from [127.0.0.1] by omp1004.mail.sg3.yahoo.com with NNFMP; 11 Mar 2015 03:26:12 -0000
X-Yahoo-Newman-Property: ymail-4
X-Yahoo-Newman-Id: 783747.43634.bm@omp1004.mail.sg3.yahoo.com
X-YMail-OSG: hZdQr4EVM1melEHvwtagYg.7OoINH0dd7wiPnS8zWvlbycGRiuHdY9Me.IBhnbZ
 I4wt2UOb94C7GFt42INqVHEWRsVCDovGM1WBdx5XFZnk9ek9hOGOKqindO.IguVsPshcki2exTmQ
 JDlwXLbkkS2L3EHyewnK2QT2cAlsEv75ViiGCn6it3VJLMloMi23685kH2xic6EsGZ.iRn3lDXat
 r6VEAc5GUouDRj2zrBm_vQ92uGTJuGFbbA_uuk8yEipaLNZNibbMY08WIy3.J0IHx69R2RemUmq0
 SPADTeay86DUI..WoFZJjpvn8cUzftYNaxWMigwZzhtZ8b9wpnvv9gwchdwpoxdijOd1UPVNJg1H
 iuUK9wbClmeSYctmzz7mpUtcDphrBgTm10R_arvCNZyNii4pqutfKTp6.6ey9O20QiIxFBLSSxR8
 tWv_pxHNPiQ4OLlXiYzm8xA3nkNUw9SC24ASktWWsDycArOTBJYu4qIy2DkL_j1_P.c7e8IcTOoh
 cKC3jbllNaky1IjEzgZURkwS_YoGt.bBNGW1ck6_LW99sXNkYG5zWhiIyaU54WIAOHE4Re5pSlZi
 yN.yqmJMrsmtNNVPQkCqc2qWZn.X7G9yMJepSW2eNdpnUa0QjKnPOutxxUvdlIoOWus1Kh2cRtzn
 qD.ntITDKCv.97xlOQ.DpZDFrjx0JsKlcdAXG6Ijqe7W_sS0XNg--
Received: by 106.10.196.181; Wed, 11 Mar 2015 03:26:12 +0000 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265293>


Hello Everyone,=20

I am glad to be here and would be even more happier if I am able to do =
the work that I have undertaken, that is representation of git using ma=
thematics. Even I have taken up this as my final year project, currentl=
y I am student of Applied Mathematics. I am doing this because I love g=
it + mathematics =3D awesomeness. So want to combine and experience the=
ir fusion in mathematical form.=20

I have searched the internet and googled to get as much info as possibl=
e in this regard  and this is the  best and more close to what I am sea=
rching for -> 1. http://eagain.net/articles/git-for-computer-scientists=
/ . This site gave me hope that it must be possible to achieve my goal,=
 i.e. to represent all the feautures and functions of git in mathematic=
al form. If that=E2=80=99s really possible .. umm..  it must be possibl=
e so pls guide me and give your valuable suggestions.=20


I must not forget to mention that this the video that brought me very c=
lose to git.=20
2. Tech Talk: Linus Torvalds on git which was at google. -> www.youtube=
=2Ecom/watch?v=3D9hIQjrMHTv4=20



Harsh Bhatt
