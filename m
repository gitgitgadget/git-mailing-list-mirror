From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: git commit should list --interactive
Date: Fri, 19 Sep 2008 19:44:04 -0700
Message-ID: <7vzlm35yff.fsf@gitster.siamese.dyndns.org>
References: <279b37b20809101740v4a8f19b8k395208c124af0de0@mail.gmail.com>
 <20080920011654.GI13139@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 20 04:45:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgsTK-00045b-6z
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 04:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbYITCoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 22:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbYITCoN
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 22:44:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbYITCoM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 22:44:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 43DEB63453;
	Fri, 19 Sep 2008 22:44:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A61E663451; Fri, 19 Sep 2008 22:44:06 -0400 (EDT)
In-Reply-To: <20080920011654.GI13139@spearce.org> (Shawn O. Pearce's message
 of "Fri, 19 Sep 2008 18:16:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0094EE8A-86BE-11DD-9CF0-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96333>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Eric Raible <raible@gmail.com> wrote:
>> Signed-off-by: Eric Raible <raible@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> Trivally-Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
> Sorry, got backlogged at day-job.  I'm kind of surprised this isn't
> in-tree yet, its pretty simple...

Heh, I am kind of surprised this hasn't been Acked yet.  IOW, you do not
have monopoly on getting backlogged at dayjob.

Will apply, thanks both.
