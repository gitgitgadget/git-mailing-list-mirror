From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 15:47:59 -0700
Message-ID: <7v1w1cb940.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
 <alpine.LNX.1.00.0807291716460.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:49:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNy0G-0000Cc-DD
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbYG2WsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 18:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755291AbYG2WsI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:48:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbYG2WsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 18:48:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F010E4A1F2;
	Tue, 29 Jul 2008 18:48:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 40D5F4A1F1; Tue, 29 Jul 2008 18:48:01 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0807291716460.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 29 Jul 2008 18:34:31 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 67ED7632-5DC0-11DD-983C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90699>

Daniel Barkalow <barkalow@iabervon.org> writes:

> In particular, I think it's really useful to show a commit graph with 
> branching and merging, and introduce refs as movable pointers to commits 
> in the graph, and local branches as refs that you move and tracking refs 
> as refs that copy values in other repositories.

I'd very strongly second this.  If somebody is really into screencasts
(and especially from the Ruby circle, I would guess), this may be worth
a look:

    http://excess.org/article/2008/07/ogre-git-tutorial/

I saw a couple of technical inaccuracies in the presentation (I do not
expect any presentation or screencast to be perfect; I've never seen one
without any technical error anyway, perhaps other than my own at OLS a few
years ago), but otherwise it was very well done.  Espcially the part that
builds the commit ancestry chains I was very happy to see it taught like
so.
