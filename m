From: Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Re: Anonymous commit (empty Author and Committer)
Date: Sat, 31 Oct 2015 16:46:39 +0300
Message-ID: <5634C63F.8050702@gmail.com>
References: <56337DF8.5050802@gmail.com> <5633CDCD.10004@gmail.com>
	<5633CE60.8060907@gmail.com> <5633D0C7.2020709@gmail.com>
	<20151030205955.GC21923@csclub.uwaterloo.ca>
	<0eb2d04aed9a93b38867292bfa6c55f6@mail.kylheku.com>
	<871tcbwmf0.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: savannah-users@gnu.org, savannah-users-bounces+kaz=kylheku.com@gnu.org,
	git@vger.kernel.org, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
To: The development of GNU GRUB <grub-devel@gnu.org>,
	Kaz Kylheku <kaz@kylheku.com>
X-From: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org Sat Oct 31 14:46:51 2015
Return-path: <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>
Envelope-to: gcgsu-savannah-users@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>)
	id 1ZsWUc-0001S3-NT
	for gcgsu-savannah-users@m.gmane.org; Sat, 31 Oct 2015 14:46:50 +0100
Received: from localhost ([::1]:55750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>)
	id 1ZsWUc-0000zh-65
	for gcgsu-savannah-users@m.gmane.org; Sat, 31 Oct 2015 09:46:50 -0400
Received: from eggs.gnu.org ([2001:4830:134:3::10]:44592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arvidjaar@gmail.com>) id 1ZsWUZ-0000zb-GD
	for savannah-users@gnu.org; Sat, 31 Oct 2015 09:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arvidjaar@gmail.com>) id 1ZsWUY-0002l2-Mc
	for savannah-users@gnu.org; Sat, 31 Oct 2015 09:46:47 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:34794)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arvidjaar@gmail.com>)
	id 1ZsWUU-0002fV-CN; Sat, 31 Oct 2015 09:46:42 -0400
Received: by lfaz124 with SMTP id z124so46407667lfa.1;
	Sat, 31 Oct 2015 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=qnpjQsG6R9kSKCjn71S9sO2uq1RSoJpgA4mWyj8JR30=;
	b=QDytiNIVR+wmqWns6Z5qSKNd0jCTjMovkjj/Pf7o8g1kJXxYE/QjPZ3m9vq32cQocw
	OdM+yLgivSBB9MG1VDDND6RACGIJPj5o0nvk92K9QrxgRKPQ1t3O/fM5cRH6URGriWo0
	dy9zP4f4UaDajvJ6DY+SThO7gvSqy1uEfP44p1erHf+XdhEiTm6bcaZhLyZsVKoTf5UO
	TfsDxnVPatKrxvHNJcSV/S03SvK2rh2YBjy225oY3Bt6Yk1XXr5iqeNJqV0O8yUzMZX1
	D/xXejyr53hFE70ah69xLhj/tu5gxKnVWVz9KizYL9PJQW824vbzLSTTBw/S4i/m9fMy
	4WnA==
X-Received: by 10.25.26.71 with SMTP id a68mr4218474lfa.109.1446299201354;
	Sat, 31 Oct 2015 06:46:41 -0700 (PDT)
Received: from [192.168.1.41] (ppp91-76-25-247.pppoe.mtu-net.ru.
	[91.76.25.247]) by smtp.gmail.com with ESMTPSA id
	jj4sm2192232lbc.14.2015.10.31.06.46.39
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 31 Oct 2015 06:46:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
In-Reply-To: <871tcbwmf0.fsf@igel.home>
X-detected-operating-system: by eggs.gnu.org: Error: Malformed IPv6 address
	(bad octet value).
X-Received-From: 2a00:1450:4010:c07::22b
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280578>

31.10.2015 10:02, Andreas Schwab пишет:
> Kaz Kylheku <kaz@kylheku.com> writes:
>
>> Nope. They will have a git in which that commit looks like their own
>> local work. *Someone* will inadvertently do a "git push" to blast out
>> their changes based on that deleted commit, thereby causing it to
>> reappear.
>
> Not if another one pushes something different in the mean time.
>

Which is why I said "amended".
