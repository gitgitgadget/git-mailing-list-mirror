From: Gabriel <gabrielperren@gmail.com>
Subject: Minor issue: bad Spanish translation
Date: Wed, 10 Jun 2015 11:51:58 -0300
Message-ID: <1433947918.16619.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 16:52:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hMN-00030O-TP
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 16:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933319AbbFJOwD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2015 10:52:03 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:36736 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbbFJOwB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 10:52:01 -0400
Received: by qcxw10 with SMTP id w10so18371763qcx.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:subject:to:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=5prAsMMCaUT8Opq3uU1ta075T0XBR4mtB5I6FXXsoxg=;
        b=bhQwmC3uu1gLvkATEhiN37sxHv0s3w6/G2f8HGspyUgpJdFhlSTFrsb1nuKxUVtJeu
         QP0Kwz8iERwL7zWGlPgmswMjjZWagqFtpfz+ByucyavC5yjPL7yyf6X/gyrWXr41CmhW
         CogturMLnVwaCRwfRuR6GzxpUTgrr1PVAUUmMdsG8Yy0oukCLhu+i8Pwcjr8WWpqhGLz
         iT2EGt7XSZN9C2OHh7bQXcvWajdHrOnERV6fsW8iNKwgh+LcEBj5ZIvZnqWRKRswkRP2
         1u+Hc3uycteaLEYaAUO0+waBuu1cozk93fYnnJKDjBXxS7ElhZ6apFHIDP/NC/fN6P8Z
         V82g==
X-Received: by 10.55.17.95 with SMTP id b92mr7245219qkh.16.1433947921107;
        Wed, 10 Jun 2015 07:52:01 -0700 (PDT)
Received: from [192.168.1.100] ([181.170.86.23])
        by mx.google.com with ESMTPSA id 67sm4192524qhw.43.2015.06.10.07.51.59
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 07:52:00 -0700 (PDT)
X-Mailer: geary/0.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271292>

Where it says:

Su rama est=C3=A1 delante de <<origin/master<< para 6 commits.

it should say:

Su rama est=C3=A1 delante de <<origin/master<< por 6 commits.

Notice "para" --> "por".

Cheers,
Gabriel
