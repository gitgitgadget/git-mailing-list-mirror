From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 11/12] t5524: test =?UTF-8?Q?--log=3D=31=20limits?=
 =?UTF-8?Q?=20shortlog=20length?=
Date: Fri, 08 May 2015 15:09:11 +0200
Organization: gmx
Message-ID: <51074f84c26d99ceeb7f7d19aa88e7a7@www.dscho.org>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
 <1430988248-18285-12-git-send-email-pyokagan@gmail.com>
 <05adfac12cb9a7ad183281974d991e00@www.dscho.org>
 <CACRoPnRfqQMRJ5N=oL84SMw=FC=Eg-Co-De_9E9cpWCaaSZAxw@mail.gmail.com>
 <554BB93A.3090000@kdbg.org> <8e34bc9ea27d147f86de0cf60141687a@www.dscho.org>
 <87r3qrwd1j.fsf@hank.tgummerer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Paul Tan <pyokagan@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 15:09:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqi1n-0008GD-KS
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 15:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbbEHNJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 09:09:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:55126 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbbEHNJO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 09:09:14 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LslCb-1ZF5ST0VYn-012EDt; Fri, 08 May 2015 15:09:12
 +0200
In-Reply-To: <87r3qrwd1j.fsf@hank.tgummerer.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:oav3/Ls/4kFdKRRGSl2QxbkhU3jBni9mIPsSASIeWK12qk5if65
 8ZJwP+DhxTTKyfz7nvA6xuVRVDd1HWmN/dn+dWnKdgD03SgOzZDhgZ8/Bo6p1DptcKp/V1I
 K9w+AButMsBvnj1puA0vy+2lycTusJAv5UOxXVVxzohj4wotJSifiOl3onw5dEqHhAJvycd
 p4D60f+OtygeKrPXa+R1w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268616>

Hi Thomas,

On 2015-05-08 12:59, Thomas Gummerer wrote:
 
> t/README states:
> 
>    On the other hand, don't use test_must_fail for running regular
>    platform commands; just use '! cmd'.  We are not in the business
>    of verifying that the world given to us sanely works.

Okay, thanks for the reality check.

Ciao,
Dscho
