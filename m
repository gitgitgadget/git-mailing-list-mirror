From: =?ISO-8859-2?Q?Kry=B9tof_Tulinger?= <k.tulinger@gmail.com>
Subject: git pull freeze
Date: Fri, 17 Oct 2014 23:35:54 +0200
Message-ID: <54418BBA.6050607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 23:36:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfFC2-0002YE-IN
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 23:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbaJQVf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Oct 2014 17:35:59 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:50219 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaJQVf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2014 17:35:58 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so1404410lab.30
        for <git@vger.kernel.org>; Fri, 17 Oct 2014 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=TiGdtAstimkFT+zgaXcrKL99nB1DtHPYNy7vOLX/KiY=;
        b=0YuYE6YyyQJWssnMi+trAoC+t5g15JgDOpq1p7UGBjxGeIqdWZfSNfhZOhCVis5CiF
         QwaBGD8IrbqyH5nd7cX5RHUaCfitvs7gbx8S2Uc/k+ighQBFQcbG+S3pnhwv7hLx3x1J
         gD2qOn5PeSMx4qOygehRBFhaZXSdu18njBwsk199gHv77p0UfjbmVu6pI+DGJ3yj/R0M
         j4rnZo9Y50/JZhxexv7Tiys0syqiDCUmZm2w/7S3K9Bqhbm5ANcO0mkW0gULRuOrp+WA
         jPoU1nLs/IjOMJwES9PjKyWTgpl9aheRaFqVNY9HS333VA94erUho1aABqwOfMXGjHXu
         2amw==
X-Received: by 10.152.20.199 with SMTP id p7mr11518802lae.49.1413581757414;
        Fri, 17 Oct 2014 14:35:57 -0700 (PDT)
Received: from [10.50.20.35] ([213.236.242.221])
        by mx.google.com with ESMTPSA id i6sm777715laf.47.2014.10.17.14.35.55
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 Oct 2014 14:35:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good evening,

I am having difficulties with "git pull" command. Couple days ago it=20
worked perfectly, no problem. Now this command just runs, and does=20
"nothing" without any output.
I discovered that it is actually doing something and within one or two=20
hours it finishes successfully. But before it took few seconds, not eve=
n=20
a minute. Other commands like push, fetch or merge are running normally=
=2E
I observe the same behaviour with command stash, but I am not sure if=20
pull is using this one.

I am using git version 1. 9. 4 from windows exe reviewed on 20140929.=20
Windows 8.1. Through cmd line.

I reinstalled program many times, cleared temporary directories, cleare=
d=20
records in registers, ran with administrator rights.

The same (freeze) if I try to use my cygwin unix git. On my unix virtua=
l=20
machine - no problem, on nonlocal unix machine also no problem.

Do you have something to suggest? The main problem is that there is no=20
output so I can hardly define the problem.
I can provide you with more information about my system if needed.

Best regards

Kry=B9tof Tulinger
