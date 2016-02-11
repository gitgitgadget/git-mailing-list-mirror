From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: assert failed in pathspec.c
Date: Thu, 11 Feb 2016 09:24:21 +0100
Message-ID: <56BC4535.6070301@web.de>
References: <56BC0714.1010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Dingyuan Wang <abcdoyle888@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 09:24:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTmYL-0003MM-KA
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 09:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbcBKIY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 03:24:29 -0500
Received: from mout.web.de ([212.227.15.14]:52805 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbcBKIY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 03:24:27 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MDxSJ-1aEAHI31gd-00HNBM; Thu, 11 Feb 2016 09:24:23
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <56BC0714.1010007@gmail.com>
X-Provags-ID: V03:K0:ZYw58cUbB8ZbsFsr/UntZvOEOdtKL0AKFr0in05KXPe3dCXfm0i
 9C8AGmkHbWdjzCbp8dkBMEQ7sD+7/fuh6vO4rEEFZigTK24Pliic9H3ThrVxAGeXI/3OtWu
 xJWVVkUSDXNW/4zaIyVsJGGLbG+MjJSjrdx9EPbjqr7A+9Y3GsG6GSEy+zxjbjeeBsIKK2O
 QXrZ+X88uWSqvEoTreIkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l/sMhPdhrWA=:uvSnpz4tBPX2HhRd+hYM7p
 OWLID0nvlwk1abWLflwbw7p2qs5c7YsebZu9jQ7TeKAsPFqIV61RvafLD0BxGaN1nO6vXUV6i
 5pqK6GIba6fu0OibfZEuVWH0x7vyRP9jMes/HqufZvSW5o/6AQuC78LV+0Lp+FMDVE2GVPxH7
 Ox0eV3cnAMhI0BFbSBPA5EQKZrnK1b6cF6XSVDe6NNqRmTGH4VTDCJgWWdCGwbfa9a5NnVfi5
 hqnCw5z3CxIiuj0NcdWaJIbTBaJsOVbmNOk4O+LGWEEf2FQoQrFTS4qeuiL/TYtLJjian7M3G
 jtqoNvDD4aY8efhbIgoHLJeQOcfiSjwdp9J6PKa+8mn/Eq8Yjr9/ZXUphCt5IN1ImZt2EqpVK
 Ga8s8g3gxQd3sZQospTgbRfTTHbAkxsqEw0WRUuzARxPJaMypOsTQfoKA5kc4bTFYm8NCsPfi
 1S3bl1vobTvJOoUMU7Iw6K3whjalF9vj5BaLKufU727mffq5u+u02jbd1T1VIzgDbBN5ahSsG
 7rtd2N0bdTpzg/K6TiVfSGqqk29pzwEu6d7xzghrsBiO/4cYPLl1G3aMRHKA+1GgLV0/1bynR
 RUgnldbk95JTiCMKVwvcUYExvpaMG1+aKFUySPZLYySXGHXHh9OrmGnN66YZWNDpXkDZm4o5q
 Jk53Tfntk+ZF0YF6USMrrr0rkApwsplMI8V4a81VaxL/X76c2KN+e3whjtbdHjRPKsqpYMMAB
 F3uDRrHxiTMStv60JguiVC2NCVtNL4wdvlU5RroLoeZQXRBW7xQGCfF7tn41y8R9xsFs1+xR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285949>

On 02/11/2016 04:59 AM, Dingyuan Wang wrote:
[]

Thanks for the bug report.

What does
git --version
give you ?

And what happens, if you run the latest version of Git ?
