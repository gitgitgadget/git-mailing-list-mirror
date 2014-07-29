From: Nico Williams <nico@cryptonector.com>
Subject: Is there a way to mark a branch as published?
Date: Tue, 29 Jul 2014 17:40:45 -0500
Message-ID: <CAK3OfOjPQ1fcoA7O6EDcQ3iW_AdsjitK4WKSdLwpRRXm8xfrVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:40:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCG4h-000545-4i
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 00:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbaG2Wkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 18:40:47 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:48982 "EHLO
	homiemail-a27.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998AbaG2Wkq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 18:40:46 -0400
Received: from homiemail-a27.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a27.g.dreamhost.com (Postfix) with ESMTP id 92175598065
	for <git@vger.kernel.org>; Tue, 29 Jul 2014 15:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:date:message-id:subject:from:to:content-type; s=
	cryptonector.com; bh=uDdLZrmrwMI4/bFFyDfV7uywYOE=; b=Ob5L14qtDlG
	npBmgENyIS2kaNb7R3Fa4q40vubcA9D0TppsbLgDLszxXVe/tj2jlMBQbbszKzQA
	WMonVw2yqr61Ccl5mjH+I6PhfITn7R81C004zWNE9PU6NsMMBPKMRRt14194eMM1
	5oGAL/m2ek47Xe8e7aoEjrEtfUFQnSEQ=
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com [209.85.223.170])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a27.g.dreamhost.com (Postfix) with ESMTPSA id 768BB598060
	for <git@vger.kernel.org>; Tue, 29 Jul 2014 15:40:46 -0700 (PDT)
Received: by mail-ie0-f170.google.com with SMTP id rl12so381050iec.15
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 15:40:46 -0700 (PDT)
X-Received: by 10.50.138.11 with SMTP id qm11mr1377500igb.18.1406673646006;
 Tue, 29 Jul 2014 15:40:46 -0700 (PDT)
Received: by 10.107.128.169 with HTTP; Tue, 29 Jul 2014 15:40:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254476>

(or all of a repo's branches)

Teamware recorded whether it had any "children" and warned about
rebasing published contents.  Perhaps git could do the same.

Nico
--
