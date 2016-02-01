From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH v3 1/6] worktree: new repo extension to manage worktree behaviors
Date: Sun, 31 Jan 2016 21:47:12 -0500
Message-ID: <jwva8nl171f.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-2-git-send-email-pclouds@gmail.com>
	<xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
	<20160130142039.GB4978@wheezy.local>
	<xmqqh9htya2e.fsf@gitster.mtv.corp.google.com>
	<jwvfuxd17bz.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 03:47:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ4WS-0003If-Tp
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 03:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933654AbcBACrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 21:47:21 -0500
Received: from plane.gmane.org ([80.91.229.3]:49393 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933650AbcBACrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 21:47:20 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aQ4WM-00034C-Ga
	for git@vger.kernel.org; Mon, 01 Feb 2016 03:47:18 +0100
Received: from 76-10-146-127.dsl.teksavvy.com ([76.10.146.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Feb 2016 03:47:18 +0100
Received: from monnier by 76-10-146-127.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Feb 2016 03:47:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 76-10-146-127.dsl.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cancel-Lock: sha1:ZYrmUO5L2iXWvh7OBkC+GJXJgfc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285181>

> As a heavy user of the git-new-worktree "hack / script", is there
                         ^^^^^^^^^^^^^^^^
                         git-new-workdir
Sorry,


        Stefan
