From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Wed, 22 May 2013 17:52:10 +0200
Message-ID: <519CE9AA.9010502@ira.uka.de>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net> <CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com> <CAN0XMOKCppZVwwvowzrSDuAKRo-DMeD7GpryjA2deE5mYuSb4Q@mail.gmail.com> <7402110.vsgz8zEiin@cs-pc> <CAN0XMOK4oniunZz5KpC1x=JrY4yH4HnecxMSCyPF+kEyYRRjTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Stimming <stimming@tuhh.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?B?UmFscGggSGF1w59tYW5u?= <ralph@scanmyfood.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>,
	=?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 17:51:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfBK9-0007rS-N9
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 17:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063Ab3EVPv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 11:51:29 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33597 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754052Ab3EVPv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 May 2013 11:51:29 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1UfBJq-0008Ph-5i; Wed, 22 May 2013 17:51:20 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1UfBJp-0008AM-T8; Wed, 22 May 2013 17:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAN0XMOK4oniunZz5KpC1x=JrY4yH4HnecxMSCyPF+kEyYRRjTw@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1369237880.576609000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225169>

Am 22.05.2013 17:16, schrieb Ralf Thielow:
>>>      hunk               = Bereich
>>
>> IMHO "Kontext" is better if you use a German word. Technically the context is
>> something else, but in a German text IMHO it fits nicer when explaining to the
>> user where he/she can select the n-th hunk.
>>
>
> Not sure if German users would know what "hunk" means, in case we
> leave it untranslated. And I'm not sure if I would understand "Kontext".
> I tend to leave it untranslated.

I don't think "Bereich" is a bad choice. As "hunk" is not a word with 
special meaning in cvs and not used in any commands I don't see a lot of 
reasons to keep it in english.

Alternative translations might be "Teilbereich", "Dateibereich". 
"Kontext" would be very confusing IMHO
