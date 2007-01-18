From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] Document the master@{n} reflog query syntax.
Date: Thu, 18 Jan 2007 11:33:03 +0100
Message-ID: <45AF4CDF.5010406@op5.se>
References: <20070118020804.GA23488@spearce.org> <Pine.LNX.4.64.0701171829240.27034@elephant.stardot-tech.com> <20070118025003.GC23124@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jim Treadway <jim@stardot-tech.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 11:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Ua8-0008El-3v
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 11:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbXARKdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 05:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbXARKdJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 05:33:09 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:38038 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbXARKdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 05:33:07 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 1A6A36BCC8; Thu, 18 Jan 2007 11:33:06 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070118025003.GC23124@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37076>

Shawn O. Pearce wrote:
> Jim Treadway <jim@stardot-tech.com> wrote:
>> On Wed, 17 Jan 2007, Shawn O. Pearce wrote:
>>> -  of the ref at a prior point in time.  This suffix may only be
>>> +  of the ref at a prior point in time.This suffix may only be
>> I'm guessing that the above was unintentional?
> 
> Yes.  Danngit.  Junio, can you hand edit that patch?
> 

I'm starting to see --amend as an extremely useful thing to have, and 
I'm sure Junio thinks the same. For fixes this small, it sure is easier 
to just --amend the commit than to ask for a new patch to apply.

Out of curiousity, how many other SCM's allow you to --amend a commit?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
