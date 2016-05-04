From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 4 May 2016 12:38:13 +0100
Message-ID: <5729DF25.7030503@ramsayjones.plus.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
 <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
 <1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
 <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com,
	gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 13:38:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axv8L-0001xB-0z
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbcEDLiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:38:21 -0400
Received: from avasout08.plus.net ([212.159.14.20]:36653 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbcEDLiU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:38:20 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id qBeH1s0012D2Veb01BeJBN; Wed, 04 May 2016 12:38:19 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=pGLkceISAAAA:8 a=RtDFEgWkfJtWCzKyhKMA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293538>



On 04/05/16 09:43, Lars Schneider wrote:
> 
> On 04 May 2016, at 10:38, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> Documentation/config.txt            | 4 ++--
>> Documentation/git-check-ignore.txt  | 2 +-
>> Documentation/git-filter-branch.txt | 4 ++--
>> Documentation/git-for-each-ref.txt  | 2 +-
>> 4 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index c7bbe98..5683400 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1494,7 +1494,7 @@ gui.diffContext::
>> 	made by the linkgit:git-gui[1]. The default is "5".
>>
>> gui.displayUntracked::
>> -	Determines if linkgit::git-gui[1] shows untracked files
>> +	Determines if linkgit:git-gui[1] shows untracked files
>> 	in the file list. The default is "true".
>>
>> gui.encoding::
>> @@ -1665,7 +1665,7 @@ http.cookieFile::
>> 	File containing previously stored cookie lines which should be used
>> 	in the Git http session, if they match the server. The file format
>> 	of the file to read cookies from should be plain HTTP headers or
>> -	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
>> +	the Netscape/Mozilla cookie file format (see `curl(1)`).
>> 	NOTE that the file specified with http.cookieFile is only used as
>> 	input unless http.saveCookies is set.
>>
>> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
>> index e94367a..9a85998 100644
>> --- a/Documentation/git-check-ignore.txt
>> +++ b/Documentation/git-check-ignore.txt
>> @@ -112,7 +112,7 @@ EXIT STATUS
>> SEE ALSO
>> --------
>> linkgit:gitignore[5]
>> -linkgit:gitconfig[5]
>> +linkgit:git-config[5]

I think Junio already noted, git-config is in section 1 not 5.

ATB,
Ramsay Jones
