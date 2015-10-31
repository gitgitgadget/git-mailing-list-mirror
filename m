From: Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Re: Anonymous commit (empty Author and Committer)
Date: Sat, 31 Oct 2015 16:54:17 +0300
Message-ID: <5634C809.2070608@gmail.com>
References: <56337DF8.5050802@gmail.com> <5633CDCD.10004@gmail.com>
	<5633CE60.8060907@gmail.com> <5633D0C7.2020709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
To: The development of GNU GRUB <grub-devel@gnu.org>, git@vger.kernel.org,
	savannah-users@gnu.org
X-From: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org Sat Oct 31 14:54:27 2015
Return-path: <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>
Envelope-to: gcgsu-savannah-users@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>)
	id 1ZsWby-0008FY-LA
	for gcgsu-savannah-users@m.gmane.org; Sat, 31 Oct 2015 14:54:26 +0100
Received: from localhost ([::1]:55767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>)
	id 1ZsWbx-0001vp-SR
	for gcgsu-savannah-users@m.gmane.org; Sat, 31 Oct 2015 09:54:25 -0400
Received: from eggs.gnu.org ([2001:4830:134:3::10]:46055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arvidjaar@gmail.com>) id 1ZsWbv-0001vc-4i
	for savannah-users@gnu.org; Sat, 31 Oct 2015 09:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arvidjaar@gmail.com>) id 1ZsWbr-0004le-V0
	for savannah-users@gnu.org; Sat, 31 Oct 2015 09:54:23 -0400
Received: from mail-lb0-x22a.google.com ([2a00:1450:4010:c04::22a]:36244)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arvidjaar@gmail.com>)
	id 1ZsWbr-0004la-NO; Sat, 31 Oct 2015 09:54:19 -0400
Received: by lbjm5 with SMTP id m5so64143500lbj.3;
	Sat, 31 Oct 2015 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-type:content-transfer-encoding;
	bh=zF4IIalUJrG9cGH2ahCM29PQb56KG8RsHT103cQ6yxg=;
	b=ZpxzlT5V+RxK/JghjSKRPw6Nir7t8QWlYiF7Z9xDsswF7g/k98vEz9YXHadaSfY/Yo
	BkytlnpkU1FmnDNiJlnLW/vmFi46xdzsIndf9I9wSZMU7CixMOyBGxyGI4BXagxEWctf
	hbQKRvMIl138baMBcIgPeFJ28I4ecQ+XfTvg/xYZ0KND19XQC/U6Qib5bIHIlM142IqG
	jOyQDvCVm93kUgV4A9OrbN4yFuRQrBzJ288ydMuw8Kpeok4cld5X3u9PRd7JM75lf6bO
	8XSP83VGGkvz4JTGKeH8h1sxhphT/COkPjHPpOBRwUC25yY5W3i8b/F7B5jR6mtoVmKj
	sbYQ==
X-Received: by 10.112.144.225 with SMTP id sp1mr6090728lbb.97.1446299658909;
	Sat, 31 Oct 2015 06:54:18 -0700 (PDT)
Received: from [192.168.1.41] (ppp91-76-25-247.pppoe.mtu-net.ru.
	[91.76.25.247]) by smtp.gmail.com with ESMTPSA id
	vz2sm2191297lbb.35.2015.10.31.06.54.17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 31 Oct 2015 06:54:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
In-Reply-To: <5633D0C7.2020709@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Error: Malformed IPv6 address
	(bad octet value).
X-Received-From: 2a00:1450:4010:c04::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280580>

30.10.2015 23:19, Vladimir 'φ-coder/phcoder' Serbinenko пишет:
> On 30.10.2015 21:09, Vladimir 'φ-coder/phcoder' Serbinenko wrote:
>> On 30.10.2015 21:06, Vladimir 'φ-coder/phcoder' Serbinenko wrote:
>>> On 30.10.2015 15:26, Andrei Borzenkov wrote:
>>>> See
>>>> http://git.savannah.gnu.org/cgit/grub.git/commit/?id=206676601eb853fc319df14cd3398fbdfde665ac
>>>>
>>>>
>>>> I was not even aware that this is possible. Is there anything on server
>>>> side that can prevent it?
>>>>
>>>> Would be good if commit were amended and force pushed to fix it.
>>>>
>>> It is a bug in SGit. I'll investigate how it happened
>
> I don't have non-fast-forward rights. Does someone from savannah-users
> have them? Could he just delete this commit?

Looking at mail archives, non-fast-forward is global repository property 
and disabled by default. We probably need to open Savannah ticket to get 
it temporary enabled.
