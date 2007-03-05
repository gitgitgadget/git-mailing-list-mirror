From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Begin SubmittingPatches with a check list
Date: Mon, 5 Mar 2007 15:52:26 -0500
Message-ID: <86B5B6C7-F53E-4272-95F8-90DEA33430BA@silverinsanity.com>
References: <200703050823.l258NgT9008266@localhost.localdomain> <20070305095101.GA792@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0703051554240.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070305150418.GD3481@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0703051631350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Xavier Maillard <zedek@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 21:52:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOKAq-0002qA-NE
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 21:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbXCEUwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 15:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbXCEUwc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 15:52:32 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:58022 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbXCEUwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 15:52:31 -0500
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 3706F1FFC143;
	Mon,  5 Mar 2007 20:52:29 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.63.0703051631350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41485>


On Mar 5, 2007, at 10:37 AM, Johannes Schindelin wrote:

> +	- use "git format-patch -M" to create the patch

The docco for git-format-patch doesn't list -M as one of it's  
options.  Is this one of the diff-options, and does it take all of  
the options git-diff does?  If so, this should be mentioned in the  
documentation.

~~ Brian
