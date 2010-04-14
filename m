From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: git log of remote repositories.
Date: Wed, 14 Apr 2010 21:43:02 +0200
Message-ID: <4BC61AC6.3050700@dbservice.com>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com> 	<slrnhsba0k.h9q.heipei@dualtron.heipei.net> <x2q3abd05a91004141208x6e154385l8b7ce6488d65f21b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Gilger <heipei@hackvalue.de>, git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 21:43:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O28Ua-0005vb-Km
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 21:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443Ab0DNTnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 15:43:12 -0400
Received: from office.neopsis.com ([78.46.209.98]:54816 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab0DNTnL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 15:43:11 -0400
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Wed, 14 Apr 2010 21:43:03 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <x2q3abd05a91004141208x6e154385l8b7ce6488d65f21b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144897>

On 4/14/10 9:08 PM, Aghiles wrote:
> On Wed, Apr 14, 2010, Johannes Gilger  wrote:
>> AFAIK no, the operations have to be local.
>>
>> In order to see if there are any new changes to be pulled you could do
>> this: git fetch --dry-run
>
> It seems to me like a major restriction! Especially that I am tracking
> a remote branch ... No possibilities to do a diff or a log without fetching?
> Very sad. :(

If you are interested in the actual commits (say, you want to merge 
them), you need to fetch them anyway. And if you just want to look at 
the history, most repos provide a web interface which you can use.

tom
