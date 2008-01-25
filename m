From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git pull manpage: don't include -n from fetch-options.txt
Date: Thu, 24 Jan 2008 17:36:33 -0800
Message-ID: <7vfxwm8z4u.fsf@gitster.siamese.dyndns.org>
References: <72481CA3A5A6474EA49CFD2CF28A5D5D02CA348A@hektor.iplbath.com>
	<alpine.LSU.1.00.0801241058330.5731@racer.site>
	<20080124232418.GC4475@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 02:37:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIDVP-0002r4-FZ
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 02:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYAYBgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 20:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbYAYBgq
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 20:36:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbYAYBgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 20:36:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 033B537ED;
	Thu, 24 Jan 2008 20:36:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8639337D6;
	Thu, 24 Jan 2008 20:36:40 -0500 (EST)
In-Reply-To: <20080124232418.GC4475@genesis.frugalware.org> (Miklos Vajna's
	message of "Fri, 25 Jan 2008 00:24:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71673>

Miklos Vajna <vmiklos@frugalware.org> writes:

> The -n option stands for --no-summary in git pull

Ok, but does that mean --no-tags does not exist there?
