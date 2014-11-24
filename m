From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Mon, 24 Nov 2014 21:22:23 +0100
Message-ID: <5473937F.6000101@web.de>
References: <546F5CC7.8060904@drmicha.warpmail.net>	<b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net>	<20141121180105.GB26650@peff.net> <5470A4C0.3070501@web.de>	<20141122191932.GA13340@peff.net>	<xmqqvbm5yehk.fsf@gitster.dls.corp.google.com>	<20141123194624.GB16605@peff.net> <xmqqzjbgwl77.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 21:22:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt09p-0007nb-RC
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 21:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbaKXUWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 15:22:39 -0500
Received: from mout.web.de ([212.227.15.4]:63810 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111AbaKXUWi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 15:22:38 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0M8hxz-1Y5HoO27W7-00wDL5; Mon, 24 Nov 2014 21:22:27
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqzjbgwl77.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:TpsnaCkE4FrqD/uXAJGy1AJeiTNrG+5VEcqKLXJv6L/DWiI1yea
 o2gBUnCQGI/HL5+CKLSDFPtbWEpzLKID0iH7gawOoV2xdE9fkxI4vT+Ko+ed+oO9TUF9HMv
 kY0MqGwVQtXeq2+5B++NFqRdUpWgc2j4g3MJrUXDJOYaGcm9zNFZWMlUcmNiQXqD0tcXvez
 N6FIn3l6wlNaoq5ugXikQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260144>

On 2014-11-24 18.41, Junio C Hamano wrote:
...
>>> Do we refer to t/README from CodingGuidelines where we tell the
>>> developers to always write tests to prevent other people from
>>> breaking tomorrow what you did today?  If not, perhaps that is what
>>> needs to be added.
>>
>> That might make sense. It might also be that Torsten simply overlooked
>> it when asking his question (i.e., there is nothing to fix,
>> documentation is not always read completely, and we can move on).

Thanks, until yesterday I was unaware of t/README, but now I am :-)
....
