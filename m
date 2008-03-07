From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] git-submodule: New subcommand 'summary' (2) -
 hard work
Date: Fri, 07 Mar 2008 10:46:15 -0800
Message-ID: <7vwsoe1ifc.fsf@gitster.siamese.dyndns.org>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
 <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
 <7vabli7vhr.fsf@gitster.siamese.dyndns.org>
 <46dff0320803070850w290bfbe6hcdf74b20fcd7d8a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 19:47:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXhbM-0006b7-Jf
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 19:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762033AbYCGSqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 13:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761528AbYCGSqf
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 13:46:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757423AbYCGSqe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 13:46:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 04E0E3E62;
	Fri,  7 Mar 2008 13:46:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5F5CB3E3F; Fri,  7 Mar 2008 13:46:23 -0500 (EST)
In-Reply-To: <46dff0320803070850w290bfbe6hcdf74b20fcd7d8a4@mail.gmail.com>
 (Ping Yin's message of "Sat, 8 Mar 2008 00:50:01 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76514>

"Ping Yin" <pkufranky@gmail.com> writes:

> Actually, i need ^0....
> But what i want > to verify is that the sha1 is not just valid/unique
> but also belongs to the submodule repository.

Ah, I missed that.  Thanks for the clarification.

