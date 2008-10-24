From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: git adds some text file as binary file by mistake
Date: Fri, 24 Oct 2008 14:34:34 +0100
Message-ID: <80tzb2xgk5.fsf@tiny.isode.net>
References: <46dff0320810240537i4f0d86b9p56def9ef6a69c180@mail.gmail.com>
            <4901C58D.4010309@drmicha.warpmail.net>
            <46dff0320810240630s5cbfa62esd10a9da45ce37bf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 15:36:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtMpS-0005aE-A3
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 15:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYJXNei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbYJXNei
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 09:34:38 -0400
Received: from rufus.isode.com ([62.3.217.251]:46893 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbYJXNeh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 09:34:37 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SQHO6gAJ9zh=@rufus.isode.com>; Fri, 24 Oct 2008 14:34:34 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Fri, 24 Oct 2008 14:34:34 +0100
X-Hashcash: 1:20:081024:pkufranky@gmail.com::1EU3ewU4GaTKLFZR:0000000000000000000000000000000000000000000xqp
X-Hashcash: 1:20:081024:git@drmicha.warpmail.net::NA0ggj3NFynFOqnY:0000000000000000000000000000000000000C/dI
X-Hashcash: 1:20:081024:git@vger.kernel.org::iQtsyASpvUWE30dK:0000000000000000000000000000000000000000001CVP
In-Reply-To: <46dff0320810240630s5cbfa62esd10a9da45ce37bf8@mail.gmail.com> (Ping Yin's message of "Fri\, 24 Oct 2008 21\:30\:19 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99034>

"Ping Yin" <pkufranky@gmail.com> writes:

[...]

> I'm just ask this problem in general sense. So is there a general way
> to specify whether  a file is text or binary?

Yes: gitattributes(5).
