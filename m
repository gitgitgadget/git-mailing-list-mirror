From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/6] Teach --id/-d to "git status"
Date: Wed, 5 Aug 2009 20:33:13 +0200
Message-ID: <20090805183313.GB13166@blimp.localdomain>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com> <1249465906-3940-2-git-send-email-ayiehere@gmail.com> <81b0412b0908051111g4433e12epa540e0a2f07b62b@mail.gmail.com> <fabb9a1e0908051125m3eecb065m5fb4ea2b55f69b91@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlJZ-0000fZ-JZ
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbZHESdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbZHESdQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:33:16 -0400
Received: from mout1.freenet.de ([195.4.92.91]:58365 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbZHESdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:33:15 -0400
Received: from [195.4.92.19] (helo=9.mx.freenet.de)
	by mout1.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MYlIZ-0006U7-BS; Wed, 05 Aug 2009 20:33:15 +0200
Received: from x76cc.x.pppool.de ([89.59.118.204]:48675 helo=tigra.home)
	by 9.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #93)
	id 1MYlIZ-00020Z-38; Wed, 05 Aug 2009 20:33:15 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 563D7277D8;
	Wed,  5 Aug 2009 20:33:14 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 158DD36D28; Wed,  5 Aug 2009 20:33:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0908051125m3eecb065m5fb4ea2b55f69b91@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-purgate-ID: 149285::1249497195-00007910-3A636C53/0-0/0-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124948>

Sverre Rabbelier, Wed, Aug 05, 2009 20:25:43 +0200:
> Heya,
> 
> On Wed, Aug 5, 2009 at 11:11, Alex Riesen<raa.lkml@gmail.com> wrote:
> > What is it for?
> 
> See [PATCH 0/6].
> 

Complicated solution to a non-existing problem.

Nazri, have you ever tried "git gui"? (or tig, for console?)
