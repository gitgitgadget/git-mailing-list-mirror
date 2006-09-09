From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/4] git-archive: wire up TAR format.
Date: Sat, 09 Sep 2006 17:02:25 +0200
Message-ID: <4502D781.6030708@lsrfire.ath.cx>
References: <450019C3.4030001@innova-card.com>	<11576347252834-git-send-email-vagabon.xyz@gmail.com>	<4501D0CF.70306@lsrfire.ath.cx>	<7vlkouf32i.fsf@assigned-by-dhcp.cox.net> <7vk64derfd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 17:02:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM4Lq-0007LU-GJ
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 17:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWIIPCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 9 Sep 2006 11:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWIIPCb
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 11:02:31 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:31957
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932246AbWIIPCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 11:02:31 -0400
Received: from [10.0.1.3] (p508E5573.dip.t-dialin.net [80.142.85.115])
	by neapel230.server4you.de (Postfix) with ESMTP id 7F6458006;
	Sat,  9 Sep 2006 17:02:29 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk64derfd.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26753>

Junio C Hamano schrieb:
> Just to reduce everybody's pain, why don't I fix them up and
> push out the 4 series in "pu" with attribution clarification and
> review comments from Rene in mind, so that you two can Ack them?
> After that they will be placed on "next".

This is an excellent idea.  What you have in pu is a good base to
add the (few and small) missing pieces.  Consider patches 1-3 ACKed;
I haven't looked at git-upload-archive, yet.

Thanks,
Ren=E9
