From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incorrect default for git stash?
Date: Tue, 17 Jun 2008 15:32:01 -0700
Message-ID: <7v1w2v66ce.fsf@gitster.siamese.dyndns.org>
References: <loom.20080617T220852-922@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:33:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8jjz-0005am-4S
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 00:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760451AbYFQWcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 18:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759417AbYFQWcP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 18:32:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759396AbYFQWcO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 18:32:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8392D11809;
	Tue, 17 Jun 2008 18:32:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2038D11805; Tue, 17 Jun 2008 18:32:03 -0400 (EDT)
In-Reply-To: <loom.20080617T220852-922@post.gmane.org> (Eric Raible's message
 of "Tue, 17 Jun 2008 22:21:23 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 39AF4E18-3CBD-11DD-97BE-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85336>

Eric Raible <raible@gmail.com> writes:

> Does it bother anyone else that the default for
> git stash is inconsistent with branch & tag?
>
> git branch -> list branches
> git tag    -> list tags
> git stash  -> create a stash
>
> I understand that branches & tags must explicitly named
> and that stashes are by default automatically named.
>
> But wouldn't it be less surprising to me if the default
> was 'list' instead of 'save'?
>
> - Eric

Read the whole thread:

http://thread.gmane.org/gmane.comp.version-control.git/63566/focus=63784
