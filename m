From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN
 cc
Date: Tue, 20 Nov 2007 19:06:44 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711201901280.4732@bianca.dialin.t-online.de>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
 <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
 <7vd4ua3hww.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711191847550.7957@bianca.dialin.t-online.de>
 <7vhcjhl3ni.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711201823460.4280@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 19:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuXV5-0001YO-PC
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757879AbXKTSGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757687AbXKTSGu
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:06:50 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57516 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757548AbXKTSGt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2007 13:06:49 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 1716D48DBB
	for <git@vger.kernel.org>; Tue, 20 Nov 2007 13:06:49 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 20 Nov 2007 13:06:49 -0500
X-Sasl-enc: aQLmrLzNiNAierocNYvdtX2iBsurfXdV4dJ/BF//UJFC 1195582008
Received: from [192.168.2.101] (p549A271E.dip0.t-ipconnect.de [84.154.39.30])
	by mail.messagingengine.com (Postfix) with ESMTP id 74AB493B7
	for <git@vger.kernel.org>; Tue, 20 Nov 2007 13:06:48 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711201823460.4280@bianca.dialin.t-online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65554>

> sorry for the whitespace-issues. I have attached the patch again with 
> improved log message and will turn off format-flawed for this email.

only for the list: I noticed another whitespace problem and have meanwhile 
sent the patch to Junio as true attachment of a private email because I do 
not know whether attachments are accepted on this list (most likely they 
are not). Sorry for the inconvenience.

Regards

Guido
