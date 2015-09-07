From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Mon, 7 Sep 2015 14:44:45 +0100
Message-ID: <55ED94CD.8020907@ramsayjones.plus.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
 <1441629095-32004-1-git-send-email-bernat@primeranks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
	mikachu@gmail.com, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, mfwitten@gmail.com,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: =?UTF-8?B?R8OhYm9yIEJlcm7DoXQ=?= <bernat@primeranks.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 15:45:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYwjP-0002bs-K7
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 15:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbbIGNpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2015 09:45:07 -0400
Received: from avasout06.plus.net ([212.159.14.18]:59477 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbIGNpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 09:45:05 -0400
Received: from [10.0.2.15] ([146.200.92.77])
	by avasout06 with smtp
	id EDkq1r0051g8v4q01DkrCu; Mon, 07 Sep 2015 14:45:02 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=E4sw3vpl c=1 sm=1 tr=0
 a=nn16DVc344fa5cAYhNr7tw==:117 a=nn16DVc344fa5cAYhNr7tw==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=N659UExz7-8A:10 a=WWv3TkYwAAAA:8 a=nuKk6kgfWxUc3uchybgA:9
 a=pILNOxqGKmIA:10 a=dMfJ0Zu_a7sA:10 a=bJPA41aBqHoA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <1441629095-32004-1-git-send-email-bernat@primeranks.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277461>



On 07/09/15 13:31, G=E1bor Bern=E1t wrote:
> From: Gabor Bernat <gabor.bernat@gravityrd.com>
>
> adds seconds progress and estimated seconds time if getting the curre=
nt
> timestamp is supported by the date %+s command

s/%+s/+%s/

ATB,
Ramsay Jones
