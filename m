From: Jonas Bernoulli <jonas@bernoul.li>
Subject: Re: Empty config sections are neither deleted nor reused
Date: Sat, 14 May 2016 20:54:28 +0200
Message-ID: <878tzc1ndn.fsf@bernoul.li>
References: <87r3d6knwo.fsf@bernoul.li> <xmqqeg95aor6.fsf@gitster.mtv.corp.google.com> <877fewzseg.fsf@bernoul.li> <vpq37pk7k08.fsf@anie.imag.fr> <xmqqfutk8ryy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 20:54:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1ei3-0007qG-0v
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 20:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbcENSyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 14:54:37 -0400
Received: from mail.hostpark.net ([212.243.197.30]:43664 "EHLO
	mail.hostpark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbcENSyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 14:54:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hostpark.net (Postfix) with ESMTP id F26A416B39;
	Sat, 14 May 2016 20:54:33 +0200 (CEST)
X-Virus-Scanned: by Hostpark/NetZone Mailprotection at hostpark.net
Received: from mail.hostpark.net ([127.0.0.1])
	by localhost (mail1.hostpark.net [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id wtT_MPag-G3O; Sat, 14 May 2016 20:54:33 +0200 (CEST)
Received: from hal (80-218-86-217.dclient.hispeed.ch [80.218.86.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hostpark.net (Postfix) with ESMTPSA id C12B816B35;
	Sat, 14 May 2016 20:54:33 +0200 (CEST)
User-agent: mu4e 0.9.17; emacs 25.0.93.1
In-reply-to: <xmqqfutk8ryy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294624>


Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio's explanation must not necessarily be read as "it has to be the
>> way it is", but more as "getting it right is harder than you think", and
>> that in turn explains why no one changed the behavior.
>
> Thanks for clarification.  s/must not necessarily/must not/;

That's how I read it too ;-)

Apparently my reply left more room for interpretation.
