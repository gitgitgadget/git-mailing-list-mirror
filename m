From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git & Paramiko: failed to push some refs to ...
Date: Tue, 20 Jul 2010 12:18:51 +0200
Message-ID: <201007201218.51717.trast@student.ethz.ch>
References: <AANLkTil0soA4pLGRZT-jgdOkB3s8qApG_h2a-UW2P_G5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Philip Kimmey <philip.kimmey@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 12:19:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob9ue-0000Mm-8o
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 12:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab0GTKS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 06:18:56 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:39645 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892Ab0GTKSy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 06:18:54 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 20 Jul
 2010 12:18:52 +0200
Received: from thomas.localnet (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Tue, 20 Jul
 2010 12:18:52 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.5; x86_64; ; )
In-Reply-To: <AANLkTil0soA4pLGRZT-jgdOkB3s8qApG_h2a-UW2P_G5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151310>

Philip Kimmey wrote:
> If you prefer you can see the outline of my question at stackoverflow,
> with better formatting than e-mail will afford:
> 
> http://stackoverflow.com/questions/3262161/git-failed-to-push-some-refs-to-with-custom-git-bridge

That has a lot more information.  Please include it in the email next
time.

> To git@localhost:/pckprojects/heyworld/
>    d83f744..404debd  master -> master
> error: failed to push some refs to 'git@localhost:/pckprojects/heyworld/'

A *very* stupid guess:  Are you reporting back the exit status
correctly?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
