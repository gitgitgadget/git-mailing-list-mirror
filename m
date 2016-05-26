From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.9.0-rc0
Date: Thu, 26 May 2016 11:59:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605261156070.4449@virtualbox>
References: <xmqq60u47403.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 11:59:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5s4y-0005u9-Bl
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 11:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbcEZJ7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 05:59:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:56149 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbcEZJ7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 05:59:30 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MQR3s-1ay8HS2EPs-00Tnn7; Thu, 26 May 2016 11:59:18
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq60u47403.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:YyrwGNS3xgxPxC6Ko3wxxN2U2/zGIwzMgoYh5tO4vdUH7MiPw+G
 cXc1KVZinBIG39tsNj7z2nW2UqCZVw+KJ4i5y+hwpJn6NAimAS2Qr/kFfDzGEOx0gN5Gpc2
 ms+20kketOu388KlJ7mHclVGrqHD4R0qdfF6W50xBI6GLe+HI0hl8rtMsBRhMjwDFoXIPY8
 7Bdkcei80xWlxl9WrP3QA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SqyoLAOwIXU=:RWxwJlRFAMvrwOKiB+6XEk
 3bxIxcCTnXDTN2a28I+Fi4rMipN89COdvDW3TK24yPuY+qCpdzw3rXzFDyhSHYwu1D4McRsAN
 4JutwM1IDxYLcsGGFqCr6Etq9rAcjhxdSBWjebEVO9wBqowgibZEB68HWO+2nAMup41gz//8q
 GCb8M0dA58ddi97Fj7Fj+rghYaCupeAayVqnE7aChsZ+4QGYY8CnFMfaXyHK0SvRcPYm1yhKe
 XeoEdn+3FVeL2FugoXiIM9LNg4pyEDraHDbH6lOSueFJZG8y3UnrZ1spXOjwgMQfIUzAbJp9S
 zjHlqT8NQljrEl6UzIw0zcHmbt56tL3QP7riWWUL0MSQTsS8x84z7hx5OPd5K3GB7M4S3Lbg+
 tsfh2LmBkq8c7Xg4TmDt38qa/OAfSNh9uPJyAK9KBokv46NKan71pArb/HKyi6JyvT0wGOilQ
 8oZmvKAgs+UASa8gVoHsoTzuLnf5cj3Xba9LPs01v0DYRmIheCO6Fm2cTJ6upwCo/vqdVrD9R
 ccGSXh9WnjjB0/6MjTKN/OiT7kGXKSRcg6n0QH5tlizYXlLWR6ItoC/r0rXbHjRqk+AIotwKC
 H1Lltmo6/XpWzqwtTW5PWCpHYuzjSeTSXZyjBsI6isuFrnlW+eA01su6a8Ag5X6jYb5xdLzRk
 uZX7oZF2rwfjWWQmOL1/mXuomXCL2yQGDy4V6m9W2BqXnsMoNb8Fm6y2GL9Pj5s3lUsviHB7a
 6PZjyBNXkZ9UG/+zD3WA0fuoNK4vDVD3RjzW5Dja/hNBwOdXiWafdD9835UJmzpdmYA9bhGl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295641>

Hi Junio,

On Mon, 23 May 2016, Junio C Hamano wrote:

> An early preview release Git v2.9.0-rc0 is now available for
> testing at the usual places.

Thanks. I pushed out a tagged source-only Git for Windows v2.9.0-rc0 for
interested parties:

	https://github.com/git-for-windows/git/releases/tag/v2.9.0-rc0.windows.1

>  * The test scripts for "git p4" (but not "git p4" implementation
>    itself) has been updated so that they would work even on a system
>    where the installed version of Python is python 3.

s/has/have/

Ciao,
Dscho
