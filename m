From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Write index file on any checkout of files
Date: Thu, 28 Feb 2008 13:44:50 -0800
Message-ID: <7vablkhi25.fsf@gitster.siamese.dyndns.org>
References: <87wsop188j.fsf@wine.dyndns.org>
 <alpine.LNX.1.00.0802281058190.19665@iabervon.org>
 <7vfxvcj0b7.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802281547320.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 22:45:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUqZU-0008MQ-1X
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbYB1VpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbYB1VpI
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:45:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbYB1VpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:45:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F07801900;
	Thu, 28 Feb 2008 16:45:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5EB06189F; Thu, 28 Feb 2008 16:44:59 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802281547320.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 28 Feb 2008 16:21:33 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75464>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Yeah, that's a better organization, and makes the code nice. Want it as a 
> replacement patch or as an additional patch on top of this one?

Thanks.  Replacement would be nice, as I do look at patches
during my lunchtime but not apply them until evening, on my
day-job days.
