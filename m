From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 13:59:39 -0800
Message-ID: <e26d18e40802191359r4c435818n4ae7b357d452d51e@mail.gmail.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
	 <47BB1EC0.601@freescale.com>
	 <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>
	 <alpine.LSU.1.00.0802191916020.7797@racer.site>
	 <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com>
	 <alpine.LSU.1.00.0802191940260.7826@racer.site>
	 <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
	 <47BB3691.9040809@freescale.com>
	 <e26d18e40802191305y5f7b8fdfr3113c84612c53189@mail.gmail.com>
	 <47BB5037.5090302@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
To: "Jon Loeliger" <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 23:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRaVo-0007hp-51
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 23:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbYBSV7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbYBSV7m
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:59:42 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:32948 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118AbYBSV7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:59:41 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3707911wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 13:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HxuFsAU4AU8Iwp4XgbXQgBVb9ma1wxOTSjbNL4DQgAU=;
        b=i88ejlyhXWqO0XZwTvqF9Ya3VggEZcMYwrvhoLr0gA75C3zKDvOvfmQNfhPrvu9vLXRrObS7yPKtw3qElOoKkzK5bvpQmEN2rYYjoANiHy7vqn9UBf8jSOEvzpriD5YBLwKzqEhuO5k37EkR8q7P/TM+JArJ+Rz9m7DSrAXPF7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rdS4OzLyu73CqOiFCffTMNqUL6ItNugXpmt7tdaOIb6fKa6aCyatL0sgqjYTZmHGTtQO/Ni4nCHPtkUGv2F4EYeWk0/nnzFOd+rD9OnIIuc9pACWWXnalPC+qZ1oUI0eQf7eDEosKAXzhpOnd+SJwIDt+il4PppLrL8As8m4LKw=
Received: by 10.114.153.18 with SMTP id a18mr1181763wae.82.1203458379737;
        Tue, 19 Feb 2008 13:59:39 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Tue, 19 Feb 2008 13:59:39 -0800 (PST)
In-Reply-To: <47BB5037.5090302@freescale.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74464>

> Something is fishy here.  Is your repository bare or not?

no, why does it need to be bare?
