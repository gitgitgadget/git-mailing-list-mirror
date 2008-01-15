From: "Chris Ortman" <chrisortman@gmail.com>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 11:07:24 -0600
Message-ID: <c0f2d4110801150907y59593407u820c7b3db556ed31@mail.gmail.com>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	 <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	 <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	 <alpine.DEB.1.00.0801151612470.5289@eeepc-johanness>
	 <c0f2d4110801150823u7899e6dds1192b5f3bb3f7133@mail.gmail.com>
	 <alpine.DEB.1.00.0801151650240.5289@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 18:08:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEpGW-00043u-G3
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 18:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbYAORH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 12:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbYAORH0
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 12:07:26 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:24981 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYAORHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 12:07:25 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4434094wah.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 09:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=K4Y6JGc0Uu8XqXbstnr8EfhhsR7H/bL5T1WuAFIBgoo=;
        b=FArUgzeMylsZfWfSS4Bdx53wAKmjck7lyrxGGmfO44BeG4+VWsayrntFIzAwq/m+KXJb09QOUbR1qzXxeauuyol9uE3AWnGVgx/FINSdA8/y1PUysrJnLSj5ycsJthyWZYoQg8COFNUnmbqSL9iMOIuV+qL2cwL9x55MLx28KA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cQ3UJN0+mDAMN9c5IcfVVCtBgS04GANC1g3nbaxgzDs+W493m/fy81GECd/2LzRXP/MXFdi3sZZo2IyN8jhyC6rnFuByxq1bjI05lOyvgVUdjztGN3Y89D3LMvCOzR2IEaG5NP08RTokem2B7xiWrY/DypA+P9heQQRr4sDksvk=
Received: by 10.115.111.1 with SMTP id o1mr4298847wam.87.1200416844251;
        Tue, 15 Jan 2008 09:07:24 -0800 (PST)
Received: by 10.115.17.6 with HTTP; Tue, 15 Jan 2008 09:07:24 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0801151650240.5289@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70533>

Should this be a new command in git-svn.perl? or something in contrib?
