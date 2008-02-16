From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH 1/2] Documentation: Remove deprecated --mixed option in git-reset synopsis
Date: Sat, 16 Feb 2008 20:17:14 +0100
Message-ID: <7732B3AD-BF81-4BDD-9C9C-01A35185AE99@ai.rug.nl>
References: <1203180526-12020-1-git-send-email-pdebie@ai.rug.nl> <7vir0o90hr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 20:17:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQSXo-0008E8-6h
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311AbYBPTRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 14:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbYBPTRR
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:17:17 -0500
Received: from smtp-3.orange.nl ([193.252.22.243]:26250 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756271AbYBPTRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 14:17:17 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6203.orange.nl (SMTP Server) with ESMTP id 295D81C00085
	for <git@vger.kernel.org>; Sat, 16 Feb 2008 20:17:15 +0100 (CET)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6203.orange.nl (SMTP Server) with ESMTP id 008FD1C00081;
	Sat, 16 Feb 2008 20:17:14 +0100 (CET)
X-ME-UUID: 20080216191715238.008FD1C00081@mwinf6203.orange.nl
In-Reply-To: <7vir0o90hr.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74064>


On Feb 16, 2008, at 8:15 PM, Junio C Hamano wrote:

> Thanks, but the title should read "redundant, unnecessary", not
> "deprecated", I think.

Well, if I run it:

     bash-3.2$ git reset --mixed -- NEWS
     warning: --mixed option is deprecated with paths.

I included deprecated because it says so in the warning

- Pieter
