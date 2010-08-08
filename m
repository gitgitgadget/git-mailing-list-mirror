From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: git log --stat FILE
Date: Sun, 08 Aug 2010 14:04:27 +0200
Message-ID: <yf9d3tts438.fsf@chiyo.mc.pp.se>
References: <yf9wrs1fili.fsf@chiyo.mc.pp.se>
	<AANLkTikKwp9gS9nt=JnsdyXMgx+PxrhHhNFftYFqX+M_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 14:04:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi4cG-00050e-Hp
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 14:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab0HHMEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 08:04:32 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:32954 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab0HHMEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 08:04:30 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id D712EE93C;
	Sun,  8 Aug 2010 14:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1281269068; bh=C8IuDqMiMSpeNNaolPkG5hIZCQ1lCe+U7R5nXXGN2xY=;
	h=To:Cc:Subject:References:From:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rgF5b3T/HBY22ZmpsHSojfXNDJMoVzHL60u2J
	tIlbA/RBhtLQYnFFtWbOKCBCUC/dT0/tcyRdvI1JkQVGLYtXuE0LODU4LI4ybQZvjk2
	yrZgPpe7eryr5CDEqeXWc8EGfZxXc3rc0PBV/m+Z1MHujP4dk+cajZy7w/d77Stvhw4
	=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@mc.pp.se>)
	id 1Oi4c7-00056J-Q5; Sun, 08 Aug 2010 14:04:27 +0200
In-Reply-To: <AANLkTikKwp9gS9nt=JnsdyXMgx+PxrhHhNFftYFqX+M_@mail.gmail.com> (Lars Hjemli's message of "Sun, 8 Aug 2010 13:54:59 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152902>


Thanks guys.

I suspected there was some option I had missed.  :-)

Both the option name and the documentaion mention only diffs, not
stats, which makes it a bit hard to find...


  // Marcus
