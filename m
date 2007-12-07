From: Mike Hommey <mh@glandium.org>
Subject: Re: [RFC/PATCH] Add a --nosort option to pack-objects
Date: Fri, 7 Dec 2007 22:46:27 +0100
Organization: glandium.org
Message-ID: <20071207214627.GB13170@glandium.org>
References: <1197061832-8489-1-git-send-email-mh@glandium.org> <7v4peu19kr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:47:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0l2i-00065N-9H
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbXLGVrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753696AbXLGVrL
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:47:11 -0500
Received: from smtp20.orange.fr ([193.252.22.31]:11632 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535AbXLGVrK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:47:10 -0500
Received: from smtp20.orange.fr (mwinf2013 [172.22.130.41])
	by mwinf2020.orange.fr (SMTP Server) with ESMTP id A9DEE1D5771E
	for <git@vger.kernel.org>; Fri,  7 Dec 2007 22:47:09 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2013.orange.fr (SMTP Server) with ESMTP id D2D751C0009D
	for <git@vger.kernel.org>; Fri,  7 Dec 2007 22:46:27 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2013.orange.fr (SMTP Server) with ESMTP id BD48D1C0009A;
	Fri,  7 Dec 2007 22:46:27 +0100 (CET)
X-ME-UUID: 20071207214627775.BD48D1C0009A@mwinf2013.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J0l1f-00070r-7y; Fri, 07 Dec 2007 22:46:27 +0100
Content-Disposition: inline
In-Reply-To: <7v4peu19kr.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67474>

On Fri, Dec 07, 2007 at 01:25:24PM -0800, Junio C Hamano wrote:
> I need to rant here a bit.
> 
> Sometimes people say "Here is my patch.  If this is accepted, I'll add
> documentation and tests".  My reaction is, "Don't you, as the person who
> proposes that change, believe in your patch deeply enough yourself to be
> willing to perfect it, to make it suitable for consumption by the
> general public, whether it is included in my tree or not?  A change that
> even you do not believe in deeply enough probably to perfect would not
> benefit the general public, so thanks but no thanks, I'll pass."

As you can seen from my other message, I'm *actually* not sure this is
really material for git as a VCS. I will add documentation unrelated to
--nosort to pack-objects anyways.

Mike
