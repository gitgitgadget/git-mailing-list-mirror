From: Vincent Hanquez <tab@snarc.org>
Subject: Re: moving to a git-backed wiki
Date: Wed, 02 Feb 2011 09:55:00 +0000
Message-ID: <4D4929F4.3020805@snarc.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org> <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org> <20110131225529.GC14419@sigill.intra.peff.net> <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com> <20110201201144.GA16003@sigill.intra.peff.net> <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com> <4D488DCD.3080305@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Wed Feb 02 11:01:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkZWc-0000ZH-2W
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 11:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab1BBKBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 05:01:16 -0500
Received: from cerberus.snarc.org ([212.85.155.21]:37871 "EHLO
	cerberus.snarc.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1BBKBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 05:01:15 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Feb 2011 05:01:15 EST
Received: from [192.168.1.2] (cpc5-cmbg15-2-0-cust157.5-4.cable.virginmedia.com [86.30.204.158])
	by cerberus.snarc.org (Postfix) with ESMTPSA id AB0CC129F6;
	Wed,  2 Feb 2011 09:55:00 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100821 Icedove/3.1.2
In-Reply-To: <4D488DCD.3080305@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165901>

  On 01/02/11 22:48, J.H. wrote:
> The wiki will almost universally have a "central site" no matter what
> the backend.  Personally I see little advantage to having a git backed
> wiki myself.
with git based wiki, you can clone the whole wiki on your local machine, 
and read/edit/commit on it locally using standard editor tool (i.e. 
$EDITOR). and the history/revision/diff is completely built-in.

-- 
Vincent
