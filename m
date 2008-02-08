From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a file
Date: Fri, 08 Feb 2008 13:19:19 -0800
Message-ID: <7vwspfi1t4.fsf@gitster.siamese.dyndns.org>
References: <20080208174654.2e9e679c@pc09.procura.nl>
	<118833cc0802081215t380587f6w7b5c0aba66a55799@mail.gmail.com>
	<7v8x1vjiic.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0802082040010.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:20:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNae1-0003cC-8T
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758259AbYBHVTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 16:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757630AbYBHVTq
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:19:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758025AbYBHVTp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 16:19:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C5286C8A;
	Fri,  8 Feb 2008 16:19:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CFBB36C87;
	Fri,  8 Feb 2008 16:19:36 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802082040010.11591@racer.site> (Johannes
	Schindelin's message of "Fri, 8 Feb 2008 20:40:26 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73148>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 8 Feb 2008, Junio C Hamano wrote:
>
>> 	#ifdef FOPEN_OPENS_DIRECTORIES
>
> Funny... our emails crossed, and you picked the same name ;-)

Bad Dscho.

It has been a very well kept secret that Dscho and Junio are one
and the same person, but you just spilled the beans.

;-)
