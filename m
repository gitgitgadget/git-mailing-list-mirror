From: Wincent Colaiuta <win@wincent.com>
Subject: Re: A few usability question about git diff --cached
Date: Fri, 5 Oct 2007 12:27:24 +0200
Message-ID: <0A7AA9C3-6D9E-4B14-822D-05232F0EAF99@wincent.com>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com> <5ACC5CA7-8314-4035-94EC-190138A25EBD@wincent.com> <buoejga14qg.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 12:28:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdkPy-0006DO-Jv
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 12:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbXJEK1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 06:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbXJEK1h
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 06:27:37 -0400
Received: from wincent.com ([72.3.236.74]:53310 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759115AbXJEK1f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 06:27:35 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l95ARVml007701;
	Fri, 5 Oct 2007 05:27:32 -0500
In-Reply-To: <buoejga14qg.fsf@dhapc248.dev.necel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60066>

El 5/10/2007, a las 7:59, Miles Bader escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>> You're probably right that the option name is confusing, I guess
>> changing it to "--index" would be a good idea, continuing to support
>> "--cached" but marking it as deprecated before finally removing it a=
t
>> some point in the future.
>
> Personally all I want is a short-option alias for --cached!
>
> Hopefully something easily type-able (not uppercase)...

Did you see the aliases I posted earlier in the thread? I can't think =20
of anything shorter or semantically clearer than "staged" and =20
"unstaged".

Cheers,
Wincent
