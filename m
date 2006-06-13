From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH 0/8] Make a couple of commands builtin
Date: Tue, 13 Jun 2006 22:21:21 +0200
Organization: Chalmers
Message-ID: <448F1E41.1040607@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Jun 13 22:21:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqFOE-0006QV-3S
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 22:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWFMUV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 16:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWFMUV1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 16:21:27 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:28558 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932198AbWFMUV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 16:21:26 -0400
Received: from [192.168.0.82] (213.66.93.165) by pne-smtpout2-sn2.hy.skanova.net (7.2.072.1)
        id 44897AB8000E71EA; Tue, 13 Jun 2006 22:21:22 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21804>

This patchseries has the ultimate goal of making
git-am a builtin.

The version of git-am I'm sending out makes quite heavy
use of system(), but I think that can be worked around.
I just haven't figured out how, yet.

/Lukas
