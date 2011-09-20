From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFCv4 1/4] Documentation: Preparation for gitweb manpages
Date: Tue, 20 Sep 2011 15:19:53 -0500
Message-ID: <20110920201953.GA11464@elie>
References: <1316352884-26193-1-git-send-email-jnareb@gmail.com>
 <1316352884-26193-2-git-send-email-jnareb@gmail.com>
 <20110919233703.GF6343@elie>
 <201109202211.06899.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 22:20:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66nZ-0000Af-VD
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 22:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab1ITUUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 16:20:04 -0400
Received: from mail-gw0-f47.google.com ([74.125.83.47]:40703 "EHLO
	mail-gw0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab1ITUUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 16:20:03 -0400
X-Greylist: delayed 57180 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Sep 2011 16:20:03 EDT
Received: by gwaa2 with SMTP id a2so983459gwa.6
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5cnq7v6hPnQDJd72iw5m8BVUMLvatnux7QLvEe7x2Po=;
        b=UP22rV6mlScTwDfC47X6wbZ7OzNVVSMWCHqmiwcb7b3YI1SrDiDvlL7laIgGwdY8s5
         Gg04/7gLCVzhHupvUIkQw4a09ZxrXkdk0kYp4KUhIqWtzezO0AT/EVb9vI3Gk/F6TJSU
         4sUI81XbAQYfY+GqsNzLwA/ZVDNDu0C6DOpYU=
Received: by 10.231.82.131 with SMTP id b3mr1952735ibl.74.1316550001893;
        Tue, 20 Sep 2011 13:20:01 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id ee29sm3498752ibb.9.2011.09.20.13.20.00
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Sep 2011 13:20:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201109202211.06899.jnareb@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181792>

Jakub Narebski wrote:

> I hope that this version is more clear:

Yep, it doesn't leave me confused any more.  Thanks, this looks good
(and sorry for my carelessness in reading the patch before).
