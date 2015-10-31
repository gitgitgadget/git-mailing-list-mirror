From: Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Re: Anonymous commit (empty Author and Committer)
Date: Sat, 31 Oct 2015 08:24:06 +0300
Message-ID: <56345076.30207@gmail.com>
References: <56337DF8.5050802@gmail.com> <5633CDCD.10004@gmail.com>
	<5633CE60.8060907@gmail.com> <5633D0C7.2020709@gmail.com>
	<20151030205955.GC21923@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: savannah-users@gnu.org, git@vger.kernel.org
To: The development of GNU GRUB <grub-devel@gnu.org>
X-From: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org Sat Oct 31 06:24:19 2015
Return-path: <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>
Envelope-to: gcgsu-savannah-users@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>)
	id 1ZsOeJ-0002UI-Fm
	for gcgsu-savannah-users@m.gmane.org; Sat, 31 Oct 2015 06:24:19 +0100
Received: from localhost ([::1]:54309 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>)
	id 1ZsOeH-0004V4-Ua
	for gcgsu-savannah-users@m.gmane.org; Sat, 31 Oct 2015 01:24:17 -0400
Received: from eggs.gnu.org ([2001:4830:134:3::10]:41855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arvidjaar@gmail.com>) id 1ZsOeF-0004Uz-Dk
	for savannah-users@gnu.org; Sat, 31 Oct 2015 01:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arvidjaar@gmail.com>) id 1ZsOeA-0002PL-HD
	for savannah-users@gnu.org; Sat, 31 Oct 2015 01:24:15 -0400
Received: from mail-lb0-x235.google.com ([2a00:1450:4010:c04::235]:36829)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arvidjaar@gmail.com>)
	id 1ZsOeA-0002Om-9t; Sat, 31 Oct 2015 01:24:10 -0400
Received: by lbjm5 with SMTP id m5so60241958lbj.3;
	Fri, 30 Oct 2015 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=9nNjTaakwDf7IRnqDnKmathALqtoJ5gIGYtyeXpToSQ=;
	b=KfbI0uTJO52kPnMbugC9cf8z7tzeMFQ69xpKmkcR4Z/i/HB0i7/tDTa6PWMNzxAsG8
	W826C46q1RIEbwfhFHB9kAfE4lZZ3tRuMXbXXdCxlH1zrhBsaSr3guuoI6Wz06eoevNK
	HgiVMHHCWyDhbIAdGunxJtSj22RK0rRKAozZoCT1RNl68nHUFPWSoko0S7IfZ3wjmOCN
	1zk0rLd7NRYdSJ7Vc0nYFFBzZbHRsA94iNKDbfE4QY2m5YQIBtJNieRZr19fnHRRke1F
	pQ4OHFfB/RFA5pxO7056zdstmPwZUcoGsJaCg8eNPaAFfLeBWLgb/tWUE1YX1U1PilUP
	wzfQ==
X-Received: by 10.112.168.194 with SMTP id zy2mr5813919lbb.79.1446269049040;
	Fri, 30 Oct 2015 22:24:09 -0700 (PDT)
Received: from [192.168.1.41] (ppp91-76-25-247.pppoe.mtu-net.ru.
	[91.76.25.247])
	by smtp.gmail.com with ESMTPSA id e63sm1885183lfi.1.2015.10.30.22.24.07
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 30 Oct 2015 22:24:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
In-Reply-To: <20151030205955.GC21923@csclub.uwaterloo.ca>
X-detected-operating-system: by eggs.gnu.org: Error: Malformed IPv6 address
	(bad octet value).
X-Received-From: 2a00:1450:4010:c04::235
X-BeenThere: savannah-users@gnu.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Discussion of savannah-announce and any user-oriented topic
	<savannah-users.gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/savannah-users>,
	<mailto:savannah-users-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/savannah-users>
List-Post: <mailto:savannah-users@gnu.org>
List-Help: <mailto:savannah-users-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/savannah-users>,
	<mailto:savannah-users-request@gnu.org?subject=subscribe>
Errors-To: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org
Sender: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280566>

30.10.2015 23:59, Lennart Sorensen пишет:
> On Fri, Oct 30, 2015 at 09:19:19PM +0100, Vladimir 'φ-coder/phcoder' Serbinenko wrote:
>> On 30.10.2015 21:09, Vladimir 'φ-coder/phcoder' Serbinenko wrote:
>>> On 30.10.2015 21:06, Vladimir 'φ-coder/phcoder' Serbinenko wrote:
>>>> On 30.10.2015 15:26, Andrei Borzenkov wrote:
>>>>> See
>>>>> http://git.savannah.gnu.org/cgit/grub.git/commit/?id=206676601eb853fc319df14cd3398fbdfde665ac
>>>>>
>>>>>
>>>>> I was not even aware that this is possible. Is there anything on server
>>>>> side that can prevent it?
>>>>>
>>>>> Would be good if commit were amended and force pushed to fix it.
>>>>>
>>>> It is a bug in SGit. I'll investigate how it happened
>>
>> I don't have non-fast-forward rights. Does someone from savannah-users
>> have them? Could he just delete this commit?
>
> If you do that, then anyone that already did a pull after it went in
> will have a broken tree.  Rather annoying.
>

If we decide to fix this commit it is better done now, while it is the 
last one. It is annoying but do you have suggestion how it can be done 
differently?
