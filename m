From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow git-am to run in a subdirectory
Date: Sat, 01 Mar 2008 00:15:39 -0800
Message-ID: <7vabli6es4.fsf@gitster.siamese.dyndns.org>
References: <20080301062255.GA27538@coredump.intra.peff.net>
 <7vprue6ghc.fsf@gitster.siamese.dyndns.org>
 <20080301081235.GA31855@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 01 09:16:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMtM-0003gW-9D
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 09:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbYCAIPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 03:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbYCAIPs
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 03:15:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbYCAIPr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 03:15:47 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3215916F9;
	Sat,  1 Mar 2008 03:15:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A318416F8; Sat,  1 Mar 2008 03:15:42 -0500 (EST)
In-Reply-To: <20080301081235.GA31855@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 1 Mar 2008 03:12:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75640>

Sorry for making you do an extra work.  I hoped ;-) was explicit enough
but apparently it was not...
