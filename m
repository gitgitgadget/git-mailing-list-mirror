From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add more instructions about how to install git.
Date: Tue, 08 Sep 2009 16:38:12 +0200
Message-ID: <4AA66C54.4060101@viscovery.net>
References: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>	 <81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com>	 <vpqhbvekldk.fsf@bauges.imag.fr> <a4c8a6d00909080724q1c792f6bs641ea9d000d08b5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 16:38:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml1py-00061z-Sl
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 16:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbZIHOiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 10:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbZIHOiN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 10:38:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34213 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZIHOiM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 10:38:12 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ml1pk-0004Gp-Mf; Tue, 08 Sep 2009 16:38:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 76A429F88; Tue,  8 Sep 2009 16:38:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <a4c8a6d00909080724q1c792f6bs641ea9d000d08b5a@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128010>

Thiago Farina schrieb:
> I tried to being more explicit about what the new users has to do. The
> first instruction that the text says is: "Normaly you can just do
> "make"".
> But the new user, cloning git won't have a configure file, so he can't
> just do "make".
> 
> And then, the text says: "so you can write instead". This brings me to
> one alternative (not what I really should do), when in fact it should
> be (I guess) the first instructions that new users need to follow.

Then guessed wrong. You really only have to say "make". The use of
autoconf and ./configure is purely optional and not necessary.

-- Hannes
