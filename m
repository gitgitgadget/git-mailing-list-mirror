From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] gitk: chmod +x po2msg
Date: Tue, 03 Dec 2013 21:03:53 +0100
Message-ID: <87pppdn1li.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <xmqqsiubqd78.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 21:04:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnwCe-0003n6-5V
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 21:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354Ab3LCUEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 15:04:11 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:43787 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164Ab3LCUEK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 15:04:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 337DA4D6563;
	Tue,  3 Dec 2013 21:04:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wiHUu3ZakLxA; Tue,  3 Dec 2013 21:03:54 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id D6FB04D64C4;
	Tue,  3 Dec 2013 21:03:53 +0100 (CET)
In-Reply-To: <xmqqsiubqd78.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 02 Dec 2013 11:12:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238728>

Junio C Hamano <gitster@pobox.com> writes:

>  * Paul, I forgot to forward this to you.  Could you apply it to
>    your tree?  I see you have updates up to ce2c58cd (gitk:
>    Recognize -L option, 2013-11-16), which I'll be pulling into my
>    tree shortly.

When you pull, can you pick up the "other half" of the series that led
up to ce2c58cd?

  http://thread.gmane.org/gmane.comp.version-control.git/227151/focus=237937

-- 
Thomas Rast
tr@thomasrast.ch
