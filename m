From: Stephan Springl <springl-git@bfw-online.de>
Subject: Re: [PATCH] Use git-for-each-ref to check whether the origin branch
 exists.
Date: Wed, 23 May 2007 13:59:29 +0200 (MSZ)
Message-ID: <Pine.LNX.4.64.0705231351220.19399@lar.bfw.de>
References: <Pine.LNX.4.64.0705230909310.25524@lar.bfw.de>
 <Pine.LNX.4.64.0705231153000.4113@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 23 13:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqpVA-0001v6-5R
	for gcvg-git@gmane.org; Wed, 23 May 2007 13:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921AbXEWL7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 07:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758483AbXEWL7c
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 07:59:32 -0400
Received: from mail.bfw-online.de ([62.245.186.164]:41180 "EHLO
	mail.bfw-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbXEWL7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 07:59:31 -0400
Received: from [192.168.222.4] (helo=lar.bfw.de ident=springl)
	by mail.bfw-online.de with esmtp (Exim 4.51)
	id 1HqpV3-00060j-Oj; Wed, 23 May 2007 13:59:29 +0200
In-Reply-To: <Pine.LNX.4.64.0705231153000.4113@racer.site>
X-SA-Exim-Connect-IP: 192.168.222.4
X-SA-Exim-Mail-From: springl-git@bfw-online.de
X-SA-Exim-Scanned: No (on mail.bfw-online.de); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48153>

On Wed, 23 May 2007, Johannes Schindelin wrote:

> From: Stephan Springl <springl-git@bfw-online.de>
> This works in repositories that have their refs packed by
> "git-pack-refs --all --prune" whereas testing the file
> $git_dir/refs/heads/$opt_o does not.
>
> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>  Unfortunately your patch is white-space corrupted (it has an extra
>  space on all lines starting with a space, it seems). Therefore I
>  redid it with this email.
Sorry for that especially as we are very very strict with whitespace and 
coding conventions in our own development ... arrg. Thanks anyway.

Stephan
