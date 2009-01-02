From: jidanni@jidanni.org
Subject: Re: [PATCH] Documentation/git-bundle.txt: Dumping contents of any bundle
Date: Fri, 02 Jan 2009 08:10:30 +0800
Message-ID: <878wputvnt.fsf@jidanni.org>
References: <20090101234815.GA9049@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: johannes.schindelin@gmx.de, nico@cam.org, gitster@pobox.com,
	mdl123@verizon.net, spearce@spearce.org, git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Fri Jan 02 01:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIXds-0001eN-KV
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 01:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbZABAKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 19:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbZABAKf
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 19:10:35 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:58745 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750911AbZABAKe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 19:10:34 -0500
Received: from jidanni.org (122-127-33-68.dynamic.hinet.net [122.127.33.68])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id A8205119DEA;
	Thu,  1 Jan 2009 16:10:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104347>

JK> diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
OK, I wish you luck in the fruition of the new --dump-delta option, and
can proofread the man pages involved, otherwise this is no area for
junior programmer me.
