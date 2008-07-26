From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] Set up argv0_path correctly, even when argv[0] is just
 the basename
Date: Sat, 26 Jul 2008 17:53:12 +0200
Message-ID: <488B4868.4030405@keyaccess.nl>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness> <488B3A97.6000606@keyaccess.nl> <alpine.DEB.1.00.0807261709090.26810@eeepc-johanness> <488B409D.40709@keyaccess.nl> <alpine.DEB.1.00.0807261732500.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 17:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMm3q-0007hT-I2
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbYGZPuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 11:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbYGZPuz
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:50:55 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:56090 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbYGZPuy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:50:54 -0400
Received: from [213.51.130.188] (port=49652 helo=smtp3.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KMm2h-0005I0-Tc; Sat, 26 Jul 2008 17:50:47 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:56273 helo=[192.168.0.3])
	by smtp3.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KMm2h-0007oM-Ml; Sat, 26 Jul 2008 17:50:47 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <alpine.DEB.1.00.0807261732500.26810@eeepc-johanness>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90249>

On 26-07-08 17:35, Johannes Schindelin wrote:

> And it is totally bogus to think about the complicated issues when
> the "weakest link of the chain" is much easier to exploit.

/me tips hat and unsubscribes again.

Rene.
