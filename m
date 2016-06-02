From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 20:53:57 +0100
Message-ID: <57508ED5.9020509@ramsayjones.plus.com>
References: <20160601235233.21040-1-sbeller@google.com>
 <574F800D.6070107@ramsayjones.plus.com>
 <xmqqy46ouorn.fsf@gitster.mtv.corp.google.com>
 <57505105.2000801@ramsayjones.plus.com>
 <xmqqoa7jvag0.fsf@gitster.mtv.corp.google.com>
 <57507DFD.6010800@ramsayjones.plus.com>
 <CAGZ79ka3ku7x7BhBZJ_uHjS0pNLT7NFACUVqNKi=DvtOkSN_bg@mail.gmail.com>
 <57508C85.1090503@ramsayjones.plus.com>
 <xmqqeg8ftlvk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:54:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Ygx-000638-Ih
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 21:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbcFBTyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 15:54:04 -0400
Received: from avasout01.plus.net ([84.93.230.227]:36317 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcFBTyD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 15:54:03 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 1vtz1t0035VX2mk01vu0ok; Thu, 02 Jun 2016 20:54:00 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=EBOSESyhAAAA:8 a=JxRg5HEQgUWzA0ng5BwA:9 a=pILNOxqGKmIA:10 a=qTHAZ_8SnIsA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqeg8ftlvk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296231>



On 02/06/16 20:46, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> I think Junio wants to go with just " quoting (see other thread).
> 
> No.  I meant just \ quoting.

Yes, sorry, I only just read your last email on the other thread.

ATB,
Ramsay Jones
