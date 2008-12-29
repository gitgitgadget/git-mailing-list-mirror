From: jidanni@jidanni.org
Subject: Re: git-add --verbose should say when something is already indexed
Date: Tue, 30 Dec 2008 06:55:56 +0800
Message-ID: <874p0m4mmb.fsf@jidanni.org>
References: <7v63l3e4lz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@lavabit.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 29 23:59:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHR4m-0001uR-5g
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 23:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYL2W5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 17:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYL2W5j
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 17:57:39 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:60608 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751847AbYL2W5j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 17:57:39 -0500
Received: from jidanni.org (122-127-33-187.dynamic.hinet.net [122.127.33.187])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 0ADFAD273B;
	Mon, 29 Dec 2008 14:57:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104138>

DESCRIPTION
       This command adds the current content of new or modified files to the index, thus staging that content for
       inclusion in the next commit.

Maybe also mention that it also adds a new path to be tracked by the
index, if it is not tracked already.
