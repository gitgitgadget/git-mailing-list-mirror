From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: [PATCH] git-mergetool: print filename when it contains %
Date: Fri, 8 Feb 2013 15:58:54 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1302081558130.23245@rose.makesad.us>
References: <1360286184-14278-1-git-send-email-asheesh@asheesh.org> <7vhalm3e54.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 21:59:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3v2b-00024i-7o
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947070Ab3BHU7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:59:00 -0500
Received: from rose.makesad.us ([199.199.210.158]:49417 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947017Ab3BHU67 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 15:58:59 -0500
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTPS id 8AEA23FCC857
	for <git@vger.kernel.org>; Fri,  8 Feb 2013 15:58:54 -0500 (EST)
In-Reply-To: <7vhalm3e54.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215818>

On Fri, 8 Feb 2013, Junio C Hamano wrote:

> Asheesh Laroia <asheesh@asheesh.org> writes:
>
>> Before this change, if git-mergetool was invoked with regard to
>
> Drop "before this change,"; it is clear (and it is a recommended
> practice) you are first describing what problem you are addressing.
>

Junio, thanks for the quick reply! I agree with your suggestions, and will 
take a look at addressing them, hopefully by Tuesday or so.

-- Asheesh.
