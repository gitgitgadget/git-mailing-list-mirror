From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/WIP 0/2] Documentation clean-up: git commands
Date: Mon, 23 Mar 2009 15:31:16 +0100
Message-ID: <49C79D34.3000408@drmicha.warpmail.net>
References: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Mar 23 15:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LllD9-00070P-TT
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbZCWObe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755250AbZCWObe
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:31:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49178 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753047AbZCWObd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 10:31:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D20582F6699;
	Mon, 23 Mar 2009 10:31:31 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 23 Mar 2009 10:31:31 -0400
X-Sasl-enc: TCscnHAWorwYS3kX9ELHEv1K1Smsp828F05qpX2rGYV7 1237818691
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 313782B6E5;
	Mon, 23 Mar 2009 10:31:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090323 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114316>

Michael J Gruber venit, vidit, dixit 23.03.2009 15:28:
> In current git documentation, git commands are still written in various
> styles: with and without dash, unformatted and formatted with `, ' or ".
> 
> I propose to use `git command` consistently. In asciidoc, backticks are
> for commands, ticks for paths. [Quotes should be like ``this''.]
> 
> A first step is reaching a consistent use of backticks. A second step
> would be sed magic to get rid of the dashes in the text, not in the
> links (linkgit:...).
> 
> Patch 1 is a preparation patch where I spotted the use of a command with
> "git" in an instance where it looks very inconsistent. (It feels OK when

s/with/without/

Sorry :|
