From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on
 Windows
Date: Wed, 24 Nov 2010 10:16:58 -0700
Message-ID: <4CED488A.2070507@workspacewhiz.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>	<AANLkTikXkWvHrc7=FjePfX5WyyNF1U=KH2DBCU+CcVu6@mail.gmail.com>	<AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com> <AANLkTim-1uKTVacr1N=9bhZ+=ngggrJS=GD-YNjkSuBR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dun Peal <dunpealer@gmail.com>,
	Wilbert van Dolleweerd <wilbert@arentheym.com>,
	Git ML <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 18:17:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLIy6-00026N-9X
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 18:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab0KXRRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 12:17:04 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:45981 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974Ab0KXRRD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 12:17:03 -0500
Received: (qmail 24905 invoked by uid 399); 24 Nov 2010 10:16:58 -0700
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 24 Nov 2010 10:16:58 -0700
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <AANLkTim-1uKTVacr1N=9bhZ+=ngggrJS=GD-YNjkSuBR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162069>

----- Original Message -----
From: Tay Ray Chuan
Date: 11/24/2010 7:16 AM
> On Wed, Nov 24, 2010 at 3:59 AM, Dun Peal<dunpealer@gmail.com>  wrote:
>> On Tue, Nov 23, 2010 at 7:12 PM, Wilbert van Dolleweerd
>> <wilbert@arentheym.com>  wrote:
>> The working copy totals about 4GB. The .git directory, tightly 
>> packed, is 1GB.
> What does the structure of your working tree look like? I think the
> depth might be affecting performance
Whenever I want to know exactly what is going on with disk access, I 
download Process Monitor from http://sysinternals.com/.

In order to just show disk access, I filter entries that begin with TCP, 
UDP, and Reg out.

Josh
