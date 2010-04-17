From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [BUG] Git add <device file> silently fails
Date: Sat, 17 Apr 2010 17:00:22 +0200
Organization: SUSE Labs
Message-ID: <201004171700.22851.agruen@suse.de>
References: <201004171624.17797.agruen@suse.de> <u2s81b0412b1004170744u4cc3c0e1z6d7019fe405a67ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 17:00:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O39Vi-0003Ek-T2
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 17:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab0DQPAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 11:00:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48978 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab0DQPAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 11:00:25 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 4429986A2E;
	Sat, 17 Apr 2010 17:00:24 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <u2s81b0412b1004170744u4cc3c0e1z6d7019fe405a67ec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145150>

On Saturday 17 April 2010 16:44:05 Alex Riesen wrote:
> I think something like this should make the accident more
> noticable:

Doesn't actually tell what the problem might be, though.

Thanks,
Andreas
