From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGIT] [PATCH RFC v1 0/5] Add (static) ignore functionality to
 EGit
Date: Sun, 29 Mar 2009 12:43:24 +0200
Message-ID: <49CF50CC.10400@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl> <200903291123.24433.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 12:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnsVj-0001kK-Tm
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 12:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbZC2Knd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 06:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbZC2Knc
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 06:43:32 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:55474 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751359AbZC2Knc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 06:43:32 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 8E9D558BD88;
	Sun, 29 Mar 2009 12:43:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200903291123.24433.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115014>

Robin Rosenberg wrote:
> A quick reply (I might come up with more later): Ignore support should be mostly
> in jgit, with only extensions into egit.
> 
> -- robin
I discussed this with shawn and proposed to first implement it in egit
and when we have it right then move it into jgit. I think shawn agreed
with that.

Ferry
