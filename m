From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git v1.8.1-rc0
Date: Tue, 04 Dec 2012 15:12:45 +0100
Message-ID: <50BE04DD.6050901@drmicha.warpmail.net>
References: <7vip8iq1vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 15:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TftF9-0000xF-9x
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 15:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab2LDOMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 09:12:47 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44675 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751444Ab2LDOMq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2012 09:12:46 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id F27ED20AA8;
	Tue,  4 Dec 2012 09:12:45 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 04 Dec 2012 09:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=WuDSpbjXeM6kT/mDrmvtR/
	sr4qg=; b=rWb9USoO6ljrrnJr2zmsTst/M3VdQ5i58s5wUp4ol9uZPZ9FxN194p
	uOS0XqTCk5OCTaGnTNE9PIGwPy2JIM+eaoftj7f8W06JGuv6TIVKkZfsvcSdTsD9
	vKfO/dXSItDOAHuhj/2ro9/0UNpJUSck3lW6FmjOgugGPIhdAkpss=
X-Sasl-enc: iakHUmE+TxJosRzAciLu4xQOgaisOjsAPmxDAq/gO6cH 1354630365
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 70BD64825B3;
	Tue,  4 Dec 2012 09:12:45 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vip8iq1vs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211083>

While not being a huge problem, you may or may not want to correct one
commit message:

*   aaf5ad5 (origin/next, gitster/next) Sync with 1.8.0-rc0
|\
| * ee26a6e (tag: v1.8.1-rc0, origin/master, origin/HEAD,
gitster/master) Git 1.8.1-rc0

Cheers,
Michael
