From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Bug-directors upper letters names.
Date: Sat, 06 Sep 2014 15:45:17 +0200
Message-ID: <540B0FED.1080507@web.de>
References: <CAEyutAhj4UMWPHV-d24yjx36Q9mjKHdGArpZxpTQS2REfJkREA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Mateusz M <mateuszx90@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 15:54:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQGIx-0008O6-Qh
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 15:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbaIFNpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 09:45:22 -0400
Received: from mout.web.de ([212.227.17.11]:55449 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbaIFNpV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 09:45:21 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MD8Fc-1XcOqQ1dyW-00GXhV; Sat, 06 Sep 2014 15:45:18
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAEyutAhj4UMWPHV-d24yjx36Q9mjKHdGArpZxpTQS2REfJkREA@mail.gmail.com>
X-Provags-ID: V03:K0:OY9PHt9vdpNC/IDA+q7/d9X2at9VDSI3Tj2S+R1EFdi+jB0lvjG
 sBchy+QAZ9A+JfNLqhNl/8pntP3BSawbljQrPrKtJCbQ3scKpDQ/gwTniEgNEJVvv3SkjSA
 NPgZn3MOfww7ig4Q9TV/tkN3/ZbzCQ8AYB8oVwGrTigBCu0/kPvR88ds4cdMfGa9CvFCqtO
 BA5/DiAZK25Nrfqp9bUYQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256588>

On 2014-09-06 08.05, Mateusz M wrote:
> Last days I found special case. A
> changed packages name (all letter to lowercase). After merge with
> other branch there were still uppercase  letters.All the rest code is
> after refactoring.
> Is it a bug ?

Unless you provide more information what had been done,
what is the expected result versus what is on the file system,
this question is impossible to answer (at least for me)

Do you use a case-insensitive file system like Windows or Mac OS?
What does "git status" say?
What does "git ls-files say ?
What does "ls -1" say ?
