From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git adds some text file as binary file by mistake
Date: Fri, 24 Oct 2008 14:54:37 +0200
Message-ID: <4901C58D.4010309@drmicha.warpmail.net>
References: <46dff0320810240537i4f0d86b9p56def9ef6a69c180@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 14:56:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtMCp-0006wH-7A
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 14:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbYJXMym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 08:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbYJXMym
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 08:54:42 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57957 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269AbYJXMyl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 08:54:41 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 70102166BC4;
	Fri, 24 Oct 2008 08:54:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 24 Oct 2008 08:54:40 -0400
X-Sasl-enc: cg47VEvABCyv3Fc4egc4UR6HWqdD7RS2NJKS3aptDqGf 1224852880
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ABAA41C001;
	Fri, 24 Oct 2008 08:54:39 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <46dff0320810240537i4f0d86b9p56def9ef6a69c180@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99032>

Ping Yin venit, vidit, dixit 24.10.2008 14:37:
> So what should i do if i want it added as text file?

You should give us more detail on the file ;)
What's the extension, what's the typical content? It may be a simple
matter of specifying attributes.
Do ordinary diff and grep recognize your files as text?

Michael
