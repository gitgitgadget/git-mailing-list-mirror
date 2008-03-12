From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Wed, 12 Mar 2008 16:53:25 +0100
Message-ID: <FE263BF7-9948-463C-B9B2-833B068EB10B@ai.rug.nl>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <7vbq5k77z0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803121153160.1656@racer.site> <alpine.LFD.1.00.0803121143170.2947@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 16:54:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZTHK-0002cB-9n
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 16:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbYCLPx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 11:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYCLPx1
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 11:53:27 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:1589 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbYCLPx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 11:53:27 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6106.orange.nl (SMTP Server) with ESMTP id 52CAE700008E
	for <git@vger.kernel.org>; Wed, 12 Mar 2008 16:53:26 +0100 (CET)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6106.orange.nl (SMTP Server) with ESMTP id 094EA700008A;
	Wed, 12 Mar 2008 16:53:25 +0100 (CET)
X-ME-UUID: 20080312155326382.094EA700008A@mwinf6106.orange.nl
In-Reply-To: <alpine.LFD.1.00.0803121143170.2947@xanadu.home>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76960>


On Mar 12, 2008, at 4:45 PM, Nicolas Pitre wrote:

>
> 2 weeks is OTOH maybe a bit too conservative.
>
> What about one week instead?

I'd really like it to be at least 2 weeks

- Pieter
