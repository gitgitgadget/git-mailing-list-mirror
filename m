From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Wed, 31 Oct 2012 19:02:48 +0100
Message-ID: <509167C8.6090600@kdbg.org>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com> <20121030044609.GA10873@elie.Belkin> <CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com> <20121031012730.GY15167@elie.Belkin> <CAMP44s1xAeW2QZsNwRVRx+DEhYVVdiKbw-y-aNuo6unuv7pYZQ@mail.gmail.com> <20121031021318.GB15167@elie.Belkin> <CAMP44s3WODA2Vru0Q1b5EWA6_1vdHnPmFfUmDg0Phh0S=76O9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 19:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTcdd-00072K-9G
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 19:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933198Ab2JaSDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 14:03:15 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:30842 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759485Ab2JaSDM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 14:03:12 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.104])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 5370CCE206
	for <git@vger.kernel.org>; Wed, 31 Oct 2012 19:03:09 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9C2FF130052;
	Wed, 31 Oct 2012 19:02:49 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B87D419F35E;
	Wed, 31 Oct 2012 19:02:48 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <CAMP44s3WODA2Vru0Q1b5EWA6_1vdHnPmFfUmDg0Phh0S=76O9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208844>

Am 31.10.2012 03:28, schrieb Felipe Contreras:
> On Wed, Oct 31, 2012 at 3:13 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Felipe Contreras wrote:
>>
>>> It's all fun and games to write explanations for things, but it's not
>>> that easy when you want those explanations to be actually true, and
>>> corrent--you have to spend time to make sure of that.
>>
>> That's why it's useful for the patch submitter to write them, asking
>> for help when necessary.
>>
>> As a bonus, it helps reviewers understand the effect of the patch.
>> Bugs averted!
> 
> Yeah, that would be nice. Too bad I don't have that information, and
> have _zero_ motivation to go and get it for you.

Just to clarify: That information is not just for Jonathan, but for
everyone on this list and those who dig the history a year down the
road. Contributors who have _zero_ motiviation to find out that
information are not welcome here because they cause friction and take
away time from many others for _zero_ gain.

-- Hannes
