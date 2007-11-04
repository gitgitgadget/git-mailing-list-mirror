From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk graph routing problem
Date: Sun, 04 Nov 2007 15:14:29 -0800
Message-ID: <7vzlxtr4bu.fsf@gitster.siamese.dyndns.org>
References: <20071104104618.GA3078@steel.home>
	<18222.15870.945694.238217@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 00:14:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoogB-0007jU-Uf
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 00:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbXKDXOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 18:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753752AbXKDXOl
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 18:14:41 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37728 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbXKDXOl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 18:14:41 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8B6772EF;
	Sun,  4 Nov 2007 18:15:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2DB8E923B7;
	Sun,  4 Nov 2007 18:14:59 -0500 (EST)
In-Reply-To: <18222.15870.945694.238217@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Mon, 5 Nov 2007 08:47:42 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63457>

Paul Mackerras <paulus@samba.org> writes:

> Alex Riesen writes:
>
>> To reproduce, try running in git repo:
>> 
>>     gitk 02f630448e5d48e..06ea6ba9cf46ef5
>
> I can't reproduce it here, as my clone of the git repo doesn't have
> 02f630448e5d48e in it, even after updating...

Heh, me neither ;-).
