From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and 
 --prune-empty.
Date: Sun, 11 Jan 2009 12:52:20 -0800
Message-ID: <7vab9xsgzf.fsf@gitster.siamese.dyndns.org>
References: <20081030132623.GC24098@artemis.corp>
 <1225445204-28000-1-git-send-email-madcoder@debian.org>
 <7viqr5wgl7.fsf@gitster.siamese.dyndns.org>
 <20081103092729.GE13930@artemis.corp> <20081103151826.GJ13930@artemis.corp>
 <76718490901091129q534ca981iac54e0653d76170d@mail.gmail.com>
 <20090111111800.GA8032@artemis.corp>
 <alpine.DEB.1.00.0901111433580.3586@pacific.mpi-cbg.de>
 <20090111142732.GA18484@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	pasky@suse.cz, srabbelier@gmail.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM7Ji-0002jL-74
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbZAKUwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbZAKUwd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:52:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbZAKUwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:52:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 505AA8FB13;
	Sun, 11 Jan 2009 15:52:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E6B788FB0F; Sun,
 11 Jan 2009 15:52:21 -0500 (EST)
In-Reply-To: <20090111142732.GA18484@artemis.corp> (Pierre Habouzit's message
 of "Sun, 11 Jan 2009 15:27:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2871FA6-E021-11DD-9BA0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105225>

Pierre Habouzit <madcoder@debian.org> writes:

> On Sun, Jan 11, 2009 at 01:35:15PM +0000, Johannes Schindelin wrote:
> ...
>> And I suggested to merge the tests with Sverre's patch.  That suggestion 
>> also went unaddressed.
>
> I can't find any mails from Sverre in the same thread, but maybe I'm not
> searching in the proper place...

This is in 'master' already; if there was anything missing in your patch,
please fill in with updates.
