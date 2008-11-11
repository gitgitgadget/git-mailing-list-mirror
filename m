From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Tue, 11 Nov 2008 09:27:27 +0200
Message-ID: <491933DF.3060307@dawes.za.net>
References: <200811101522.13558.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 08:31:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kznid-0003zm-0x
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 08:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbYKKH36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 02:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbYKKH35
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 02:29:57 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:35472 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbYKKH35 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 02:29:57 -0500
Received: from spunkymail-a17.g.dreamhost.com (sd-green-bigip-177.dreamhost.com [208.97.132.177])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 448B0178823
	for <git@vger.kernel.org>; Mon, 10 Nov 2008 23:29:56 -0800 (PST)
Received: from [192.168.201.100] (dsl-243-206-70.telkomadsl.co.za [41.243.206.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a17.g.dreamhost.com (Postfix) with ESMTP id E7991734F2;
	Mon, 10 Nov 2008 23:28:13 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <200811101522.13558.fg@one2team.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100627>

Francis Galiegue wrote:
> Hello,
> 
> A very nice git feature, without even going as far as merges, is the cherry 
> pick feature.
> 
> For this to be doable from within the Eclipse Git plugin, a diff/patch 
> implementation needs to be found, in a license compatible with the current 
> JGit license (3-clause BSD, as far as I can tell). Or a new implementation 
> can be rewritten from scratch, of course.

Shouldn't Eclipse already *have* a diff/patch implementation, for its 
other "team work" plugins?

Rogan
