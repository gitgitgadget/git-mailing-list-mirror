From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2016, #04; Wed, 20)
Date: Fri, 22 Jan 2016 17:58:30 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601221757290.2964@virtualbox>
References: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:58:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMf2s-0002RM-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 17:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbcAVQ6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 11:58:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:57358 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbcAVQ6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 11:58:42 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0McmFl-1aeSuM17wX-00Hz2l; Fri, 22 Jan 2016 17:58:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:HP7v8mfDz6QCbCw/3i+L29P0/i35juni1HBu2qfNeaFgDhSZkKQ
 ZzEFai6fmhKizSU/fb+2vsV4OAq3QfOPmV8wX6x6GLJvmG1lQ7/L7oxiKm1kFGsIyFewO6Q
 zLRnHd2pqfiS8Q2ZXPXoWmJMWd8kXSOPeIjmnpXpsR+F+ZYcYrGLx+wbWcvnD18sXZBBu+J
 P87FmPgVDUzPbckNhSPuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hAHZBynBxi0=:GBcd77ygiEskdr6cQUonIW
 wG3rg1MIcyxvnXk6c5FLsrDRemHIeCMQFFFqQiPOtcBBxs2sZ1xKhPMqZJtdqED/IImZEOgJZ
 jW1BkMnUxAOfveyU8CHoXTIUXQkuoeWRtv3Dat5Q5ZnD4V8XNjJSMbAdMSryXJybV0xa4siQz
 cDWeBUQ25Re853Wp0Wyuz/o5YmwvYoTDdkvkQL1+3Y71IMtKUX2oNRiITvu3yQcc5BFl4pK9o
 ktY/tS6gRAUTE6sr5cx0N3DQUMBE49FPwuTBvkEwd9xlEUOz7w7xafvUBr0PLPOgTkNqSHnZL
 msp5X8amO1RXQzDRYS6IOr2jmwGKMSE80i3A75mSW84T9hK+80ANpBNI4oRUT4/1h1wEnkjZ8
 FFzVczIkgLbckfb/V6baDwg+uZPq+/2+C+KD9p3Bc7IaT/Zmw9uJiHbCvPF/dR667obY+001m
 SmQOE8EEbmwMkIuP29AJLHUiTGukpevTs0wnERj706Jbts9i1PNgzum55TOJtF1pR6qJQ90qH
 UmNy1iBxIMSwMjkS/hRG0NdvtasksdmocNJRw+IwOgBCgCKqO9XJMEybLXXTqWUR7fAvjWy0c
 QOrdxnQwz6w+6/5roXbkCR4zSq9hu+kulyyMeuBbgmHRwxDYeBA+g4RiNrHyCqNF5EDYQ+a8B
 l/PDRFxGRWOYDGUAelq3qipDQ+HIlrCPOQk6/RUrVjuXquSdz2XbVGlvMbd3bKALYumi98BHK
 an2YYqNrIrHqUtII1ERh4Vxm6T+LnZvNKny2LLZdpmINnnGbiPG+Dee+74NXHVWJukcRoUPc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284562>

Hi Junio,

On Wed, 20 Jan 2016, Junio C Hamano wrote:

> * bb/merge-marker-crlf (2015-11-24) 1 commit
>  - merge-file: consider core.crlf when writing merge markers
> 
>  Write out merge markers using system end-of-line convention.
> 
>  Waiting for a re-roll to handle gitattributes.
>  ($gmane/281701)

For the record, it is $gmane/281700.

I will send out a replacement series shortly.

Ciao,
Dscho
