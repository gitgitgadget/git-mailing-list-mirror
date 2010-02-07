From: Matt Di Pasquale <liveloveprosper@gmail.com>
Subject: Re: how to apply patch?
Date: Sun, 7 Feb 2010 01:06:10 -0500
Message-ID: <13f0168a1002062206p8da7dd0n5f1b353c33b344f3@mail.gmail.com>
References: <13f0168a1002061720t93ff6aew3420a41a547549d8@mail.gmail.com> 
	<13f0168a1002061805o5d64c05cy9d8f0190a8f37feb@mail.gmail.com> 
	<be6fef0d1002062040x6556b73fvb2a62a85fe21ec9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 07:12:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne0Nw-0001xL-F2
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 07:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab0BGGGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 01:06:33 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:33269 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab0BGGGc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 01:06:32 -0500
Received: by wwi18 with SMTP id 18so1194651wwi.19
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 22:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=nVzEQCLeEs5U6+3KsUPmkEJFRr2+MnJlR0VpCEjVXzQ=;
        b=cki9CJI/KqnsKAkdA7IKBjz27ADyqAdrOGaEnSgov+WS1pAL3R+qvJMRdeLL6F+Qbh
         lxRk8nYQONX/qmfmQyhQQZGVMeNNmhn0r/b2VsjVjcmVO4IErhbRIZBVhezZOrn0BPds
         q25QUn8dOX/5uurr2S+6nXr8TPYU9+rFAdGk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OOklGoFVazYIm3zo1kGqjzm3BtBIhBvm7aGprgM30N8RFEoltB0a0bNA58b1n/P1kq
         Sz0/Qu3olcFiGTTPJwwzMFQOqvwotc6P+h4MWRy7h9Ena0TLC7Kw8pW5ergVKyZ1ZNav
         dtSJnya1TmIULeU7TEH8L8ZxyS5yz3s5UoIow=
Received: by 10.216.184.205 with SMTP id s55mr2761969wem.149.1265522790743; 
	Sat, 06 Feb 2010 22:06:30 -0800 (PST)
In-Reply-To: <be6fef0d1002062040x6556b73fvb2a62a85fe21ec9e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139221>

Hi Ray,

Thanks for your response. I don't understand how that will transfer my
latest changes in ./dev into ./www while preserving the fundamental
differences between the 2 directories. Could you please provide some
explanation?

Also, is there an easy way to do something like this with a branch
instead of a remote? Remote doesn't make sense to me conceptually (and
I already have a remote repo setup that I push to from master). Maybe
I should have 2 different branches? One for dev & one for pro. How
would I do that?

Thanks,

-Matt
