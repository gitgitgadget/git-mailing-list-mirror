From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 0/2] Make git-completion Bash 4 compatible
Date: Wed, 1 Dec 2010 15:09:10 -0600
Message-ID: <20101201210910.GD27845@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 22:09:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNtvY-000348-Q5
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 22:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757051Ab0LAVJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 16:09:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59380 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186Ab0LAVJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 16:09:19 -0500
Received: by fxm20 with SMTP id 20so494179fxm.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 13:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OqH/wsTf6qfyQpZ3o2SMwCmchxoDO3FPDJo+x/ciz0o=;
        b=Z7eFTV9PA6vkIdC6LEiSYbN2rLBJtp2DlawInYskJHWO1owGl8Jyi7vPUAsmkRScQ0
         0TXlUHBLRluBcs0c92SC/VzuzlRvxrJ5SPtjfkpp2ESnPmUMXHTWZkHK+47mJEv1qL3v
         WHVx3LeyKSbY0St+wjKaddceOpy50CYOP8EZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n3d8/I07EF/qSIElJXD3yDj0DBrX2cThg+JTYggWJFyPBRMKHFaYJI0HSTQTvqP0d9
         hjAhdq0Bz7tN79MY8S9TDdsYMDlLSt07F0Z8rxo8NpaiGRJlIvoXzYwMAv5U5IxLGMja
         PalKK+dKP3P/kP7mejG7o78qmDGL3JX6sm9D0=
Received: by 10.223.97.13 with SMTP id j13mr8828478fan.146.1291237758337;
        Wed, 01 Dec 2010 13:09:18 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id l14sm204291fan.33.2010.12.01.13.09.17
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 13:09:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162615>

Peter van der Does wrote:

> - Patch is based upon the next branch.

Please don't do that.  Documentation/SubmittingPatches explains
(section "(0) Decide what to base your work on").

> - Grammatical error in commit message

Thanks, I'll look over this version then.
