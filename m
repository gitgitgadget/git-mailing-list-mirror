From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to run git-gui always in English?
Date: Tue, 30 Oct 2007 01:56:51 -0700
Message-ID: <7vbqahm14c.fsf@gitster.siamese.dyndns.org>
References: <CCAD0DE0-65D4-4FEC-B02F-658010FECD04@zib.de>
	<Pine.LNX.4.62.0710260857210.3542@perkele.intern.softwolves.pp.se>
	<20071026214124.GB3062@steel.home>
	<Pine.LNX.4.62.0710291357420.23695@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:57:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Immum-0007TS-67
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbXJ3I5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbXJ3I5E
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:57:04 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:54169 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbXJ3I5B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:57:01 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8F8DA2EF;
	Tue, 30 Oct 2007 04:57:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 992CC8F415;
	Tue, 30 Oct 2007 04:57:15 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.62.0710291357420.23695@perkele.intern.softwolves.pp.se>
	(Peter Karlsson's message of "Mon, 29 Oct 2007 13:58:26 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Peter Karlsson <peter@softwolves.pp.se> writes:

> Alex Riesen:
>
>> Because you do not send changes to a _server_. There is no
>> server. There is just another repo. Hence just "push"
>
> Fine. "Send to repository", then. My point is that if "push" is a
> technical term, then it doesn't belong in the GUI, and if it isn't,
> then it should be translated like any other UI element.

Why doesn't a "technical term" belong in the GUI in the first
place?

If majority of people who use git know and use the term "push"
to describe that concept, certainly they will be the people from
whom the new people who start to use git (either from command
line or from GUI) get help.  Why do you want to have them use
different language to make the communication more difficult?
