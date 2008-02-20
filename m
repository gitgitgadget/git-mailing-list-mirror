From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add support for host aliases in config files
Date: Tue, 19 Feb 2008 17:04:46 -0800
Message-ID: <7vve4ke8up.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802182317520.5816@iabervon.org>
 <47BAF18F.5040709@freescale.com>
 <alpine.LNX.1.00.0802191127080.19024@iabervon.org>
 <7vy79ghbob.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802191856420.19024@iabervon.org>
 <alpine.LSU.1.00.0802200156560.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jon Loeliger <jdl@freescale.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdPD-0007tI-63
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 02:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475AbYBTBFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 20:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757042AbYBTBFS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 20:05:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbYBTBFR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 20:05:17 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C3AC58292;
	Tue, 19 Feb 2008 20:05:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 C82FB8290; Tue, 19 Feb 2008 20:05:09 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802200156560.8333@wbgn129.biozentrum.uni-wuerzburg.de>
 (Johannes Schindelin's message of "Wed, 20 Feb 2008 02:01:34 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74491>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ...  If 
> in doubt, consult get_extended_base_var() in config.c.

Perhaps it is time for Documentation/technical/api-config.txt
;-)?
