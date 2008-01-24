From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Files not deleted when merging after a rename
Date: Thu, 24 Jan 2008 08:52:02 +0100
Message-ID: <20080124075202.GB3193@steel.home>
References: <d997e2110801211145o5fe0a1bbpb1e32dd71b70568e@mail.gmail.com> <20080121212015.GB5263@steel.home> <d997e2110801211345x6ee35d48s2038fbd773149110@mail.gmail.com> <20080122072825.GA2971@steel.home> <d997e2110801221808r22f19ec9qc1c452e13c7698df@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Desnoyer <mdesnoyer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 08:52:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHwt4-00023B-Aa
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 08:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbYAXHwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 02:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbYAXHwH
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 02:52:07 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:14490 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbYAXHwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 02:52:06 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKflQ==
Received: from tigra.home (Fab0b.f.strato-dslnet.de [195.4.171.11])
	by post.webmailer.de (klopstock mo63) (RZmta 15.4)
	with ESMTP id 205c33k0O68YNU ; Thu, 24 Jan 2008 08:52:02 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A0825277AE;
	Thu, 24 Jan 2008 08:52:02 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 8216A56D25; Thu, 24 Jan 2008 08:52:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <d997e2110801221808r22f19ec9qc1c452e13c7698df@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71596>

Mark Desnoyer, Wed, Jan 23, 2008 03:08:21 +0100:
> Definitely not Winblows. I try to avoid it even with a 10ft pole. I'm
> running Ubuntu 7.10.

Anything mounted in?

> Could you define "exclusively tracked files"? I'm not sure what you mean here.

I asked if the directories contained something else besides the files
known to git.
