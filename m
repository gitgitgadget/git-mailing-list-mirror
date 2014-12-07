From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Accept-language test fails on Mac OS
Date: Sun, 07 Dec 2014 10:56:37 +0100
Message-ID: <54842455.8000603@web.de>
References: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com>	<xmqqppbxogli.fsf@gitster.dls.corp.google.com>	<CAO2U3QikrHRC0PncO2vxFMv88HMnJHYa1AiPak+Lp0OU1u6dZA@mail.gmail.com>	<5482D180.9010002@web.de>	<CAFT+Tg_4EJ15CmujDtcubfw+0rr2J=pbjccqSSs9tmj-rz6+eQ@mail.gmail.com>	<54836F46.9080009@web.de> <CAFT+Tg_OQLj7oWfOJ8ATKHo36Jv3+JcSYWEc-trKsAtjv7wskg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: semtlenori@gmail.com,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 10:56:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxYaC-0006wK-VB
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 10:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbaLGJ4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 04:56:48 -0500
Received: from mout.web.de ([212.227.15.4]:57369 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752911AbaLGJ4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 04:56:48 -0500
Received: from birne.local ([78.72.72.190]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lfzwp-1XeiQr2IEV-00pZN0; Sun, 07 Dec 2014 10:56:42
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CAFT+Tg_OQLj7oWfOJ8ATKHo36Jv3+JcSYWEc-trKsAtjv7wskg@mail.gmail.com>
X-Provags-ID: V03:K0:FhqVFCkNqjOkib0aHc06sQ4ZNMgVzeN97Xi9kLUqF1ealm0z13o
 aZFxL+zGphynf83HEcQVV2ogmCmJEGUiueYxpKhLx8zajiGJLeHofiGugP0UQvj+hiHi+Z6
 Ro5D3TXyjpjgkcJUVW6Bx3WYZ9ReCSRfz7CZgBlMxYQ2/1m/mbAURctyksE6FraTSlLBhiT
 LZ0uYU/yOj9PEfjexig9Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260980>

On 07.12.14 07:54, Yi, EungJun wrote:
> I'm sorry for bothering you, but could you tell me the result of
> "locale" command without "-a" option? What I want to know is locale
> environment variables and its values, so I want to reproduce the test
> failures on my laptop.
> 
(Just for completeness:)
 locale
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=
