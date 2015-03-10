From: Harsh Bhatt <creative2innovative@yahoo.in>
Subject: Connecting git with Mathematics
Date: Tue, 10 Mar 2015 19:52:32 +0000 (UTC)
Message-ID: <1138230357.20947.1426017152123.JavaMail.yahoo@mail.yahoo.com>
Reply-To: Harsh Bhatt <creative2innovative@yahoo.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 20:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVQCl-0007Wq-1l
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 20:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbbCJTwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 15:52:34 -0400
Received: from nm11-vm7.bullet.mail.gq1.yahoo.com ([98.136.218.174]:49086 "EHLO
	nm11-vm7.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752756AbbCJTwd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 15:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.in; s=s2048; t=1426017153; bh=jIAUAz13IHLgUG+FzTSVKG7EzxEgvagcApCiutunfXo=; h=Date:From:Reply-To:To:Subject:From:Subject; b=jS0UFQQyX+xpp+ENPLZeKRw5dc+AqTDqeLOYQUQwwaIeqO931ZNvQjSy5eluj4kksUCqCScvT48oGxsSPst7EyoTbB1R2h/DfrlYOrEasSgdAmPQ42577iVf0QPHq337aochqNagArLMOGI5SmZGILbGwxWfjMnRlDSM2mUvAw67/vJlQVBa0nOf4woPIVm+kSZSHOpYdfDKvevuvFcBtfl3nt5mBSR4E3xlGHAE5rHe88ONuL+Ss+Ev2qGT3HTfzlYueQjhXwmt5Wm3tR6hXNBjq6djWrCM2FwqL41enkXTQdT3+aLlxjuImQSfY8ULttUVYhEWvjQWurHao37gMQ==
Received: from [98.137.12.188] by nm11.bullet.mail.gq1.yahoo.com with NNFMP; 10 Mar 2015 19:52:33 -0000
Received: from [106.10.166.61] by tm9.bullet.mail.gq1.yahoo.com with NNFMP; 10 Mar 2015 19:52:33 -0000
Received: from [106.10.151.170] by tm18.bullet.mail.sg3.yahoo.com with NNFMP; 10 Mar 2015 19:52:32 -0000
Received: from [127.0.0.1] by omp1010.mail.sg3.yahoo.com with NNFMP; 10 Mar 2015 19:52:32 -0000
X-Yahoo-Newman-Property: ymail-4
X-Yahoo-Newman-Id: 817234.5682.bm@omp1010.mail.sg3.yahoo.com
X-YMail-OSG: E3IuwfAVM1lctQhlRPQX1iP0DVO0MCFZev2DsZNxWALRjAVZfcIzP3XKsw.QWlG
 a8Fa38nsy765qzxqXXYo6lx5tOVY7i7zUylbHWJXdcDU4GoqvRtv8m3AFeCbei7dobwe5wLs2R2d
 Z.fxtOBRrSolirduZ0ZxxnDgSMbD_HKDqiM4mQRBhgD8DwPNUAldafwvmonXiwezcGV2CHEJrZQR
 J_C0cmsVy3VYFe.4Tpj0V.M9N8UYLDyPqTjR1RK1I_HRJRVFttkgL.h9GMh7Y1H7SEJjE2LscLHO
 lR5wempAVNyKvZVumD3HDwtETSAIEcZgLYJoEkrLHe8xT7.ajDnlU.PDhs5Bj3UcbXiHpXPw1fNC
 FdCL6K_BUELv0RY1UpTYvSx3LQnkGI1oM_2Sz1YtnwI.bZii4kU_M._gZu060S9Q0OJeWMp75WNC
 GLtnG11titbVuL8rBIBficqcu3xVRQI4Zt6frar6sNKIuiPtqwgXps4Q46hRI2empBwpLYs5dTim
 WHQ4fjEBGiB22QGd3qhjf5kJImNdyNnOgJFxsTOatwklUYraLT0sAu5_IUM_lII3OwKZKEbkQiYI
 LNEcMeUO560mBsdSjehgY9z0sQrHMM34GAxWi0dmsoHUTP1k5oqfavwCPdCHzxl6zgm9Vu3LCxeB
 cOnjSpYAitVfugO_VGk9Br4pYW73b8sM-
Received: by 106.10.196.91; Tue, 10 Mar 2015 19:52:32 +0000 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265258>




Hello Everyone,
=20
                                  I am glad to be here and would be eve=
n more happier if I am able to do the work that I have undertaken, that=
 is representation of git using mathematics. Even I have taken up this =
as my final year project, currently I am student of Applied Mathematics=
=2E I am doing this because I love git + mathematics =3D awesomeness. S=
o want to combine and experience their fusion in mathematical form.
=20
    I have searched the internet and googled to get as much info as pos=
sible in this regard  and this is the  best and more close to what I am=
 searching for -> 1. http://eagain.net/articles/git-for-computer-scient=
ists/ . This site gave me hope that it must be possible to achieve my g=
oal, i.e. to represent all the feautures and functions of git in mathem=
atical form. If that=E2=80=99s really possible .. umm..  it must be pos=
sible so pls guide me and give your valuable suggestions.


I must not forget to mention that this the video that brought me very c=
lose to git.=20
2. Tech Talk: Linus Torvalds on git which was at google. -> www.youtube=
=2Ecom/watch?v=3D9hIQjrMHTv4

 =20
            =20
Tech Talk: Linus Torvalds on git =20
View on www.youtube.com Preview by Yahoo=20
