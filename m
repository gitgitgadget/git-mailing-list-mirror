From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Use "git <command>" instead of dashed form in sample hooks
Date: Sun, 15 Feb 2009 19:19:48 +0200
Message-ID: <87y6w7r51n.fsf@iki.fi>
References: <1234717348-20228-1-git-send-email-tlikonen@iki.fi>
	<alpine.DEB.1.00.0902151807010.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 18:21:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYkgY-0006Ot-JN
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 18:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbZBORUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 12:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbZBORUL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 12:20:11 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:55593 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531AbZBORUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 12:20:08 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48FC5AC9051B99C8; Sun, 15 Feb 2009 19:20:04 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LYkei-0005II-4J; Sun, 15 Feb 2009 19:19:48 +0200
In-Reply-To: <alpine.DEB.1.00.0902151807010.10279@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Sun\, 15 Feb 2009 18\:10\:38 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110025>

On 2009-02-15 18:10 (+0100), Johannes Schindelin wrote:

> AFAIR, GIT_EXEC_PATH will be added to the PATH before calling the hook.  
> So this is not the fix you claim it to be.
>
> But I agree that it is a nice cleanup to use undashed commands in the 
> hooks (if only to make testing easier).

Ah, OK. Let's say it's an "inconsistency fix", then. :-)
