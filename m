From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 3/5] gitweb: Move "Requirements" up in gitweb/INSTALL
Date: Mon, 6 Jun 2011 15:05:10 -0500
Message-ID: <20110606200510.GC30588@elie>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
 <1307382271-7677-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>,
	Drew Northup <drew.northup@maine.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 22:05:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTg39-0007Qv-5k
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 22:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832Ab1FFUFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 16:05:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48162 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab1FFUFP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 16:05:15 -0400
Received: by iyb14 with SMTP id 14so3391054iyb.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 13:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5ENYpdFlJQEEOt0hL+1VYZ8sDbjgo4yStpAo0ay6R6I=;
        b=VpD4G5BD5BxmbyG7Y24FuqUF2j7UeMjgQWb0jlZ2C+q9ryDRBj5kjHUGEoU4RYdsIS
         WaAeoY2zGRH+HcSHBUCNzMJCs55FLlBg1cWl0AroAU6J1VA5CW7ctnGgC6LIanx/TEiI
         WWFVKiJS0FHpzgbxg8EOExoJF+hvGacqsAy7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JcZLgYPVKApAfvQN0ZyxGEMXKqgFvdBru4I8M5pufipseU0pJPtOlxAnVt7V/I+LUv
         38vylkPYm4dtPkwMvI3YJi0UThShhRsH3uD2/ZYOoOkoCEDMq0aoAc/A+DzfVLZwAiKa
         4OzkjBEGQREs+kH9dzkmOHO7YV2Q4N7p9ulds=
Received: by 10.42.100.141 with SMTP id a13mr8452989ico.72.1307390714570;
        Mon, 06 Jun 2011 13:05:14 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.sbcglobal.net [68.255.97.40])
        by mx.google.com with ESMTPS id s2sm2962367icw.17.2011.06.06.13.05.12
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 13:05:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307382271-7677-4-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175160>

Jakub Narebski wrote:

> This way you can examine prerequisites at first glance

Yes, good idea.
