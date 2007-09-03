From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Mon, 03 Sep 2007 10:13:14 +0100
Message-ID: <46DBD02A.60603@zytor.com>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>	<46DA5F33.2020005@zytor.com> <85odgltrtj.fsf@lola.goethe.zz>	<46DA88EF.7080103@zytor.com>	<20070902133803.1b46f599.seanlkml@sympatico.ca>	<7v4picpvgq.fsf@gitster.siamese.dyndns.org>	<20070902191644.29d46cd2.seanlkml@sympatico.ca>	<46DBBD00.5090308@zytor.com>	<7vr6lgmao5.fsf@gitster.siamese.dyndns.org>	<46DBC1EE.3020009@zytor.com>	<7vfy1wm9ik.fsf@gitster.siamese.dyndns.org>	<46DBCA31.5010607@zytor.com> <7vlkboktce.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 11:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS80l-0003Vd-Py
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 11:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbXICJOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 05:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbXICJOT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 05:14:19 -0400
Received: from terminus.zytor.com ([198.137.202.10]:59801 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbXICJOT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 05:14:19 -0400
Received: from titan.hos.anvin.org ([217.206.93.210])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l839DfPJ017166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Sep 2007 02:13:45 -0700
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <7vlkboktce.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.88.7/4134/Sun Sep  2 22:21:40 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57459>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> Junio C Hamano wrote:
>>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>>
>>>>> Ok, should I then do that single change, cut 1.5.3.1 with it and
>>>>> ping you?
>>>> Sounds good to me.
>>> Thanks, and sorry for the trouble.  I am building one on k.org,
>>> and after placing the result in the RPMS/x86-64 and running the
>>> yummy script, I'll ping you again.  If it installs fine for you,
>>> I'll boot my wife's machine to do i386 as well, but it is
>>> getting a bit late now, so it might have to be tomorrow.
>> git.kernel.org is actually an i386 machine (the only one we have left), too.
> 
> Ok, I did the same for i386, up to "yummy" part.  Could you take
> care of the rest of the installation procedure, please?
> 

Done, all good.

	-hpa
