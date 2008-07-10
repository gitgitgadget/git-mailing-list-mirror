From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: THREADED_DELTA_SEARCH
Date: Fri, 11 Jul 2008 00:19:22 +0200
Message-ID: <20080710221922.GA3665@steel.home>
References: <20080710075327.GD24819@artemis.madism.org> <7vy749pxbe.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807101212000.12484@xanadu.home> <20080710201352.GA3717@blimp.local> <alpine.LFD.1.10.0807101625330.12484@xanadu.home> <20080710202919.GB3717@blimp.local> <alpine.LFD.1.10.0807101633480.12484@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:20:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4Uz-0004sb-0l
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbYGJWTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbYGJWTZ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:19:25 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:10499 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbYGJWTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:19:24 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jO9V
Received: from tigra.home (Fa95a.f.strato-dslnet.de [195.4.169.90])
	by post.webmailer.de (mrclete mo51) (RZmta 16.47)
	with ESMTP id a00734k6AKjjwy ; Fri, 11 Jul 2008 00:19:22 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6A9D8277BD;
	Fri, 11 Jul 2008 00:19:22 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2FE3F56D2A; Fri, 11 Jul 2008 00:19:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807101633480.12484@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88016>

Nicolas Pitre, Thu, Jul 10, 2008 22:36:35 +0200:
> > There are just systems were resources are a problem.
> 
> Then on those systems you simply have to adjust the appropriate knob.  

_after_ they crashed?
