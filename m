From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Mon, 18 Aug 2008 19:28:22 +0200
Message-ID: <20080818172822.GB6014@blimp.local>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <20080814064524.GA4379@blimp.local> <48A43B2A.7010702@griep.us> <20080814185131.GA14858@steel.home> <20080815092249.GA6024@artemis.madism.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 19:29:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV8Xu-0004BK-VQ
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 19:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbYHRR20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 13:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754679AbYHRR20
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 13:28:26 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:44806 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbYHRR2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 13:28:25 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44getV
Received: from tigra.home (Fa92c.f.strato-dslnet.de [195.4.169.44])
	by post.webmailer.de (mrclete mo38) (RZmta 16.47)
	with ESMTP id j02b4ek7IGqZGW ; Mon, 18 Aug 2008 19:28:23 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id E6849277AE;
	Mon, 18 Aug 2008 19:28:22 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id D752136D1A; Mon, 18 Aug 2008 19:28:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080815092249.GA6024@artemis.madism.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92720>

Pierre Habouzit, Fri, Aug 15, 2008 11:22:50 +0200:
> 
> But --help is not as terse as -h is, and it would be going backwards
> not having it anymore.
> 

BTW, ls-remote (which is not ported to the options handling code yet)
also has "-h" (short for "--heads").
