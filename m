From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP/PATCH 6/9] Teach bisect the --[no-]recurse-submodules option
Date: Mon, 03 Feb 2014 21:22:12 +0100
Message-ID: <52EFFA74.4040605@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com> <52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de> <52EFF35D.7070908@web.de> <20140203200435.GA16057@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:22:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAQ27-0007az-3e
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbaBCUWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:22:15 -0500
Received: from mout.web.de ([212.227.17.11]:60362 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbaBCUWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 15:22:14 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0M9ons-1VzNPB0Qqe-00B6q2 for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 21:22:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140203200435.GA16057@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:l8ZL8s+7qdhjdv+yG4LlC3S3cHv3tdoffvfCA5eIZWKp51N28KQ
 YGzzMkk0bDsf2JheRjBJr8ocd2UDX//UoFQ50VX+qZiyq5lyaOaClkWQSM3HUnXffP4DJk7
 5dD5inZiet6yJQ6V6W3bbfMb2Y4lcEeYFeRyC4OZqhthRKLSo0FCjgvWYFZdNPrFlLdo323
 iv113B2r7YnyZmJDUy3fg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241474>

Am 03.02.2014 21:04, schrieb W. Trevor King:
> On Mon, Feb 03, 2014 at 08:51:57PM +0100, Jens Lehmann wrote:
>> submodule update' eacht time obsolete, which was tedious and error prone.
>                     ^ each
> 
> I'm just reading the commit messages this pass ;).

Fair enough ;-)
