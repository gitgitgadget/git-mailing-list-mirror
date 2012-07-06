From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] l10n: de.po: translate 29 new messages
Date: Fri, 06 Jul 2012 20:20:32 +0200
Message-ID: <4FF72C70.1010202@drmicha.warpmail.net>
References: <1341335086-6767-1-git-send-email-ralf.thielow@gmail.com> <2021839.rMjHRWft8I@cs-pc> <CAN0XMO+R3+JiuHSZ0O46py2WbXVh8D2Z+f7t_xofsN6ZrFwnQQ@mail.gmail.com> <m28vf0aqb8.fsf@igel.home> <CAN0XMOJF8+iJqyiqvBxEHOVGMB17rPnO9Pnu29LY1fMDBopKGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Christian Stimming <stimming@tuhh.de>, trast@student.ethz.ch,
	jk@jk.gs, worldhello.net@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 20:20:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnD9A-0003cW-Km
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 20:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531Ab2GFSUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 14:20:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52689 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755814Ab2GFSUq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2012 14:20:46 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D051420E33;
	Fri,  6 Jul 2012 14:20:45 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 06 Jul 2012 14:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ZJxwK0iKHhTpgCJ6SIwloy
	zgKbQ=; b=lW2GW1qvcSuQWhrTrGze2RNNVcKos7TjennuDBNm3pQHF40rxpySZR
	Ovuxoluw/r1GpAMDzU92AKthWk6iVURj9ryzHd8XfMUv/jeAPWZ5PKSV65rCH/iL
	Yv5OvL6WSJOnPV5kmcp4kzm41vk4TkBK/4mjmU08INhJlpHMv07ps=
X-Sasl-enc: K5EIYYt2tD6hsiKXZ2Kp6oCN+VqWYyhL+Ccm1a+GsGI4 1341598845
Received: from localhost.localdomain (unknown [79.199.75.129])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1FBCA483532;
	Fri,  6 Jul 2012 14:20:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120605 Thunderbird/13.0
In-Reply-To: <CAN0XMOJF8+iJqyiqvBxEHOVGMB17rPnO9Pnu29LY1fMDBopKGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201136>

Ralf Thielow venit, vidit, dixit 05.07.2012 20:16:
>>>> Is "rebase" = "Neuaufbau"? My last thought on this wording was "rebase" =
>>>> "Umpflanzen".
>>
>> "Basisumbau"?
>>
> 
> I have added both suggestions to the glossary that they don't get lost when
> we discuss about non-optimal and/or missing parts within the glossary.

Not the base is being reconstructed, but what's on top of it. So,
"Basiswechsel" would be more appropriate.

But: "Umpflanzen" is really a great term which stays within the context
of trees, roots and branches. Strictly speaking, "Umpflanzen" refers to
something you do at the root level. The corresponding action for
branches would be "Umpfropfen". I think that also conveys the effort
that is sometimes necessary ;)

Michael
