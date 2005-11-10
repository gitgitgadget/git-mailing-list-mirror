From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Add --pretty=fuller
Date: Thu, 10 Nov 2005 08:42:57 -0600
Message-ID: <E1EaDdh-0007qo-E2@jdl.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 15:43:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaDdy-0007NW-9c
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 15:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVKJOnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 09:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbVKJOnI
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 09:43:08 -0500
Received: from jdl.com ([66.118.10.122]:54998 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750877AbVKJOnH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 09:43:07 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EaDdh-0007qo-E2
	for git@vger.kernel.org; Thu, 10 Nov 2005 08:42:58 -0600
To: git@vger.kernel.org
In-Reply-To: 43730EBD.90307@op5.se
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11486>


Andreas wrote:

> --show-author=date,timestamp,name
> --show-committer=name,time
> --show=name,date (for both author and committer)
> 
> or some such, with --pretty=<something> just a short-hand for those 
> show-options?

Which just looks like a candidate for the [log]
section of the config file to me.  Or is the "git log"
output needing to be standardized enough that this
level of flexability is a bad idea?  Dunno.

jdl
