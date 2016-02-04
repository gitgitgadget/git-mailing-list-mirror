From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: git worktree (was: [PATCH v3 1/6] worktree: new repo extension to manage worktree behaviors)
Date: Thu, 04 Feb 2016 13:12:11 -0500
Message-ID: <jwvfux8uzki.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-2-git-send-email-pclouds@gmail.com>
	<xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
	<20160130142039.GB4978@wheezy.local>
	<xmqqh9htya2e.fsf@gitster.mtv.corp.google.com>
	<jwvfuxd17bz.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<CACsJy8DGsDFnX57eQ7rN2hkOR3Wuw_eQ9ED4e-9FhAm30sBFEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 19:12:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aROOS-0004JR-CW
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 19:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbcBDSMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 13:12:22 -0500
Received: from plane.gmane.org ([80.91.229.3]:49638 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbcBDSMV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 13:12:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aROOB-0003zu-AZ
	for git@vger.kernel.org; Thu, 04 Feb 2016 19:12:19 +0100
Received: from 69-196-166-146.dsl.teksavvy.com ([69.196.166.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 19:12:19 +0100
Received: from monnier by 69-196-166-146.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 19:12:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 69-196-166-146.dsl.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:0tii+5zyD+6d+imD9DMunEV6Iak=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285477>

>> As a heavy user of the git-new-worktree "hack / script", is there
>> something I can do to help "get more experience"?
> You can try out "git worktree" command (in "lab" environment) and see
> what's missing, what use cases of yours it does not support.

Cool, didn't know about it, and it's even already in Debian testing!
Using it right now.  So far so good,


        Stefan
