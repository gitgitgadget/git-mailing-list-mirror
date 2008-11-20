From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [TopGit PATCH] README: Fix spelling
Date: Thu, 20 Nov 2008 15:23:51 +0100
Message-ID: <2c6b72b30811200623t3326f69bu4c8570a3c41cc764@mail.gmail.com>
References: <1227189062-11951-1-git-send-email-fonseca@diku.dk>
	 <2c6b72b30811200552h46004299w881ad61134ec5555@mail.gmail.com>
	 <20081120141725.GB25425@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "martin f krafft" <madduck@debian.org>
X-From: git-owner@vger.kernel.org Thu Nov 20 15:25:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3ATE-0003tb-IJ
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbYKTOXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 09:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755657AbYKTOXz
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 09:23:55 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:2996 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbYKTOXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 09:23:53 -0500
Received: by mu-out-0910.google.com with SMTP id g7so459721muf.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 06:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=n6yXSkYwueBB+ZXa0Dp23RJBAkYnNiW8rDSpvO3NF6o=;
        b=WK9ipobiE6TusjygafRIyiFxqnapaRXIHLTckB87h/riYABuGUlmMJq0fgeIi3YbKh
         qtdpN9JUru7BLKbKdWseDvDfoFCVgoYX4ZNpyLaY+fABs1chM1xs9+NdkxVRBAQ7AWEV
         KbSRmvA3dCc55qiI26M/LOEKg3wcH4BGL3sA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rpwCqXDmNU7Y3tcIxfvVymKsPn0Ao2n7n7T//vtVgj2eiJd6L3eVCCMRDnFj4R33M6
         UnFVflGcVzvv7aYpQoOVHMV6xMapIU+ecfoyIZZ5TY9709Wrrvl10h7T0NOhU83yCEKU
         t/MYwt19H0/0zEkysyiZPR9Yo/4dxF+SFW5C0=
Received: by 10.181.219.15 with SMTP id w15mr743828bkq.90.1227191031443;
        Thu, 20 Nov 2008 06:23:51 -0800 (PST)
Received: by 10.181.195.3 with HTTP; Thu, 20 Nov 2008 06:23:51 -0800 (PST)
In-Reply-To: <20081120141725.GB25425@piper.oerlikon.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101440>

On Thu, Nov 20, 2008 at 15:17, martin f krafft <madduck@debian.org> wrote:
> also sprach Jonas Fonseca <jonas.fonseca@gmail.com> [2008.11.20.1452 +0100]:
>> Oops sorry about this one!!! :-/
>
> What about it? The patch seems perfectly alright. Only the quoted
> version is broken, which I think is your fault.

Well, it looks very broken in Gmail ...

> Should I apply the README patch?

Yes, if you can salvage it. Else it is also available in branch
jf/readme-update at

  git://repo.or.cz/topgit/fonseca.git

-- 
Jonas Fonseca
