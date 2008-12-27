From: jidanni@jidanni.org
Subject: Re: commit.template
Date: Sat, 27 Dec 2008 08:01:18 +0800
Message-ID: <87hc4qscz5.fsf@jidanni.org>
References: <200812261750.12204.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nanako3@lavabit.com
To: bss@iguanasuicide.net
X-From: git-owner@vger.kernel.org Sat Dec 27 01:02:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGMdi-0005RI-Ru
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 01:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbYL0ABW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 19:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYL0ABW
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 19:01:22 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:49699 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752191AbYL0ABV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2008 19:01:21 -0500
Received: from jidanni.org (122-127-32-218.dynamic.hinet.net [122.127.32.218])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id C57C6D26C4;
	Fri, 26 Dec 2008 16:01:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103964>

OK, both
>> 1) man git-config mentions
>> commit.template
and
BSS> git commit --help tells how this configuration option is used, in the 
BSS> documentation of the "-t" option.
should
>> mention what file is being used presently
as one needs a template in order to modify a template... in case
someone one day wants to. Not me. I'm happy already.
