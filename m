From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2] config: add '--sources' option to print the source of
 a config value
Date: Wed, 10 Feb 2016 16:03:33 +0000
Message-ID: <56BB5F55.9040404@ramsayjones.plus.com>
References: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
 <56BB3157.7080307@ramsayjones.plus.com>
 <CAHGBnuNGTQvBStqK6-OERye4y2+yvRkK3g+rdSNPepSqy4kyRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: larsxschneider@gmail.com, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 17:03:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTXEz-0005Fl-VN
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 17:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbcBJQDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 11:03:38 -0500
Received: from avasout07.plus.net ([84.93.230.235]:43204 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbcBJQDh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 11:03:37 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id Gg3a1s0054mu3xa01g3bga; Wed, 10 Feb 2016 16:03:35 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=Ki35LypJW00xBySNttAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <CAHGBnuNGTQvBStqK6-OERye4y2+yvRkK3g+rdSNPepSqy4kyRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285907>



On 10/02/16 15:28, Sebastian Schuberth wrote:
> On Wed, Feb 10, 2016 at 1:47 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
> 
>>> Sebastian suggested "--show-origin" as a better option name over "--sources".
>>> I still believe "--sources" might be slightly better as I fear that users could
>>> somehow related "origin" to "remote" kind of configs. However, I am happy to
>>> change that if a majority prefers "--show-origin".
>>
>> <bikeshed>
>> As I have said before, I'm not very good at naming things, but ...
>>
>> Of the two, I *slightly* prefer --show-origin, since I don't think
>> there will be any confusion. However, I think --source may be OK too
>> (for some reason it sounds better than the plural). Another idea
>> may be --show-source. ;-)
>>
>> </bikeshed>
> 
> I agree that using --source sounds better than --sources, as the
> latter sounds even more like "source code".
> 
> Here's another idea: How about --declaration or --show-declaration?
> 

Hmm, I think its more like a definition! :-D

[Sorry, I just couldn't resist. I promise not
to say any more on this. ;-) ]

ATB,
Ramsay Jones
