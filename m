From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] graph: simplify graph_padding_line()
Date: Sat, 20 Sep 2014 23:35:58 +0200
Message-ID: <541DF33E.6080400@web.de>
References: <541DC7A1.1000509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 20 23:36:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVSKW-0000Ge-2c
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 23:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbaITVgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2014 17:36:20 -0400
Received: from mout.web.de ([212.227.17.12]:51369 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162AbaITVgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 17:36:20 -0400
Received: from [192.168.178.27] ([79.253.175.32]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MQ6H9-1XRJKW0dQh-005EML; Sat, 20 Sep 2014 23:36:15
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <541DC7A1.1000509@web.de>
X-Provags-ID: V03:K0:ya6IV6rFOPeXk2ZdqZp+ZPwOMz/NKWglfd9cPjRx4wLapdJ0QOC
 TZkztZ7hzxa/EiIIlIAWzN6gynRFdNnWYO09qFchtrDaUriW5HlI074mBOt+2gVVbrSCr3u
 E+tD2t3Jkv1yIc4vQ4qkkn4qKjiHiColy+n19nPZursclYiysbBv70BkrMyLjbCk9hBlRs3
 I1zzzBYBfkdWBrHf4+gwQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257331>

Am 20.09.2014 um 20:29 schrieb Ren=C3=A9 Scharfe:
> Deduplicate code common to both branches of if statements.

There is no 2/2, this patch is the only one at this time.

Ren=C3=A9
