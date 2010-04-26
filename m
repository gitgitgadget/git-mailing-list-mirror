From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: No way to have global diff settings? (global .gitattributes feature request)
Date: Mon, 26 Apr 2010 15:44:20 +0200
Message-ID: <87och6ib0r.fsf@gmail.com>
References: <87zl0wd9ce.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 15:44:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6ObQ-0007A3-9F
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 15:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab0DZNnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 09:43:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:15829 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab0DZNnr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 09:43:47 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2548890fga.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:in-reply-to
         :references:user-agent:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=fkXlhIT9eH+L0+Dhvtq88HMd1uIE9e0+nXDdnn/iTiM=;
        b=TOs0F5j9rGOQqtqVDHq8bRvqB24nV9VghQnsARiPQzjpIaCU5xPd8Nr+5eFdwq36GG
         57eRaeKuNZthe3WKZ0vnNGgC5FGKIg2kxnZDISsbgltbleuxkqSOgVZoW49R4SpIvRLm
         Tp40TZ+QvY3Hr/wbmh6X1NC1ORCVb/CEv/Ut4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:in-reply-to:references:user-agent:date:message-id
         :mime-version:content-type:content-transfer-encoding;
        b=obE/CSS4RNrEILLxgHXh07z22v1J/OYk4b8NugHSTo3NvwPt1F5jHhaIkyDjOdVXAH
         nM1ElWWfoOIC4MAYgk0yjN23WwQ8/EpKypIhYSeuQnJpY/lCIjJMCmmRlambAsOSkzNj
         +g/mmNBcfLJ69k5KNZfd87L7vdlEQT08vnhAI=
Received: by 10.87.64.29 with SMTP id r29mr7369717fgk.6.1272289425774;
        Mon, 26 Apr 2010 06:43:45 -0700 (PDT)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id 4sm6676549fge.3.2010.04.26.06.43.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 06:43:44 -0700 (PDT)
In-Reply-To: <87zl0wd9ce.fsf@gmail.com> (=?utf-8?B?IsWgdMSbcMOhbiBOxJtt?=
 =?utf-8?B?ZWMiJ3M=?= message of "Wed, 21
	Apr 2010 19:05:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145817>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:

> Hello,
>
> it seems there is no global .gitattribute equivalent to .gitignore or
> .gitconfig. Wouldn't it make much sense to have one? Failing that, th=
ere
> really should be a way to specify some global diff options at least.
>
> My use case:
>
> I wanted to specify something like -F "^(" to git diff for lisp files=
=2E
> But well, git diff has no -F option! So shruggar from #git pointed me=
 to
> gitattributes. OK, that's great and works, but now I have to put
> .gitattributes or info/attributes to all repos with lisp files in the=
m?
> That rather sucks, if you ask me.
>
> So I would like to ask if there is a way, and if not, if it could be
> considered a useful feature addition.
>
> Thanks,
>
>   =C5=A0t=C4=9Bp=C3=A1n

PING
